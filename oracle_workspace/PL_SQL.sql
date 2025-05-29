select * from member;
select * from goods;
select * from orders;
select * from ordersDetail;

-- PL/SQL
-- oracle에서 사용하는 절차식 언어
-- 일반 쿼리문은 한개의 명령문이 실행.
-- 일반적인 프로그래밍언어와 비슷하게 변수, 조건문, 반복문 등으로 로직구현 가능
-- stored procedure, user defined function, trigger 등을 만들어서 사용

-- oracle pl/sql에서는 select ~ from 절로 출력할 수 없음

set serveroutput on; -- 접속할 때마다 먼저 실행. pl/sql에서 print 허용

declare
    v_name varchar(50); -- 변수
begin
    v_name := '홍길동';
    dbms_output.put_line(v_name); -- 개발자/관리자 확인용. 응용프로그램에서 출력된 값을 받을 수 없음. 테이블형태가 아님. console.log비슷
end;

select '홍길동' as name from dual;  -- 테이블형태로 출력. 응용프로그램에서 출력된 값을 받을 수 있음.

--------------------------------------------------------------------------------
declare
    v_id member.id%type; -- member테이블의 id와 같은 타입
begin
    select id into v_id --  id값을 v_id에 저장. id값이 1개여야 가능
    from member where name='홍길동';
    dbms_output.put_line(v_id);  -- js의 console.log()와 비슷한 역할
    -- v_id 변수값을 이용한 코드가 이어짐
end;


insert into member values('hgd','홍길동','hgd@hgd.com');
insert into member values('hgd','홍길동','m','2025-05-05');
commit;

select * from member;
--------------------------------------------------------------------------------
-- cursor. pl/sql에서 select한 결과가 여러행일 때 한 행씩 처리하기 위해서 사용
-- cursor정의 -> open -> fetch -> close 순으로 처리
declare
    -- 1.cursor정의
    cursor member_cur
    is
    select id from member where name='홍길동';
    
    v_id member.id%type;
begin
    -- 2. cursor open
    open member_cur;
    -- 3. fetch cursor. fetch는 커서를 이용해서 한 행씩 읽어오는 작업.
    loop
        fetch member_cur into v_id;
        exit when member_cur%notfound; -- 값이 없으면 loop중지
        dbms_output.put_line(v_id); -- 디버깅용.
        
        -- 만약 id가 'hkd'이면 이사람에게 포인트를 더 해 준다면 이런 작업을 이어서 할 수 있음
        
    end loop;
    -- 4. cursor close
    close member_cur;    
end;

select * from member;
--------------------------------------------------------------------------------
-- stored procedure. 저장프로시져. procedure를 이름을 붙여서 저장
-- 함수처럼 호출하면 실행. parameter는 'in', return값은 'out'을 변수에 붙여서 사용
-- stored procedure를 scheduler를 사용 하면 예약된 시간에 실행 가능
-- => 스프링같은 경우 scheduler 라이브러리 사용
create or replace procedure proc1(
    p_name in member.name%type
)
as
 -- 1.cursor정의
    cursor member_cur
    is
    select id from member where name=p_name;
    
    v_id member.id%type;
begin
    -- 2. cursor open
    open member_cur;
    -- 3. fetch cursor. fetch는 커서를 이용해서 한 행씩 읽어오는 작업.
    loop
        fetch member_cur into v_id;
        exit when member_cur%notfound; -- 값이 없으면 loop중지
        dbms_output.put_line(v_id); -- 디버깅용.
        
        -- 만약 id가 'hkd'이면 이사람에게 포인트를 더 해 준다면 이런 작업을 이어서 할 수 있음
        
    end loop;
    -- 4. cursor close
    close member_cur;    
end;

begin 
    proc1('왕건');  -- 프로시져호출
end;

execute proc1('왕건'); -- 프로시져호출
--------------------------------------------------------------------------------
-- 연도별 상품판매 갯수의 합
create table statistics_year(
    year char(4) primary key,
    total number not null
);

select * from statistics_year;

create or replace procedure proc2(
    p_year in char
)
as     
begin   
    insert into statistics_year
    select p_year, sum(ordersDetail.ea) 
    from orders,ordersDetail
    where orders.ono=ordersDetail.ono
    and to_char(orders.orderdate,'YYYY')=p_year;
    
    commit;
end;
--------------------------------------------------------------------------------
execute proc2('2006');

select * from statistics_year;

select * from orders;
commit;
--------------------------------------------------------------------------------
-- create function 
create or replace function fn_name(p_id varchar2)
return varchar2
is
    v_name member.id%type;
begin
    select name into v_name
    from member
    where id=p_id;
    
    return v_name;
end;

select ono, id, fn_name(id) as name
from orders;
--------------------------------------------------------------------------------
-- Trigger
-- 특정 이벤트(특정 테이블에서 insert,update,delete)가 발생하면 자동으로 호출되는 프로시져
-- Trigger가 실행 된 후 에러가 나지 않으면 자동 commit, 에러가 나면 자동 rollback
-- Trigger를 발생 시킨 이벤트 부터 같은 transaction으로 묶임.
-- :new. 새로운 행이 저장됨(insert, update시). Trigger내부에서만 사용
-- :old. 이전 행이 저장됨(delete, update시). Trigger내부에서만 사용
-- DB입장에서는 로드가 많이 걸리는 객체. 트리거로 작업이 꼭 필요한지 판단해서 사용
-- 서버응용프로그램에서도 비슷한 처리가 가능하다면 트리거 사용 안하는게 좋음

create table jego(
    gcode char(4) primary key,
    gname varchar2(50) not null,
    ea number not null
);
insert into jego values('0001','아이폰15',100);
insert into jego values('0002','갤럭시s23',100);
commit;

create table ipgo(
    ino number primary key,
    gcode char(4) not null,
    ea number not null,
    idate date not null
);
select * from jego;
select * from ipgo;

create or replace trigger tgr_ipgo
after insert on ipgo -- ipgo테이블에서 insert된 후 호출됨
for each row -- :new, :old 테이블 사용가능
begin
    update jego set ea=ea+:new.ea -- ipgo테이블에 insert된 ea
    where gcode=:new.gcode;  -- ipgo테이블에 insert된 gcode
end;

insert into ipgo values(1,'0001',10,sysdate);

select * from ipgo;
select * from jego;
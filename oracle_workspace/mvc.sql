create table member(
    name varchar2(20) not null,
    userid varchar2(20) primary key,
    pwd varchar2(20) not null,
    email varchar2(20),
    phone varchar2(20),
    admin number default 1
);
insert into member values('홍길동','hkd','1234','hkd@hkd.com','010-1111-2222',1);
delete from member where userid='klp';

select * from member;
commit;

--모델2 방식의 파일첨부형 게시판 테이블 생성
create table mvcboard (
	idx number primary key, 
	name varchar2(50) not null, 
	title varchar2(200) not null, 
	content varchar2(2000) not null, 
	postdate date default sysdate not null, 
	ofile varchar2(200), 
	sfile varchar2(30), 
	downcount number(5) default 0 not null, 
	pass varchar2(50) not null, 
	visitcount number default 0 not null -- 조회수
);
create sequence seq_board_num;
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '김유신', '자료실 제목1 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '장보고', '자료실 제목2 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '이순신', '자료실 제목3 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '강감찬', '자료실 제목4 입니다.','내용','1234');
insert into mvcboard (idx, name, title, content, pass)
    values (seq_board_num.nextval, '대조영', '자료실 제목5 입니다.','내용','1234');
commit;

-- 더미 데이터 생성
insert into mvcboard (idx, name, title, content, pass) 
select seq_board_num.nextval, name, title, content, pass 
from mvcboard;
select count(*) from mvcboard;
commit;

-- 1page
select  X.*
from (
    select rownum as rnum, A.*
    from (
        select *
        from mvcboard
        order by idx desc
        ) A
    where rownum <= 10) X
where X.rnum >= 1;
-- 2page
select  X.*
from (
    select rownum as rnum, A.*
    from (
        select *
        from mvcboard
        order by idx desc
        ) A
    where rownum <= 20) X
where X.rnum >= 11;

SELECT * FROM ( 
    SELECT Tb.*, ROWNUM rNum 
    FROM (         
        SELECT * FROM mvcboard  
        WHERE title LIKE '%5%'
        ORDER BY idx DESC     ) Tb  
    )  
WHERE rNum BETWEEN ? AND ?

select * from mvcboard where name='김이박';
select * from mvcboard where idx>5242874;

drop table reply;

create table reply(
    no number primary key,
    idx number references mvcboard(idx),
    name varchar2(50) not null, 
    content varchar2(500) not null,
    pass varchar2(50) not null, 
    postdate date default sysdate not null
);
create sequence seq_reply;
insert into reply values(seq_reply.nextval,5242882,'홍길동','댓글','1234',default);
insert into reply values(seq_reply.nextval,5242881,'홍길동','댓글','1234',default);
commit;
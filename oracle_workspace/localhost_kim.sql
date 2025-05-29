-- DEPARTMENT 테이블 생성
CREATE TABLE DEPARTMENT (
	DEPTNO		NUMBER	NOT NULL,
	DEPTNAME	CHAR(10),
	FLOOR		NUMBER,
	PRIMARY KEY(DEPTNO)
);

INSERT INTO DEPARTMENT VALUES(1, '영업', 8);
INSERT INTO DEPARTMENT VALUES(2, '기획', 10);
INSERT INTO DEPARTMENT VALUES(3, '개발', 9);
INSERT INTO DEPARTMENT VALUES(4, '총무', 7);


-- EMPLOYEE 테이블 생성
CREATE TABLE EMPLOYEE (
	EMPNO	NUMBER	NOT NULL,
	EMPNAME	CHAR(10),	--UNIQUE, -- 중복 방지
	TITLE	CHAR(10)	DEFAULT '사원',
	MANAGER	NUMBER,
	SALARY	NUMBER	CHECK (SALARY < 6000000),
	DNO		NUMBER	DEFAULT 1, --CHECK (DNO IN (1,2,3,4)) ,
	PRIMARY KEY(EMPNO),
	FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DEPTNO) ON DELETE CASCADE--***
);


INSERT INTO EMPLOYEE VALUES(2106, '김창섭', '대리', 1003, 2500000, 2);
INSERT INTO EMPLOYEE VALUES(3426, '박영권', '과장', 4377, 3000000, 1);
INSERT INTO EMPLOYEE VALUES(3011, '이수민', '부장', 4377, 4000000, 3);
INSERT INTO EMPLOYEE VALUES(1003, '조민희', '과장', 4377, 3000000, 2);
INSERT INTO EMPLOYEE VALUES(3427, '최종철', '사원', 3011, 1500000, 3);
INSERT INTO EMPLOYEE VALUES(1365, '김상원', '사원', 3426, 1500000, 1);
INSERT INTO EMPLOYEE VALUES(4377, '이성래', '이사',  NULL, 5000000, 2);

select * from department;
select * from employee;

commit;

-- EMP_PLANNING 뷰 생성
CREATE VIEW EMP_PLANNING
AS
SELECT E.EMPNAME, E.TITLE, E.SALARY
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DNO=D.DEPTNO AND D.DEPTNAME='기획';

select * from emp_planning;


desc department; -- 구조확인

select * from department;
select deptno, deptname from department;
select * from department where floor < 10;

select * from employee;
select empno, empname, title from employee;
select * from employee where empno=3426;

CREATE TABLE project(
    projno NUMBER NOT NULL,
    projname CHAR(15) NOT NULL,
    budget NUMBER
);

INSERT INTO project VALUES(1, '웹프로젝트', 100000000);
INSERT INTO project VALUES(2, '앱프로젝트', 50000000);
INSERT INTO project VALUES(3, 'AI프로젝트', 10000000000);

SELECT * FROM project;

commit;

alter table project add manager number; -- 컬럼 추가
alter table project drop column manager -- 컬럼 삭제

select * from project;


select * from department;

insert into department values(4, '개발', 1); -- 4가 중복되므로 에러. pk가 중복 방지
insert into department values(5, '개발', 1);
rollback;


select * from employee;

insert into employee values(2000, '홍길동', '사원', 1003, 4000000, 5); -- 5는 department에 없으므로 에러. 참조키가 막아줌.
insert into employee values(2000, '홍길동', '사원', 1003, 4000000, 3);
rollback;

delete from department
where deptno=1;
rollback;

select dno from employee;
select distinct dno from employee; -- distinct는 중복된 열을 제거
select * from employee where dno=3;
select * from employee where empname like '이%'; -- ***문자열 검색

create table board (
    bno number primary key,
    title varchar(200) not null,
    writer varchar(100) not null,
    content varchar(2000) not null
);

insert into board values(1,'sql이 뭔가요?','홍길동','sql이 뭔가요...');
insert into board values(2,'oracle이 뭔가요?','김기홍','오라클이 뭐죠...');
insert into board values(3,'점심시간...','박홍남','미안해요...');

select * from board where writer like '홍%';
select * from board where writer like '%홍';
select * from board where writer like '%홍%';
select * from board where title like '%oracle%';

select * from department;
select * from employee;

select floor from department where deptname='영업' or deptname='개발';

select empname, salary from employee where title='과장' and dno=1;
select empname, salary from employee where title='과장' and dno<>1; -- <>와 != 둘 다 가능
select empname, salary from employee where title='과장' and dno!=1;

select empname, title, salary from employee where salary between 3000000 and 4500000; -- and로 변경 가능
select empname, title, salary from employee where salary>=3000000 and salary<=4500000;
select * from employee where dno in (1,2,3); -- or와 동일
select * from employee where dno=1 or dno=2 or dno=3;

select empname, salary, salary*1.1 as newsalary from employee where title='과장';

select * from employee where manager is null; -- 비교연산자 사용 불가능
select * from employee where manager=null; -- 결과 안나옴
select * from employee where manager is not null;

select salary, title, empname from employee where dno=2 order by salary; -- asc(ascend, 오름차순)이 기본값
select salary, title, empname from employee where dno=2 order by salary desc; -- desc(descend 내림차순)
select * from employee order by dno, salary desc; -- 먼저 dno asc 적용. 같은 dno들의 순서를 salary desc로 정함.
select * from employee order by dno desc, salary;

select count(empno) as 총원 from employee;
select count(manager) as 총원 from employee; -- null값은 제외하고 계산
select count(*) as 총원 from employee; -- 모든 행의 수를 구할때 count(*) 사용
select sum(salary) as 급여합계 from employee;
select avg(salary) as 급여평균 from employee;
select max(salary) as max_salary from employee;
select min(salary) as min_salary from employee;
select count(*), sum(salary), avg(salary), max(salary), min(salary) from employee;

select dno, avg(salary) as avg_salary from employee group by dno;
select dno, count(*) as counts from employee group by dno order by dno;
select dno, avg(salary) as avg_salary from employee having avg(salary)>=2500000 group by dno order by dno;

select 10*20 from dual;
select sysdate from dual;

create table sale_asia(
    no number primary key,
    name varchar(50) not null,
    ea number not null
);
insert into sale_asia values(1,'소나타',100);
insert into sale_asia values(2,'그랜저',200);

create table sale_america(
    no number primary key,
    name varchar(50) not null,
    ea number not null
);
insert into sale_america values(1,'산타페',100);
insert into sale_america values(2,'제네시스',200);

select count(*)
from
(select * from sale_asia
union
select * from sale_america) t;

select * from department;
select * from employee;

-- join
select e.empname, d.deptname from employee e, department d where e.dno=d.deptno;
select employee.empname, department.deptname from employee, department where employee.dno=department.deptno;
select e.empname, d.deptname from employee e, department d where e.dno=d.deptno and salary>=3000000;
select e.*, d.* from employee e, department d where e.dno=d.deptno;
-- order by도 적용 가능
select d.deptname, e.empname, e.title, e.salary 
from employee e, department d 
where e.dno=d.deptno 
order by d.deptname, e.salary desc;
-- ANSI SQL join
select e.empname, d.deptname from employee e inner join department d on e.dno=d.deptno;
select e.empname, d.deptname from employee e inner join department d on e.dno=d.deptno where salary>=3000000;
-- self join
select e.empno, e.empname, e2.empname as manager from employee e, employee e2 where e.manager=e2.empno;

-- sub query
select * 
from employee 
where title=(select title 
             from employee 
             where empname='박영권');
select empname 
from employee 
where dno in (select deptno 
              from department 
              where deptname='영업' or deptname='개발');
-- 아래와 같은 join으로도 동일한 결과를 얻을 수 있음
select e.empname, d.deptname
from department d inner join employee e
on d.deptno=e.dno
where d.deptname='영업' or d.deptname='개발';

-- exists는 쿼리 결과가 1행 이상이면 true, 0행이면 false를 반환.
select * from employee where 1=1;
select empname 
from employee
where exists (select * 
              from department
              where deptno=1); -- dept=7인 경우 안쪽 쿼리 결과가 0행이므로 바깥쪽 쿼리의 결과가 없음.

-- 상관관계 sub query
select e.empname, e.dno, e.salary -- 직원과 부서와 급여를 구하기
from employee e
where salary > (select avg(e2.salary) -- 급여가 sub query 결과 이상인
                from employee e2      -- 즉, 부서별 평균 급여보다 많이 받는
                where e2.dno=e.dno);


insert into department values(5,'연구',null);
insert into department(deptno, deptname) values(6,'서비스'); -- floor가 null이므로 생략 가능
select * from department;
commit;

-- 테이블 복사. 데이터 포함
create table department2 as select * from department;
select * from department2;
-- 테이블 복사. 데이터 제외
create table department3 as select * from department where 1<>1;
select * from department3;
-- 데이터 제외하고 테이블 복사 후 데이터 따로 입력
create table high_salary as select * from employee where 1<>1;
insert into high_salary(empno,empname,title,salary) select empno,empname,title,salary from employee where salary>=3000000;
select * from high_salary;
-- 데이터 정제 후 포함하여 테이블 복사
create table high_salary2 as select empno,empname,title,salary from employee where salary>=3000000;
select * from high_salary2;

delete from department where deptno=4;
select * from department;

update employee set dno=3, salary=salary*1.05 where empno=2106;
select * from employee;


------------------------------------------------------
CREATE OR REPLACE TRIGGER check_value_trigger
BEFORE INSERT OR UPDATE ON department
FOR EACH ROW
BEGIN
   IF :NEW.deptno <= 0 THEN
      RAISE_APPLICATION_ERROR(-20002, 'deptno는 0보다 커야합니다.');
   END IF;
END;

insert into department values(-9,'인사',5);
select * from department;



--------------------------------------------------------------------------------
CREATE TABLE subway_statistics (
     seq_id            NUMBER        NOT NULL,
     station_name      VARCHAR2(100)     NULL,
     boarding_date     DATE              NULL,
     gubun             VARCHAR2(10)      NULL,
     boarding_time     NUMBER            NULL,
     passenger_number  NUMBER            NULL,
     PRIMARY KEY ( seq_id )
);
-- 데이터 입력 후 확인(insert는 다른 파일에서)
select * from subway_statistics;
-- order by에서 컬럼번호 사용
select * from subway_statistics where station_name like '선릉%' order by 1 desc,2,3;

select 'A' || 'B' from dual;
select empname || '- ' || title from employee;

SELECT ROUND( 565.545 ), -- 기본값은 0
       ROUND( 565.545, -1 ) first,
       ROUND( 565.545, -2 ) second,
       ROUND( 565.545, -3 ) third,
       ROUND( 565.545, 2 )
  FROM DUAL;

-- null을 0으로(통계에서 중요)
SELECT NVL(NULL, 0)FROM DUAL;
select empname, nvl(manager,0) from employee;

select sum(salary)/7 from employee;
select avg(salary) from employee;

create table score(
    name varchar(20) not null,
    score number null
);
insert into score values('홍길동',100);
insert into score values('이순신',80);
insert into score values('왕건',null);
select * from score;
commit;
select avg(score) from score;        -- 90점
select avg(nvl(score,0)) from score; -- 60점
select sum(score)/3 from score;      -- 60점

select sysdate from dual;
select to_char(sysdate,'yyyy-mm-dd') from dual;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"년 "MM"월 "DD"일"') FROM dual;
-- 1년 기준 일/주/분기 반환
SELECT TO_CHAR(SYSDATE, 'DDD')  as 일,
       TO_CHAR(SYSDATE, 'WW')   as 주,
       TO_CHAR(SYSDATE, 'Q')    as 분기
FROM dual;


CREATE TABLE emp03 (
   emp_id       NUMBER        NOT NULL,
   emp_name     VARCHAR2(100) NOT NULL,
   gender       VARCHAR2(10)      NULL, 
   age          NUMBER            NULL,
   hire_date    DATE              NULL,
   etc          VARCHAR2(300)     NULL,
   PRIMARY KEY (emp_id)
);
INSERT INTO emp03 ( emp_id, emp_name, gender, age, hire_date )
VALUES (1, '홍길동', '남성', 33, '2018-01-01');
INSERT INTO emp03 ( emp_id, emp_name, gender, age, hire_date )
VALUES (2, '김유신', '남성', 44, '2018-01-01');
INSERT INTO emp03 ( emp_id, emp_name, gender, age, hire_date )
VALUES (3, '강감찬', '남성', 55, '2018-01-01');
INSERT INTO emp03 ( emp_id, emp_name, gender, age, hire_date )
VALUES (4, '신사임당', '여성', 45, '2018-01-01');
select * from emp03;
commit;

SELECT emp_name
      ,age
      ,CASE WHEN age BETWEEN 0  AND 19 THEN '10대'
            WHEN age BETWEEN 20 AND 29 THEN '20대'
            WHEN age BETWEEN 30 AND 39 THEN '30대'
            WHEN age BETWEEN 40 AND 49 THEN '40대'
            WHEN age BETWEEN 50 AND 59 THEN '50대'
            ELSE '60대 이상'
       END ages -- alias
  FROM EMP03;
select emp_name
      ,case gender when '남성' then 'm'
                   when '여성' then 'f'
       end gender -- alias
  FROM EMP03;



CREATE TABLE emp_master
(
  emp_id     NUMBER        NOT NULL, --사원번호
  emp_name   VARCHAR2(100) NOT NULL, --사원명
  gender     VARCHAR2(10),           --성별
  age        NUMBER,                 --나이
  hire_date  DATE,                   --입사일자
  dept_id    NUMBER,                 --부서아이디
  address_id NUMBER,                 --주소아이디
  CONSTRAINT emp_master_pk PRIMARY KEY (emp_id)
);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (1, '김유신', '남성', 56, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 1, 1);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (2, '신사임당', '여성', 34, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 1, 2);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (3, '홍길동', '남성', 45, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 3, 2);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (4, '강감찬', '남성', 23, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 2, 3);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (5, '세종대왕', '남성', 45, TO_DATE('2018-01-01', 'YYYY-MM-DD'), 4, 4);
INSERT INTO emp_master ( emp_id, emp_name, gender, age, hire_date, dept_id, address_id )
VALUES (6, '왕건', '남성', 35, TO_DATE('2018-01-01', 'YYYY-MM-DD'), NULL, 4);

CREATE TABLE dept_master (
  dept_id    NUMBER NOT NULL,         --부서아이디
  dept_name  VARCHAR2(50),            --부서 명
  use_yn     VARCHAR2(2) DEFAULT 'Y', --사용여부
  dept_desc  VARCHAR2(100),           --부서설명
  CONSTRAINT dept_master_pk PRIMARY KEY (dept_id)
);
INSERT INTO dept_master ( dept_id, dept_name )
VALUES (1, '회계팀');
INSERT INTO dept_master ( dept_id, dept_name )
VALUES (2, '경영팀');
INSERT INTO dept_master ( dept_id, dept_name )
VALUES (3, '전산팀');
INSERT INTO dept_master ( dept_id, dept_name )
VALUES (4, '마케팅팀');
INSERT INTO dept_master
VALUES (5, '개발팀', 'Y', null);

CREATE TABLE address_master (
  address_id   NUMBER NOT NULL,       --주소아이디 
  city         VARCHAR2(100),         --도시 명 
  gu           VARCHAR2(50),          --구 명
  address_name VARCHAR2(100),         --나머지 주소
  CONSTRAINT address_master_pk PRIMARY KEY (address_id)
);
INSERT INTO address_master ( address_id, city, gu, address_name )
VALUES (1, '서울특별시', '중구', '새문안로 12');
INSERT INTO address_master ( address_id, city, gu, address_name )
VALUES (2, '서울특별시', '서대문구', '연희로 15길');
INSERT INTO address_master ( address_id, city, gu, address_name )
VALUES (3, '서울특별시', '영등포구', '여의대로 99');
INSERT INTO address_master ( address_id, city, gu, address_name )
VALUES (4, '서울특별시', '강남구', '테헤란로 33');

select * from emp_master;
select * from dept_master;
select * from address_master;
commit;

-- 3 inner join
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn, 
       a.address_id, a.city, a.gu, a.address_name 
from emp_master e, dept_master d, address_master a 
where e.dept_id=d.dept_id 
  and e.address_id=a.address_id 
order by e.emp_id;
-- 3 ANSI SQL inner join + '남성'만 출력
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn, 
       a.address_id, a.city, a.gu, a.address_name 
from emp_master e join dept_master d    on e.dept_id=d.dept_id 
            inner join address_master a on e.address_id=a.address_id 
where e.gender='남성' 
order by e.emp_id;

-- left outer join
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn
from emp_master e, dept_master d 
where e.dept_id=d.dept_id(+)
order by e.emp_id;
-- ANSI SQL left outer join
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn
from emp_master e left join dept_master d on e.dept_id=d.dept_id
order by e.emp_id;
-- right outer join
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn
from emp_master e, dept_master d 
where e.dept_id(+)=d.dept_id
order by e.emp_id;
-- ANSI SQL right outer join
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn
from emp_master e right join dept_master d on e.dept_id=d.dept_id
order by e.emp_id;
-- full outer join(ANSI SQL만 가능)
select e.emp_id, e.emp_name, e.gender, e.age, 
       d.dept_id, d.dept_name, d.use_yn 
from emp_master e full join dept_master d on e.dept_id=d.dept_id 
order by e.emp_id;
-- 전체(3) full outer join
SELECT 
    e.emp_id, e.emp_name, e.gender, e.age, e.hire_date, 
    d.dept_id, d.dept_name, d.use_yn, d.dept_desc, 
    a.address_id, a.city, a.gu, a.address_name 
FROM emp_master e 
FULL OUTER JOIN dept_master d ON e.dept_id = d.dept_id 
FULL OUTER JOIN address_master a ON e.address_id = a.address_id 
ORDER BY e.emp_id;
-- 카티션 곱
SELECT a.emp_id, a.emp_name, a.gender, a.age, a.dept_id,
       b.dept_id, b.dept_name, b.use_yn
  FROM emp_master a
      ,dept_master b
 ORDER BY a.emp_id;
-- view
create or replace view view1
as 
select a.emp_id, a.emp_name, a.gender, a.age,
       b.dept_id, b.dept_name, b.use_yn,
       c.address_id, c.city, c.gu, c.address_name
  from emp_master a, dept_master b, address_master c
 where a.dept_id=b.dept_id -- join조건
   and a.address_id=c.address_id -- join조건
   and a.gender='남성' -- filtering 조건
order by a.emp_id;
select * from view1;
-- inline view
select a.dept_id, a.dept_name, k.emp_id, k.emp_name, k.address
from dept_master a,
    (select b.emp_id, b.emp_name, 
            c. city||c.gu||c.address_name as address,
            b.dept_id
       from emp_master b, address_master c
      where b.address_id=c.address_id) k
where a.use_yn='Y'
and a.dept_id=k.dept_id
order by 1,3;
-- 중첩 sub query
select * from emp_master a
where (a.gender, a.age) in (select b.gender, b.age
                            from emp_master b, address_master c
                            where b.address_id=c.address_id
                            and c.gu in ('중구','서대문구'));
-- 상관관계 sub query
-- 40대 직원이 있는 부서
select * from dept_master a
 where exists(select '아무거나상관없음' from emp_master b
               where b.age between 40 and 49
                 and a.dept_id=b.dept_id);
-- 40대 직원이 없는 부서
select * from dept_master a
 where a.dept_id not in (select b.dept_id
                           from emp_master b
                          where b.age between 40 and 49);
-- 차집합...?
select a.dept_id, d.dept_name
from
    (select dept_id from dept_master
    minus
    select dept_id from emp_master) a
inner join dept_master d
on a.dept_id=d.dept_id;
-- decode()
select decode(10,10,'같다','다르다') from dual;
select decode(10,30,'같다','다르다') from dual;
select emp_id, emp_name, decode(gender, '남성', 'm', 'f') as f_m from emp_master;
select emp_id, emp_name, decode(dept_id, 1, '회계팀', 'etc') as dept_name from emp_master;
select emp_id, emp_name, decode(dept_id, 1, '회계팀', 
                                         2, '경영팀', 
                                         3, '전산팀',
                                         4, '마케팅팀', 'etc') as dept_name 
from emp_master;


-- index
select * from subway_statistics;
select * from subway_statistics where seq_id=477;
select a.emp_id, a.emp_name, a.gender, a.age, 
       b.dept_id, b.dept_name, b.use_yn,
       c.address_id, c.city, c.gu, c.address_name
from emp_master a inner join dept_master b
    on a.dept_id=b.dept_id -- join조건
    inner join address_master c
    on a.address_id=c.address_id -- join조건
where a.gender='남성' --filtering 조건    
order by a.emp_id;

drop table board;
create sequence sequence_board;
create table board(
    bno number primary key,
    title varchar(100) not null,
    content varchar(2000) not null,
    writer varchar(50) not null,
    wdate date not null
);
insert into board values(sequence_board.nextval,'sql이란','sql은...','hkd','2025-03-04');
insert into board values(sequence_board.nextval,'mysql이란','mysql은...','hkd','2025-03-04');
insert into board values(sequence_board.nextval,'oracle이란','oracle은...','lss','2025-03-01');
insert into board select sequence_board.nextval,title,content,writer,wdate from board;
select count(*) from board;
select * from board;
commit;
select * from board where bno=200000;
select * from board where wdate='2025-03-01';
create index idx_wdate on board(wdate);
select * from board where writer='lss' and wdate='2025-03-01';
create index idx_writer on board(writer);
-- 복합 인덱스 활용
select writer, wdate from board; -- 속도가 느리다면
select * from board where writer='hkd' and wdate='2025-03-04';
create index idx_writer_wdate on board(writer,wdate); -- 복합 인덱스로 속도 향상 가능
select writer, wdate from board where writer='lss' and wdate='2025-03-01';

select * from employee;
select * from employee where salary=2625000;
select * from employee where salary*12>40000000;
select * from employee where salary>40000000/12;
create index idx_salary on employee(salary);
create index empdno_idx on employee(dno);

-- 시스템 카탈로그
select table_name, column_name, data_type from user_tab_columns where table_name='EMPLOYEE';
select * from user_tab_columns where table_name='EMPLOYEE';

select view_name, text from user_views;
select * from user_indexes;
select * from user_indexes where index_name='EMPDNO_IDX';

-- 부서별, 직급별로 salary를 다르게 update해서 출력하는 예제
select empno,empname,dno,title,salary,
    decode(dno,1,decode(trim(title),'부장',salary*1.1,
                                    '과장',salary*1.2,
                                    '사원',salary*1.3,
                        salary),
               2,decode(trim(title),'부장',salary*0.7,
                                    '과장',salary*0.8,
                                    '사원',salary*0.9,
                        salary),
           salary) as mod_salary
from employee;

select * from employee;
update employee set salary=777777 where empno=4377;
-- update를 실행한 현재 session에서는 dirty read 발생. 변경된 salary가 출력.
select * from employee where empno=4377;
-- 다른 session에서는 dirty read 허용하지 않음. locking하지는 않음.
select * from kim.employee where empno=4377;
-- update는 locking 발생
update kim.employee set salary=333333 where empno=4377;
-- 기존 session에서 commit 하면 locking이 풀림
commit;
select * from kim.employee where empno=4377;
commit;

--------------------------------------------------------------------------------
-- save point 연습
    -- 사원테이블 현재 데이터 확인
    select * from employee;
    -- 첫 번째 테이블에 데이터 삽입
    INSERT INTO employee (empno, empname, title, manager, salary, dno) 
    VALUES (1004, '천사', '사원', 1234, 3000000,1);
    -- 첫 번째 SAVEPOINT 설정
    SAVEPOINT before_insert_1;
    -- 두 번째 테이블에 데이터 삽입
    INSERT INTO employee (empno, empname, title, manager, salary, dno) 
    VALUES (1005, '홍길동', '부장', 1234,4000000,1);
    -- 두 번째 SAVEPOINT 설정
    SAVEPOINT before_insert_2;
    -- 세 번째 테이블에 데이터 삽입
    INSERT INTO employee (empno, empname, title, manager, salary, dno) 
    VALUES (1006, '이순신', '과장', 1234,4000000,1);
    -- 삽입 데이터 확인
    select * from employee;
    -- 특정 savepoint 까지만 rollback
    rollback to before_insert_2;
    select * from employee;
    -- 전체 rollback
    rollback;
    select * from employee;
--============================================================================--
create table student2(
    id char(7) primary key,
    name varchar2(10) not null,
    dept varchar2(20) not null
);



insert into student2 values('C202001','이순신','컴퓨터공학과');
insert into student2 values('M202001','홍길동','멀티미디어');
insert into student2 values('S202003','김유신','컴퓨터시스템');

commit;
select * from student2;

create table books(
  no char(6) primary key, -- 책번호
  title varchar(50) not null, -- 책이름
  author varchar(50) not null -- 저자
);

insert into books values('000001','오라클기본','이황');
insert into books values('000002','자바정복','율곡');
insert into books values('000003','HTML5','강감찬');


drop table bookRent;

create table bookRent
( no char(10) primary key, -- 대여번호
  id char(7) not null, -- 학번
  bookNo char(6) not null, -- 책번호
  rDate char(8) not null ,-- 대여일
  constraint fk_bookrent foreign key(id)
  references student2(id) on delete cascade
);

insert into bookRent values('2017071304','C202001','000001','20170713');
insert into bookRent values('2017071305','M202001','000002','20170713');
insert into bookRent values('2017071306','M202001','000003','20170713');
insert into bookRent values('2017071307','S202003','000001','20170713');

commit;

select * from bookRent;
select * from books;
select * from student2;
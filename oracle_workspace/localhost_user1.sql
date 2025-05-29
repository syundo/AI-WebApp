-- 테이블을 만들고 데이터 입력
create table student(
id varchar(10) primary key,
name varchar(20) not null,
department varchar(30) not null,
address varchar(50) not null
);
insert into student values('20160001','홍길동','컴퓨터공학과','서울시 영등포구');
insert into student values('20162233','이순신','멀티미디어학과','부산시 남구');
insert into student values('20161177','왕건','멀티미디어학과','강원도 삼척시');
-- 확인 후 커밋
select * from student;
commit;

-- 학번,이름,학과를 출력
select id, name, department from student;
-- 컴퓨터공학과 학생만 출력
select * from student where department='컴퓨터공학과';
-- 서울시에 사는 학생만 출력
select * from student where address like '서울%';
-- 학번순으로 정렬해서 출력(오름차순)
select * from student order by id;
-- 이름순으로 정렬해서 출력(내림차순)
select * from student order by name desc;
-- 성이 '이'씨인 사람을 검색
select * from student where name like '이%';


-- 쇼핑몰 회원(member), 상품(goods), 주문(orders), 주문상세(ordersDetail)
-- member
create table member(
    id varchar2(50) primary key,
    name varchar2(50) not null,
    gender char(1) not null,
    joinDate date default sysdate
);  
insert into member values('hkd','홍길동','m','2001-01-01');
insert into member values('lss','이순신','m','2003-02-01');
insert into member values('hj','황진이','f','2002-11-13');
insert into member values('wg','왕건','m','2005-12-21');
insert into member values('pms','박문수','m','2006-11-09');

-- goods
create table goods(
    gno number primary key,
    name varchar(50) not null,
    price number not null
);
insert into goods values(1,'mp3',10000);
insert into goods values(2,'camera',50000);
insert into goods values(3,'pc',700000);

-- orders
create table orders(
    ono number primary key,
    --id varchar2(50) not null references member(id),
    orderDate date default sysdate
);
insert into  orders values(1,'hkd','2001-03-27');
insert into orders values(2,'wg','2005-04-17');
insert into orders values(3,'hkd','2006-02-07');

-- ordersDetail(번호,주문번호,상품번호,상품수량)
create table ordersDetail(
    no number primary key,
    --ono number not null references orders(ono),
    --gno number not null references goods(gno),
    ea number not null
);
insert into ordersDetail values(1,1,1,1);
insert into ordersDetail values(2,1,3,1);
insert into ordersDetail values(3,2,2,2);
insert into ordersDetail values(4,3,2,1);

select * from member;
select * from goods;
select * from orders;
select * from ordersDetail;
commit;

-- 전체회원수
select count(*) as 전체회원수 from member;
-- 성별,회원수
select gender as 성별, count(*) as 회원수 from member group by gender;

create table department(
    deptno number not null,
    deptname char(10),
    floor number,
    primary key(deptno)
);
insert into department values(1, '영업', 8);
insert into department values(2, '기획', 10);
insert into department values(3, '개발', 9);
insert into department values(4, '총무', 7);
create table employee(
    empno number not null,
    empname char(10) unique,
    title char(10),
    manager number,
    salary number,
    hiredate date,
    dno number,
    primary key(empno),
    foreign key(manager) references employee(empno),
    foreign key(dno) references department(deptno)
);
insert into employee values(4377, '이성래', '사장', NULL, 5000000, '1996-01-05', 2);
insert into employee values(1234, '장건호', '부장', 4377, 4200000, '1996-11-23', 1);
insert into employee values(3426, '박영권', '과장', 1234, 3000000, '1998-07-20', 1);
insert into employee values(1365, '김상원', '사원', 3426, 1500000, '2004-02-26', 1);
insert into employee values(1099, '이재원', '사원', 3426, 1800000, '2003-12-21', 1);
insert into employee values(3011, '이수민', '부장', 4377, 4300000, '1996-04-30', 3);
insert into employee values(2468, '조범수', '과장', 3011, 3500000, '1998-12-17', 3);
insert into employee values(2544, '오준석', '대리', 2468, 2700000, '2002-08-25', 3);
insert into employee values(1003, '조민희', '대리', 2468, 2600000, '2001-02-19', 2);
insert into employee values(3427, '최종철', '사원', 1003, 1500000, '2005-10-28', 3);
insert into employee values(3228, '김주훈', '부장', 4377, 4000000, '1997-03-06', 2);
insert into employee values(2106, '김창섭', '대리', 3228, 2500000, '2003-03-05', 2);
select * from department;
select * from employee;
commit;

--------------------------------------------------------------------------------
-- 1
select * from employee where hiredate=(select min(hiredate) from employee);
-- 2
select * from employee where dno=(select dno from employee where empname='최종철');
-- 3
select count(empno) 전체사원수 from employee;
-- 4
select count(deptno) 전체부서수 from department;
-- 5
select empname,title from employee where dno=(select deptno from department where deptname='기획');
-- 6
select count(dno) from (select dno, count(empno) from employee group by dno);
-- 7
select count(deptno) 
from department 
where deptno not in (select dno 
                     from (select dno, count(empno) 
                           from employee group by dno));
-- 8
select dno, count(empno), avg(salary) as dept_salary from employee group by dno;
-- 9
select deptname, dept_salary 
from (select d.deptname, avg(e.salary) as dept_salary 
      from department d 
      inner join employee e on d.deptno=e.dno 
      group by d.deptname)
where dept_salary like (select max(dept_salary) 
                        from (select d.deptname, avg(e.salary) as dept_salary 
                              from department d 
                              inner join employee e on d.deptno=e.dno 
                              group by d.deptname));
-- 10
select * from employee e inner join department d on e.dno=d.deptno order by deptno;
-- 11
select title, count(empno), avg(salary) from employee group by title;
-- 12
select title, count(empno), avg(salary) from employee group by title having count(empno)>=2;
-- 13
select d.deptname, e.title, count(e.empno)
from employee e 
inner join department d on e.dno=d.deptno
where e.title='대리'
group by d.deptname, e.title
having count(e.empno) >= 2;
-- 14
select d.deptno, d.deptname, d.floor, count(e.empno)
from department d full outer join employee e on d.deptno=e.dno
group by d.deptno, d.floor, d.deptname
order by d.deptno;
-- 15
select distinct(title) from employee
where title in (select title
                from employee
                where dno=1)
and title in (select title
              from employee
              where dno=2)
and title in (select title
              from employee
              where dno=3);

--------------------------------------------------------------------------------
select * from member;
select * from orders;
select * from goods;
select * from ordersDetail;
-- 전체 full outer join
select d.no, m.id, o.ono, g.gno, 
       g.name as gname, g.price, 
       d.ea, o.orderdate,
       m.name, m.gender, m.joindate
from ordersDetail d full outer join goods g on g.gno=d.gno
                    full outer join orders o on o.ono=d.ono
                    full outer join member m on m.id=o.id
order by d.no, o.ono;
-- 회원명, 상품명, 주문갯수
select d.no, m.name, g.name as gname, d.ea
from ordersDetail d full outer join goods g on g.gno=d.gno
                    full outer join orders o on o.ono=d.ono
                    full outer join member m on m.id=o.id
order by d.no;
-- 년도, 판매갯수
select extract(year from o.orderdate) as year, sum(d.ea)
from ordersDetail d full outer join orders o on o.ono=d.ono
group by o.orderdate;
-- 년도, 상품명, 판매갯수
select extract(year from o.orderdate) as year, g.name, sum(d.ea)
from ordersDetail d full outer join goods g on g.gno=d.gno
                    full outer join orders o on o.ono=d.ono
group by o.orderdate, g.name;

--------------------------------------------------------------------------------
--참고용
select * from department;
select * from employee;
-- 16
select title, count(empno) as num
from department d full outer join employee e on d.deptno=e.dno
where deptname='개발'
group by title
order by num desc;
--17 
select e.dno, min(e.salary) as min_salary
from employee e
join (select dno
      from (select dno, avg(salary) as dsalary
            from employee
            group by dno)
      where dsalary = (select max(dsalary)
                       from (select dno, avg(salary) as dsalary
                             from employee
                             group by dno))) highest
on e.dno = highest.dno
group by e.dno;
-- 18
select *
from (select d.deptname, count(e.empno) as num
      from department d full outer join employee e on d.deptno=e.dno
      group by d.deptname)
where num <= 4;
-- 19
select e1.empname, e1.dno, e1.salary 
from employee e1 join (select dno, avg(salary) as dsalary 
                       from employee 
                       group by dno) e2 
                 on e1.dno=e2.dno 
where e1.salary > e2.dsalary;
-- 20
select e1.empname, e1.dno, e1.salary, e2.ds_max 
from employee e1 join (select dno, max(salary) as ds_max 
                       from employee 
                       group by dno) e2 
                 on e1.dno=e2.dno 
where e1.salary = e2.ds_max;
-- 21
select e1.empno, e1.empname, e1.salary, e1.dno, e2.dsalary 
from employee e1 join (select dno, avg(salary) as dsalary 
                       from employee 
                       group by dno) e2 
                 on e1.dno=e2.dno;
-- 22
select empname, title
from employee
where title in (select title 
                from employee 
                where empname in ('최종철','이수민'));
-- 23
select empname 
from employee e inner join department d on e.dno=d.deptno 
where deptname in (select deptname 
                   from department 
                   where deptname not in ('기획','총무'));
-- 24
insert into department values(5, '홍보', 8);
select * from department;
commit;
-- 25
--alter table employee drop consrtaint SYS_C008393;
delete from employee where dno=3;
select * from employee;
commit;
-- 26
update employee set salary = salary * 1.05 where dno=2;
select * from employee;
commit;
-- 27
create view emp_view
as
select empno, empname, salary 
from employee 
where title='과장';
select * from emp_view;

--------------------------------------------------------------------------------
-- developers, projects, project_members 테이블 생성 및 데이터 입력
create table developers(
id varchar2(10) primary key,
name varchar2(30) not null
);
insert into developers values('hkd','홍길동');
insert into developers values('lss','이순신');
insert into developers values('wg','왕건');
insert into developers values('sjdw','세종대왕');
insert into developers values('pms','박문수');

create table projects(
no number primary key,
project_name varchar2(100) not null,
finished char(1) not null
);
insert into projects values(1,'학사관리시스템','N');
insert into projects values(2,'인사관리시스템','Y');

create table project_members(
num number primary key,
no number not null references projects(no),
id varchar2(10) not null references developers(id)
);
insert into project_members values(1,1,'hkd');
insert into project_members values(2,1,'lss');
insert into project_members values(3,1,'wg');
insert into project_members values(4,2,'lss');
insert into project_members values(5,2,'pms');

select * from student;
select * from developers;
select * from projects;
select * from project_members;
commit;

-- 01
create table dongari( 
    did varchar2(10) primary key, 
    dname varchar2(30) not null 
);
INSERT INTO dongari VALUES ('D001', '프로그래밍 동아리');
INSERT INTO dongari VALUES ('D002', '사진 촬영 동아리');
INSERT INTO dongari VALUES ('D003', '야구 동아리');
INSERT INTO dongari VALUES ('D004', '봉사 활동 동아리');
select * from dongari;
commit;
-- 02
create table dongarijoin( 
    djno varchar2(10) primary key, 
    id varchar2(10) references student(id), 
    did varchar2(20) references dongari(did) 
);
insert into dongarijoin values(1,'20160001','D001');
insert into dongarijoin values(2,'20160001','D003');
insert into dongarijoin values(3,'20162233','D002');
insert into dongarijoin values(4,'20171234','D003');
select * from dongarijoin;
commit;
-- 03
select d.dname, s.name, s.id 
from dongarijoin j join dongari d on d.did=j.did 
                   join student s on s.id=j.id;
-- 04
select s.name 
from dongarijoin j full outer join dongari d on d.did=j.did 
                   full outer join student s on s.id=j.id 
where d.did is null;
-- 05
select d.dname 
from dongarijoin j full outer join dongari d on d.did=j.did 
                   full outer join student s on s.id=j.id 
where s.id is null;
-- 06
create table book( 
    bid varchar(10) primary key, -- 책번호
    title varchar(20) -- 책제목
);
insert into book values('0001','java');
insert into book values('0002','Oracle');
insert into book values('0003','HTML');
insert into book values('0004','JSP');
select * from book;
commit;
-- 07
create table rentbook( 
    no number primary key, -- 대출번호
    id varchar(10) references student(id), -- 학번
    bid varchar(10) references book(bid), -- 책번호
    rdate date -- 대출일
);
select * from rentbook;
commit;
-- 08
insert into rentbook values(1,'20160001','0001','2016-12-01');
insert into rentbook values(2,'20162233','0002','2016-12-02');
select * from rentbook;
commit;
-- 09
select s.id, s.name, b.title, r.rdate 
from rentbook r join book b on b.bid=r.bid 
                join student s on s.id=r.id;
-- 10
select b.bid, b.title 
from rentbook r full outer join book b on b.bid=r.bid 
                full outer join student s on s.id=r.id
where s.id is null;
-- 11
select * from developers;
-- 12
select count(*) from developers;
-- 13
select no, project_name from projects where finished='N';
-- 14
select p.no, p.project_name, d.id, d.name 
from project_members m join projects p on p.no=m.no 
                       join developers d on d.id=m.id;
-- 15
select p.no, p.project_name, d.id, d.name 
from project_members m, projects p, developers d 
where p.no=m.no and d.id=m.id;
-- 16
select d.id, d.name 
from project_members m right outer join developers d on d.id=m.id 
where m.no is null;
-- 17
select d.id, d.name 
from project_members m, developers d 
where d.id=m.id(+) 
and m.no is null;
-- 18
SELECT d.id, d.name 
FROM developers d
MINUS
SELECT d.id, d.name 
FROM developers d INNER JOIN project_members m ON d.id = m.id;
-- 19
select d.id, d.name, count(m.num) 
from project_members m full outer join developers d on d.id=m.id 
group by d.id, d.name;
-- 20
select project_name, decode(finished, 'Y', '종결', 
                                      'N', '미종결', '확인불가') as 종결여부 
from projects;
--============================================================================--
create table students(
    id char(7) primary key,
    name varchar2(10) not null,
    dept varchar2(20) not null,
    addr varchar2(50)
);
insert into students values('C202001','이순신','컴퓨터공학','서울특별시 종로구');
insert into students values('M202001','홍길동','멀티미디어','서울특별시 동대문구');
insert into students values('S202003','김유신','컴퓨터시스템','경기도 수원시');

create table books(
  no char(6) primary key, -- 책번호
  title varchar(50) not null, -- 책이름
  author varchar(50) not null -- 저자
);
insert into books values('000001','오라클기본','이황');
insert into books values('000002','자바정복','율곡');
insert into books values('000003','HTML5','강감찬');

create table bookRent
( no char(10) primary key, -- 대여번호
  id char(7) not null, -- 학번
  bookNo char(6) not null, -- 책번호
  rDate char(8) not null ,-- 대여일
  constraint fk_bookrent foreign key(id)
  references students(id) on delete cascade
);
insert into bookRent values('2017071304','C202001','000001','20170713');
insert into bookRent values('2017071305','M202001','000002','20170713');
insert into bookRent values('2017071306','M202001','000003','20170713');
insert into bookRent values('2017071307','S202003','000001','20170713');

commit;

select * from bookRent;
select * from books;
select * from students;
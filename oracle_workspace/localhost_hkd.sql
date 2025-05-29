-- 테이블생성
create table student(
  id int,
  name varchar(20) 
);

-- 데이터입력
insert into student values(12345,'홍길동');

commit; -- 확정

select * from student; -- 검색

rollback;
use mydb; -- db 선택

create table tblRegister(
	id varchar(20) primary key,
    pwd varchar(20) not null,
    name varchar(20) not null,
    email varchar(30) not null,
    phone varchar(30) not null
);
insert into tblRegister values('hkd','1234','홍길동','hkd@email.com','010-1234-5678');

select * from tblRegister;

update tblRegister set pwd='1111' where id='hkd';
delete from tblRegister where id='hkd';
-- 수동 트랜잭션 시작
start transaction;
delete from tblRegister where id='hkd';
rollback;
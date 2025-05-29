-- alter session 트리거 생성
CREATE OR REPLACE TRIGGER set_oracle_script
AFTER LOGON ON DATABASE
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE';
END;


alter session set "_ORACLE_SCRIPT"=TRUE; -- 접속할 때마다 다시 실행

create user kim identified by bluesky
default tablespace users
temporary tablespace temp;

grant connect, resource, create session, create view to kim; -- 권한설정
grant dba to kim;


create user c##lee identified by redsun
default tablespace users
temporary tablespace temp;

grant connect, resource, create session, create view to c##lee;

drop user c##lee; -- 계정삭제

alter user c##lee identified by shinystar;

-- 데이터베이스 Tablespace 생성
create tablespace myts datafile
'C:\app\1\product\21c\oradata\XE\myts.dbf' size 100M
autoextend on next 5M;

-- User hkd 생성
create user c##hkd identified by hong
default tablespace myts
temporary tablespace temp;

-- 권한(role)설정
grant dba to c##hkd;

create user user10 identified by 1234;
drop user user10; -- 계정삭제


create user user7 identified by 1234;
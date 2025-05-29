alter session set "_ORACLE_SCRIPT"=TRUE; -- 접속할 때마다 다시 실행

-- mysample db를 생성(초기사이즈 200M, 자동증가, 증가사이즈 10M)
create tablespace mysample datafile
'C:\app\1\product\21c\oradata\XE\mysample.dbf' size 200M
autoextend on next 10M;

-- user1 계정을 생성(기본DB는 mysample)
create user user1 identified by password
default tablespace mysample
temporary tablespace temp;

-- user1이 mysample DB를 사용할 수 있도록 권한을 설정(dba 권한 부여)
grant dba to user1;

create user testuser identified by 8520
default tablespace mysample
temporary tablespace temp;
grant dba to testuser;
-- db 생성 
create database mydb default char set utf8 collate utf8_general_ci;
-- 계정 생성
create user 'hkd'@'localhost' identified by '1234';
-- 계정 권한 부여
grant all privileges on mydb.* to 'hkd'@'localhost';
flush privileges;
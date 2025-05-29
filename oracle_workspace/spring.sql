DROP TABLE tbl_board;
DROP SEQUENCE seq_board;

create sequence seq_board;

create table tbl_board (
  bno number(10,0),
  title varchar2(200) not null,
  content varchar2(2000) not null,
  writer varchar2(50) not null,
  regdate date default sysdate, 
  updatedate date default sysdate
);

alter table tbl_board add constraint pk_board 
primary key (bno);

-- 데이터 삽입
insert into tbl_board (bno, title, content, writer) values (704, 'spring', 'spring test', 'user00');

-- 데이터 확인
select * from tbl_board order by bno desc;

-- 더미 데이터 삽입
insert into tbl_board (bno, title, content, writer) 
select seq_board.nextval, 'spring', 'spring test', 'user00' from tbl_board;

-- 개수 확인
select count(*) from tbl_board;

commit;

select seq_board.nextval from dual;

--============================================================================--
select bno, title, content
from (
    select /*+index_desc(tbl_board pk_board)*/
        rownum rn, bno, title, content 
    from tbl_board 
    where rownum<=10 
) 
where rn>0;
-- 인덱스 힌트 없이
select bno, title, content
from (
    select 
        rownum rn, bno, title, content 
    from tbl_board 
    where rownum<=10 
) 
where rn>0;
-- 정렬 포함
select bno, title, content
from (
    select 
        rownum rn, bno, title, content 
    from tbl_board 
    where rownum<=10 
    order by bno desc
) 
where rn>0;

--============================================================================--
DROP TABLE tbl_reply;
DROP SEQUENCE seq_reply;
create table tbl_reply (
  rno number(10,0), 
  bno number(10,0) not null,
  reply varchar2(1000) not null,
  replyer varchar2(50) not null, 
  replyDate date default sysdate, 
  updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply  add constraint fk_reply_board  
foreign key (bno)  references  tbl_board (bno);

-- 데이터 삽입
insert into tbl_reply(rno, bno, reply, replyer, replyDate, updateDate) 
values(seq_reply.nextval, 701, 'comment', 'user', sysdate, sysdate);

commit;

--============================================================================--
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno=tbl_board.bno);

create table tbl_attach ( 
  uuid varchar2(100) not null,
  uploadPath varchar2(200) not null,
  fileName varchar2(100) not null, 
  filetype char(1) default 'I',
  bno number(10,0)
);

alter table tbl_attach add constraint pk_attach primary key (uuid); 

alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

--============================================================================--
create table users(
      username varchar2(50) not null primary key,
      password varchar2(50) not null,
      enabled char(1) default '1');

      
 create table authorities (
      username varchar2(50) not null,
      authority varchar2(50) not null,
      constraint fk_authorities_users foreign key(username) references users(username));
      
 create unique index ix_auth_username on authorities (username,authority);


insert into users (username, password) values ('user00','pw00');
insert into users (username, password) values ('member00','pw00');
insert into users (username, password) values ('admin00','pw00');

insert into authorities (username, authority) values ('user00','ROLE_USER');
insert into authorities (username, authority) values ('member00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_ADMIN');
commit;
--=============================================================================--
create table tbl_member(
      userid varchar2(50) not null primary key,
      userpw varchar2(100) not null,
      username varchar2(100) not null,
      regdate date default sysdate, 
      updatedate date default sysdate,
      enabled char(1) default '1');


create table tbl_member_auth (
     userid varchar2(50) not null,
     auth varchar2(50) not null,
     constraint fk_member_auth foreign key(userid) references tbl_member(userid)
);

select * from tbl_member;
select * from tbl_member_auth;


SELECT 
  mem.userid,  userpw, username, enabled, regdate, updatedate, auth
FROM 
  tbl_member mem INNER JOIN tbl_member_auth auth on mem.userid = auth.userid 
WHERE mem.userid = 'admin99';
--============================================================================--
create table persistent_logins(
    username varchar(64) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

select * from persistent_logins;

delete from persistent_logins;
commit;
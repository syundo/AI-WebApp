movieUSE bootex; --db 선택

CREATE TABLE test (
	NO INT AUTO_INCREMENT PRIMARY KEY,
	NAME VARCHAR(20) NOT null
);

INSERT INTO test(NAME) VALUES('홍길동');
INSERT INTO test(NAME) VALUES('이순신');

SELECT * FROM test;

SELECT * FROM tbl_memo LIMIT 10,10;
SELECT * FROM tbl_memo;

SELECT * FROM guestbook;

select b.*, m.* from board b 
left join tbl_member m on b.writer_email=m.email 
where b.bno=10;

select b.*, r.* from board b 
left join reply r on r.board_bno=b.bno 
where b.bno=10;

-- oracle에서는 group by 절에 적은 컬럼만 select 절에 사용 가능
-- 아래 쿼리 oracle에서 사용 불가
select b.*, r.*, COUNT(*)
from board b 
left join tbl_member m on b.writer_email=m.email
left join reply r on b.bno=r.board_bno
group by b.bno;
select count(*) from board;

DELETE FROM movie_image;
DELETE from movie;
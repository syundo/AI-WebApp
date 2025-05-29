-- 테이블 제거
--DROP TABLE hashtags_articles CASCADE CONSTRAINTS;
--DROP TABLE likes CASCADE CONSTRAINTS;
--DROP TABLE comments CASCADE CONSTRAINTS;
--DROP TABLE articles CASCADE CONSTRAINTS;
--DROP TABLE profiles CASCADE CONSTRAINTS;
--DROP TABLE thumbnails CASCADE CONSTRAINTS;
--DROP TABLE categories CASCADE CONSTRAINTS;
--DROP TABLE members CASCADE CONSTRAINTS;
--DROP TABLE hashtags CASCADE CONSTRAINTS;

-- 시퀀스 삭제
--DROP SEQUENCE profiles_seq;
--DROP SEQUENCE thumbnails_seq;
--DROP SEQUENCE articles_seq;
--DROP SEQUENCE comments_seq;
--DROP SEQUENCE hashtags_seq;

CREATE TABLE profiles (
    idx        NUMBER PRIMARY KEY,
    ofile      VARCHAR2(255) NOT NULL,
    sfile      VARCHAR2(255) NOT NULL,
    file_path  VARCHAR2(255) NOT NULL,
    file_size  NUMBER(19) NOT NULL,
    file_type  VARCHAR2(50) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE hashtags (
    idx  NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

CREATE TABLE thumbnails (
    idx        NUMBER PRIMARY KEY,
    ofile      VARCHAR2(255) NOT NULL,
    sfile      VARCHAR2(255) NOT NULL,
    file_path  VARCHAR2(255) NOT NULL,
    file_size  NUMBER(19) NOT NULL,
    file_type  VARCHAR2(50) NOT NULL,
    created_at TIMESTAMP NOT NULL
);

CREATE TABLE categories (
    idx         NUMBER PRIMARY KEY,
    name        VARCHAR2(20) NOT NULL,
    description VARCHAR2(100)
);

CREATE TABLE members (
    id           VARCHAR2(20) PRIMARY KEY,
    pwd          VARCHAR2(50) NOT NULL,
    name         VARCHAR2(20) NOT NULL,
    birth        CHAR(6),
    gender       CHAR(1), -- 'm'은 남성 'f'는 여성
    email        VARCHAR2(80),
    tel          VARCHAR2(20),
    marketing    CHAR(1) DEFAULT '0', -- 0 또는 1로 표현
    role         NUMBER DEFAULT '1' NOT NULL, -- 1 일반회원 / 2 기자 / 0 관리자
    profiles_idx NUMBER,
    visitcnt     NUMBER DEFAULT '0',
    created_at   TIMESTAMP NOT NULL,
    CONSTRAINT members_profiles_fk FOREIGN KEY (profiles_idx) REFERENCES profiles (idx)
);

CREATE TABLE articles (
    idx           NUMBER PRIMARY KEY, -- 게시글 번호
    title         VARCHAR2(100) NOT NULL,
    content       CLOB NOT NULL,
    category      NUMBER NOT NULL, -- 카테고리 ID
    created_at    TIMESTAMP NOT NULL,
    visitcnt      NUMBER NOT NULL,
    members_id    VARCHAR2(20) NOT NULL,
    thumbnails_idx NUMBER,
    CONSTRAINT articles_members_fk FOREIGN KEY (members_id) REFERENCES members (id),
    CONSTRAINT articles_categories_fk FOREIGN KEY (category) REFERENCES categories (idx),
    CONSTRAINT articles_thumbnails_fk FOREIGN KEY (thumbnails_idx) REFERENCES thumbnails (idx)
);

CREATE TABLE comments (
    idx          NUMBER PRIMARY KEY,
    context      VARCHAR2(500) NOT NULL,
    created_at   TIMESTAMP NOT NULL,
    members_id   VARCHAR2(20) NOT NULL,
    articles_idx NUMBER NOT NULL,
    CONSTRAINT comments_articles_fk FOREIGN KEY (articles_idx) REFERENCES articles (idx),
    CONSTRAINT comments_members_fk FOREIGN KEY (members_id) REFERENCES members (id)
);

CREATE TABLE hashtags_articles (
    hashtags_idx NUMBER NOT NULL,
    articles_idx NUMBER NOT NULL,
    CONSTRAINT hashtags_articles_pk PRIMARY KEY (hashtags_idx, articles_idx),
    CONSTRAINT hashtags_articles_articles_fk FOREIGN KEY (articles_idx) REFERENCES articles (idx),
    CONSTRAINT hashtags_articles_hashtags_fk FOREIGN KEY (hashtags_idx) REFERENCES hashtags (idx)
);

CREATE TABLE likes (
    members_id   VARCHAR2(20) NOT NULL,
    articles_idx NUMBER NOT NULL,
    CONSTRAINT likes_pk PRIMARY KEY (members_id, articles_idx),
    CONSTRAINT likes_articles_fk FOREIGN KEY (articles_idx) REFERENCES articles (idx),
    CONSTRAINT likes_members_fk FOREIGN KEY (members_id) REFERENCES members (id)
);

-- 시퀀스 생성
CREATE SEQUENCE profiles_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE thumbnails_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE articles_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE comments_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE hashtags_seq START WITH 1 INCREMENT BY 1;


-- 문자열 pk 시퀀스 사용X (아래는 시퀀스 삭제)
--DROP SEQUENCE members_seq;

-- 사용했던 번호가 삭제되면 또 사용하기 위해 사용X (아래는 시퀀스 삭제)
--DROP SEQUENCE categories_seq;

-- 관계형 테이블(복합키) 시퀀스사용X
--CREATE SEQUENCE hashtags_articles_seq START WITH 1 INCREMENT BY 1;
--CREATE SEQUENCE likes_seq START WITH 1 INCREMENT BY 1;


-- 멤버 데이터 삽입 (프로필X)
INSERT ALL
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('admin', '1234', '관리자', '111111', 'm', 'admin@email.com', '010-0000-0000', '0', 0, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user1', 'pass1', '홍길동', '123456', 'm', 'user1@example.com', '010-1111-1111', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user2', 'pass2', '김철수', '234567', 'm', 'user2@example.com', '010-2222-2222', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user3', 'pass3', '이영희', '345678', 'f', 'user3@example.com', '010-3333-3333', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user4', 'pass4', '박지민', '456789', 'f', 'user4@example.com', '010-4444-4444', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user5', 'pass5', '최민수', '567890', 'm', 'user5@example.com', '010-5555-5555', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user6', 'pass6', '정우성', '678901', 'm', 'user6@example.com', '010-6666-6666', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user7', 'pass7', '한지민', '789012', 'f', 'user7@example.com', '010-7777-7777', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user8', 'pass8', '이민호', '890123', 'm', 'user8@example.com', '010-8888-8888', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user9', 'pass9', '신민아', '901234', 'f', 'user9@example.com', '010-9999-9999', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('user10', 'pass10', '김태희', '012345', 'f', 'user10@example.com', '010-0000-0000', '0', 1, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('journalist1', 'passj1', '이기자', '850101', 'm', 'journalist1@example.com', '010-1111-2222', '0', 2, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('journalist2', 'passj2', '박기자', '860101', 'f', 'journalist2@example.com', '010-2222-3333', '0', 2, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
    INTO members (id, pwd, name, birth, gender, email, tel, marketing, role, visitcnt, created_at) VALUES 
    ('journalist3', 'passj3', '최기자', '870101', 'm', 'journalist3@example.com', '010-3333-4444', '0', 2, 95, TO_TIMESTAMP('2025-01-07 17:30:00', 'YYYY-MM-DD HH24:MI:SS'))
SELECT * FROM dual;
SELECT * FROM members;

-- 카테고리 데이터 삽입
INSERT INTO categories (idx, name, description) VALUES (1, '여행', '여행 관련 정보');
INSERT INTO categories (idx, name, description) VALUES (2, '맛집', '맛집 관련 정보');
SELECT * FROM categories;

-- 게시글 데이터 삽입 (관리자와 기자만, 썸네일X)
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 숨겨진 고깃집', '서울 도심 한복판에서 발견한 고깃집 후기입니다.', 2, TO_TIMESTAMP('2025-02-12 13:12:45', 'YYYY-MM-DD HH24:MI:SS'), 123, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 추천: 강릉 당일치기 코스', '강릉을 하루만에 즐기는 알찬 코스를 소개합니다.', 1, TO_TIMESTAMP('2025-02-13 10:23:34', 'YYYY-MM-DD HH24:MI:SS'), 78, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 후기: 한남동 이탈리안 레스토랑', '데이트 장소로 딱인 레스토랑 후기입니다.', 2, TO_TIMESTAMP('2025-02-14 09:15:20', 'YYYY-MM-DD HH24:MI:SS'), 101, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 부산 감천문화마을', '색감 넘치는 거리에서 인생샷 찍기!', 1, TO_TIMESTAMP('2025-02-14 18:45:50', 'YYYY-MM-DD HH24:MI:SS'), 56, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 종로 맛집 3선', '직장인 점심으로 가기 좋은 종로 맛집 소개', 2, TO_TIMESTAMP('2025-02-15 11:00:10', 'YYYY-MM-DD HH24:MI:SS'), 204, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 제주 서부 드라이브', '제주의 푸른 바다를 따라 달리는 드라이브 코스 추천!', 1, TO_TIMESTAMP('2025-02-15 15:21:33', 'YYYY-MM-DD HH24:MI:SS'), 89, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 을지로 고기집', '직장인 회식 장소로 완벽했던 을지로 맛집 소개', 2, TO_TIMESTAMP('2025-02-16 12:45:00', 'YYYY-MM-DD HH24:MI:SS'), 67, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 소개: 전주 한옥마을', '전통과 현대가 공존하는 전주의 매력!', 1, TO_TIMESTAMP('2025-02-16 17:10:20', 'YYYY-MM-DD HH24:MI:SS'), 112, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 망원동 핫도그 가게', '튀김옷 바삭한 수제 핫도그 맛집!', 2, TO_TIMESTAMP('2025-02-17 13:33:14', 'YYYY-MM-DD HH24:MI:SS'), 93, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 남해 독일마을', '한적한 풍경 속에서의 힐링 여행.', 1, TO_TIMESTAMP('2025-02-17 15:18:56', 'YYYY-MM-DD HH24:MI:SS'), 49, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 추천: 합정 브런치 카페', '감성 가득한 브런치 맛집에서의 여유로운 아침', 2, TO_TIMESTAMP('2025-02-18 09:50:30', 'YYYY-MM-DD HH24:MI:SS'), 134, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 탐방: 대관령 양떼목장', '자연 속에서 힐링할 수 있는 가족 여행지', 1, TO_TIMESTAMP('2025-02-18 14:45:22', 'YYYY-MM-DD HH24:MI:SS'), 71, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 논현동 초밥집', '싱싱한 재료로 승부하는 초밥 전문점 후기', 2, TO_TIMESTAMP('2025-02-19 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 105, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 경주 역사 투어', '천년의 고도 경주의 명소를 도보로 둘러보기', 1, TO_TIMESTAMP('2025-02-19 16:10:45', 'YYYY-MM-DD HH24:MI:SS'), 87, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 청담동 프렌치 레스토랑', '기념일에 딱 좋은 고급 프렌치 맛집', 2, TO_TIMESTAMP('2025-02-20 13:40:10', 'YYYY-MM-DD HH24:MI:SS'), 115, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 소개: 인제 자작나무숲', '눈 덮인 숲속에서 느낄 수 있는 겨울의 정취', 1, TO_TIMESTAMP('2025-02-20 17:25:33', 'YYYY-MM-DD HH24:MI:SS'), 64, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 추천: 이태원 수제버거', '육즙 가득한 수제버거 맛집을 소개합니다!', 2, TO_TIMESTAMP('2025-02-21 12:03:12', 'YYYY-MM-DD HH24:MI:SS'), 76, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 담양 메타세쿼이아 길', '나무가 길게 뻗은 산책길에서의 평온한 시간', 1, TO_TIMESTAMP('2025-02-21 15:33:44', 'YYYY-MM-DD HH24:MI:SS'), 84, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 광화문 한정식', '정갈한 상차림이 인상 깊었던 한정식 집!', 2, TO_TIMESTAMP('2025-02-22 13:20:10', 'YYYY-MM-DD HH24:MI:SS'), 91, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 고성 DMZ 평화누리길', '역사와 평화가 공존하는 길을 따라 걷는 여정', 1, TO_TIMESTAMP('2025-02-22 16:55:29', 'YYYY-MM-DD HH24:MI:SS'), 53, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 건대입구 이색 맛집 3선', '색다른 메뉴로 인기있는 맛집 모음', 2, TO_TIMESTAMP('2025-02-23 11:15:05', 'YYYY-MM-DD HH24:MI:SS'), 128, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 탐방: 태안 꽃지해수욕장', '서해 바다의 낭만을 즐길 수 있는 명소', 1, TO_TIMESTAMP('2025-02-23 15:45:32', 'YYYY-MM-DD HH24:MI:SS'), 74, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 성수동 스테이크 하우스', '숙성 고기의 풍미를 제대로 느낄 수 있는 맛집', 2, TO_TIMESTAMP('2025-02-24 13:12:20', 'YYYY-MM-DD HH24:MI:SS'), 119, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 포항 해안도로 일주', '드라이브와 일몰 명소가 가득한 포항 코스', 1, TO_TIMESTAMP('2025-02-24 18:25:11', 'YYYY-MM-DD HH24:MI:SS'), 66, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 압구정 미쉐린 레스토랑', '미쉐린 선정 고급 레스토랑의 특별한 경험', 2, TO_TIMESTAMP('2025-02-25 12:50:45', 'YYYY-MM-DD HH24:MI:SS'), 144, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 강릉 커피거리 산책', '바다 보며 커피 마시는 여유로운 하루', 1, TO_TIMESTAMP('2025-02-25 16:10:20', 'YYYY-MM-DD HH24:MI:SS'), 58, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 연남동 마라탕 집', '매콤한 국물에 중독되는 진짜 마라탕 맛집!', 2, TO_TIMESTAMP('2025-02-26 13:22:11', 'YYYY-MM-DD HH24:MI:SS'), 77, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 평창 스키장', '겨울 스포츠 마니아를 위한 스키 여행', 1, TO_TIMESTAMP('2025-02-26 17:35:50', 'YYYY-MM-DD HH24:MI:SS'), 83, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 서울역 함박스테이크', '두툼하고 촉촉한 스테이크의 정석', 2, TO_TIMESTAMP('2025-02-27 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 109, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 제주 오름 등반기', '한라산만큼 아름다운 숨은 오름 추천', 1, TO_TIMESTAMP('2025-02-27 15:45:20', 'YYYY-MM-DD HH24:MI:SS'), 97, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 상수역 멕시칸 음식점', '타코, 부리또가 매력적인 이국적인 맛', 2, TO_TIMESTAMP('2025-02-28 13:20:00', 'YYYY-MM-DD HH24:MI:SS'), 88, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 울릉도 섬 일주', '배 타고 떠나는 특별한 섬 여행 이야기', 1, TO_TIMESTAMP('2025-02-28 17:10:40', 'YYYY-MM-DD HH24:MI:SS'), 72, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 홍대 비건 베이커리', '건강하면서도 맛있는 디저트 탐험', 2, TO_TIMESTAMP('2025-03-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 94, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 군산 근대문화유산 투어', '시간 여행을 떠난 듯한 역사 탐방기', 1, TO_TIMESTAMP('2025-03-01 16:25:10', 'YYYY-MM-DD HH24:MI:SS'), 65, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 판교 점심 추천 3선', '직장인 점심 메뉴 걱정 끝!', 2, TO_TIMESTAMP('2025-03-02 12:15:00', 'YYYY-MM-DD HH24:MI:SS'), 139, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 소개: 부산 감천문화마을', '알록달록한 골목길 따라 걷는 여행', 1, TO_TIMESTAMP('2025-03-02 17:33:33', 'YYYY-MM-DD HH24:MI:SS'), 102, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 신사동 타르트 전문점', '디저트 좋아한다면 꼭 가봐야 할 곳!', 2, TO_TIMESTAMP('2025-03-03 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), 81, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 통영 케이블카 투어', '한눈에 내려다보는 바다 풍경', 1, TO_TIMESTAMP('2025-03-03 17:40:55', 'YYYY-MM-DD HH24:MI:SS'), 69, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 노원 스지우동 맛집', '감칠맛 나는 국물과 쫄깃한 면발', 2, TO_TIMESTAMP('2025-03-04 13:11:44', 'YYYY-MM-DD HH24:MI:SS'), 92, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 순천만 갈대밭', '바람 따라 흔들리는 갈대의 물결', 1, TO_TIMESTAMP('2025-03-04 16:55:11', 'YYYY-MM-DD HH24:MI:SS'), 77, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 대치동 수제 돈가스', '겉은 바삭 속은 촉촉한 정통 돈가스', 2, TO_TIMESTAMP('2025-03-05 12:45:22', 'YYYY-MM-DD HH24:MI:SS'), 98, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 태백 산맥 기차여행', '추억을 따라 떠나는 느린 기차 여행', 1, TO_TIMESTAMP('2025-03-05 15:30:00', 'YYYY-MM-DD HH24:MI:SS'), 68, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 광주 빵집 5선', '빵순이들이 꼭 가야 할 핫플레이스', 2, TO_TIMESTAMP('2025-03-06 13:15:10', 'YYYY-MM-DD HH24:MI:SS'), 122, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 안동 하회마을 전통 체험', '고즈넉한 분위기 속에서 한옥 숙박기', 1, TO_TIMESTAMP('2025-03-06 17:40:30', 'YYYY-MM-DD HH24:MI:SS'), 55, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 구의동 수제 맥주 펍', '맥주 애호가라면 놓치면 안될 핫플!', 2, TO_TIMESTAMP('2025-03-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 137, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 서울숲 봄꽃 나들이', '도심 속 자연을 만끽하는 하루', 1, TO_TIMESTAMP('2025-03-07 13:15:00', 'YYYY-MM-DD HH24:MI:SS'), 61, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 망원동 곱창구이', '바삭한 곱창에 소주 한잔 딱!', 2, TO_TIMESTAMP('2025-03-07 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 112, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 인제 자작나무숲', '하얀 나무가 가득한 힐링 명소', 1, TO_TIMESTAMP('2025-03-08 10:40:00', 'YYYY-MM-DD HH24:MI:SS'), 89, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 건대 앞 쌀국수집', '진한 육수의 베트남 쌀국수', 2, TO_TIMESTAMP('2025-03-08 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 97, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 대관령 양떼목장', '푸른 초원 위에서 양과의 만남', 1, TO_TIMESTAMP('2025-03-08 16:20:00', 'YYYY-MM-DD HH24:MI:SS'), 74, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 상암동 치즈 돈까스', '치즈가 흘러나오는 바삭한 돈까스', 2, TO_TIMESTAMP('2025-03-09 11:50:00', 'YYYY-MM-DD HH24:MI:SS'), 108, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 담양 죽녹원 산책기', '대숲 사이로 걸으며 힐링한 하루', 1, TO_TIMESTAMP('2025-03-09 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 84, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 합정 냉모밀 전문점', '여름엔 시원한 냉모밀 한그릇!', 2, TO_TIMESTAMP('2025-03-09 18:10:00', 'YYYY-MM-DD HH24:MI:SS'), 75, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 소개: 청산도 슬로우길', '느림의 미학을 느낄 수 있는 섬길', 1, TO_TIMESTAMP('2025-03-10 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 59, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 동탄 카페거리 브런치 맛집', '인스타 감성 가득한 브런치 투어', 2, TO_TIMESTAMP('2025-03-10 11:20:00', 'YYYY-MM-DD HH24:MI:SS'), 129, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 부여 백제문화 탐방', '천년 고도에서 만난 역사 이야기', 1, TO_TIMESTAMP('2025-03-10 14:10:00', 'YYYY-MM-DD HH24:MI:SS'), 70, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 부산 서면 돼지국밥', '뜨끈하고 구수한 국밥 한그릇', 2, TO_TIMESTAMP('2025-03-10 17:30:00', 'YYYY-MM-DD HH24:MI:SS'), 111, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 고성 통일전망대 방문기', '분단의 현장을 마주한 하루', 1, TO_TIMESTAMP('2025-03-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 64, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 종로 전통 찻집', '따뜻한 다도 체험과 달콤한 다과', 2, TO_TIMESTAMP('2025-03-11 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 86, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 영월 별마로천문대', '밤하늘을 수놓은 별의 향연', 1, TO_TIMESTAMP('2025-03-11 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 73, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 평택 쭈꾸미 볶음', '매콤하게 입맛 돋우는 최고의 밥반찬', 2, TO_TIMESTAMP('2025-03-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 93, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 전주 한옥마을 골목길', '전통이 살아 숨쉬는 거리 산책', 1, TO_TIMESTAMP('2025-03-12 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 85, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 이태원 인도커리 맛집', '이국적인 향신료의 진한 풍미', 2, TO_TIMESTAMP('2025-03-12 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 106, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 강화도 바다 낚시 체험', '싱싱한 바다의 손맛을 느낀 하루', 1, TO_TIMESTAMP('2025-03-13 09:10:00', 'YYYY-MM-DD HH24:MI:SS'), 58, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 광화문 갈비찜 맛집', '달짝지근한 양념이 중독적인 한 상', 2, TO_TIMESTAMP('2025-03-13 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 101, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 남이섬 봄꽃 산책길', '벚꽃과 함께하는 환상적인 풍경', 1, TO_TIMESTAMP('2025-03-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 91, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 상계동 해물칼국수', '시원한 국물에 해산물 듬뿍', 2, TO_TIMESTAMP('2025-03-13 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 104, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 속초 해변 드라이브', '바다 따라 펼쳐지는 도로 위 힐링', 1, TO_TIMESTAMP('2025-03-14 09:45:00', 'YYYY-MM-DD HH24:MI:SS'), 78, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 후기: 수유 시장 곱창전골집', '시장표 양념이 깊은 맛을 자아내요', 2, TO_TIMESTAMP('2025-03-14 12:20:00', 'YYYY-MM-DD HH24:MI:SS'), 87, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 소개: 삼척 해양레일바이크', '바다와 철길이 어우러진 색다른 체험', 1, TO_TIMESTAMP('2025-03-14 14:50:00', 'YYYY-MM-DD HH24:MI:SS'), 69, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 판교 수제버거 맛집', '두툼한 패티가 매력적인 수제버거', 2, TO_TIMESTAMP('2025-03-14 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 115, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 태안 꽃지해변 노을 여행', '붉게 물든 노을이 인상적인 해변', 1, TO_TIMESTAMP('2025-03-15 10:10:00', 'YYYY-MM-DD HH24:MI:SS'), 93, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리스트: 마포 삼겹살 골목', '숯불 향이 가득한 고기집 거리', 2, TO_TIMESTAMP('2025-03-15 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 123, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 문경새재 도립공원 산책', '계곡과 숲길이 어우러진 힐링코스', 1, TO_TIMESTAMP('2025-03-15 15:45:00', 'YYYY-MM-DD HH24:MI:SS'), 76, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 동작 고기국수 전문점', '진한 육수와 담백한 면의 조화', 2, TO_TIMESTAMP('2025-03-15 18:30:00', 'YYYY-MM-DD HH24:MI:SS'), 92, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 제주 사려니숲길 트래킹', '붉은 흙길과 삼나무 숲길의 만남', 1, TO_TIMESTAMP('2025-03-16 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 89, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 광진구 잔치국수 맛집', '담백하고 시원한 잔치국수 한 그릇', 2, TO_TIMESTAMP('2025-03-16 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 98, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 속리산 법주사와 정이품송', '유서 깊은 사찰과 천연기념물 만남', 1, TO_TIMESTAMP('2025-03-16 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 72, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 서초구 생선구이 골목', '노릇하게 구워진 생선의 향연', 2, TO_TIMESTAMP('2025-03-16 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 113, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 일정: 강릉 경포대와 안목해변 카페거리', '동해의 푸른 바다와 감성 카페', 1, TO_TIMESTAMP('2025-03-17 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 96, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 천호동 즉석떡볶이', '매콤달콤한 추억의 분식', 2, TO_TIMESTAMP('2025-03-17 12:40:00', 'YYYY-MM-DD HH24:MI:SS'), 105, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행지 추천: 울산 대왕암공원', '바다와 기암괴석이 어우러진 절경', 1, TO_TIMESTAMP('2025-03-17 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 83, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 탐방: 이문동 족발 골목', '쫄깃하고 부드러운 족발의 유혹', 2, TO_TIMESTAMP('2025-03-17 18:20:00', 'YYYY-MM-DD HH24:MI:SS'), 119, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 합천 해인사와 가야산 산책', '천년 사찰과 계곡이 어우러진 코스', 1, TO_TIMESTAMP('2025-03-18 09:50:00', 'YYYY-MM-DD HH24:MI:SS'), 77, 'journalist2', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 리뷰: 홍대 파스타 전문점', '감성 인테리어와 정통 파스타의 조화', 2, TO_TIMESTAMP('2025-03-18 12:10:00', 'YYYY-MM-DD HH24:MI:SS'), 102, 'journalist3', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 코스: 안동 하회마을 한 바퀴', '한국의 미가 담긴 고즈넉한 마을', 1, TO_TIMESTAMP('2025-03-18 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 80, 'admin', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '맛집 소개: 분당 순대국밥 명가', '국물이 진하고 잡내 없는 순대국', 2, TO_TIMESTAMP('2025-03-18 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 95, 'journalist1', NULL);
INSERT INTO articles (idx, title, content, category, created_at, visitcnt, members_id, thumbnails_idx) VALUES (articles_seq.NEXTVAL, '여행 후기: 청도 와인터널과 레일바이크', '이색적인 테마여행으로 가득 찬 하루', 1, TO_TIMESTAMP('2025-03-19 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 68, 'journalist2', NULL);
SELECT * FROM articles;

-- 댓글 데이터 삽입
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '정말 맛있어 보이네요! 다음에 꼭 가볼게요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 1);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 분위기 너무 좋네요. 소개 감사합니다!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 1);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여행 계획 중인데 이 정보 유용하네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 2);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진만 봐도 힐링돼요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 2);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가족 여행지로 찜했습니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 2);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '자세한 설명 감사합니다~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 2);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 가면 꼭 먹어야 할 메뉴가 뭔가요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 4);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '리뷰 너무 정성스럽네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 4);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '자연 풍경이 정말 멋지네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 5);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 숨은 맛집 정보 너무 좋아요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 7);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가까운 곳이라 이번 주말에 가봐야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 7);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여행기 잘 읽었습니다. 덕분에 좋은 곳 알아가요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 9);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 보고 군침 도네요...', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 10);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '분위기 깡패 맛집이네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 10);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '친구랑 꼭 가봐야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 10);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 맛집은 처음 봤는데 너무 궁금하네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 11);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '분위기가 정말 매력적이에요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 11);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '친구들이랑 가면 딱이겠네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 11);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '계곡이 정말 맑고 예쁘네요. 여름에 딱일 듯!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 13);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 풍경은 직접 가서 봐야죠!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 13);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '진짜 여긴 고기 맛집이네요! 군침 돌아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 14);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '정말 맛있을 것 같아요. 가족이랑 가봐야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 14);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '고기 좋아하는 친구에게 추천해야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 14);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 가보고 너무 만족했어요! 강추합니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 16);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가족 단위로도 괜찮을까요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 16);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '카페 인테리어가 너무 예뻐요. 인스타 감성 뿜뿜!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 18);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 정말 힐링되는 곳 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 19);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '강아지랑 같이 갈 수 있나요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 19);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 현지 맛집 정보 너무 유익해요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 20);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '정말 숨은 맛집 같네요. 다음에 꼭 들러볼게요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 21);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 메뉴 진짜 맛있어 보여요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 21);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '위치 정보도 함께 있으면 좋겠어요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 21);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 자연경관 너무 좋아요. 힐링되네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 23);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여름 휴가지로 찜했습니다!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 23);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 맛집 사진만 봐도 군침이 도네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 24);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 지난번에 다녀왔는데 정말 좋아요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 25);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '다음 여행지는 여기로 정했어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 25);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '분위기가 너무 로맨틱하네요. 데이트 코스로 딱!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 26);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '아기자기한 소품들이 정말 예쁘네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 28);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '친구랑 가면 사진 엄청 찍을 듯해요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 28);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 동네에 이런 맛집이 있었다니!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 29);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '풍경이 장관이네요. 눈으로 힐링합니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 30);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기서 찍은 사진 인스타에 올리면 반응 폭발일 듯요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 30);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 곳이 있었다니! 데이트 코스로 찜!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 31);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '조용하고 운치 있어 보여요. 꼭 가보고 싶어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 31);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 맛집 진짜 유명하던데, 후기 감사해요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 33);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '비쥬얼 미쳤다... 꼭 가볼게요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 33);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 너무 잘 찍으셨어요! 감성 제대로네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 34);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 풍경은 직접 보면 정말 감동일 것 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 35);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가족끼리 가도 좋을 것 같네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 35);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '맛집 소개 너무 감사합니다. 이번 주말에 가봐야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 37);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 진짜 맛있어요! 저도 추천합니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 37);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 데는 꼭 사전예약 필수죠?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 37);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '계절마다 풍경이 달라지겠어요. 매력 넘치네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 39);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '진짜 사진 맛집인 듯. 인생샷 건질 수 있겠어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 40);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '다음 여행지로 저장했습니다. 감사합니다~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 40);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '혼자 조용히 힐링하기 딱 좋은 장소 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 41);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진만 봐도 마음이 편해지는 느낌이에요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 41);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 동네 숨은 맛집이네요! 정보 감사합니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 43);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '비오는 날 가면 분위기 더 좋겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 43);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '도심 속 이런 데가 있다니 놀랍네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 44);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '밤에 가도 예쁠까요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 44);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 집 비빔밥 진짜 예술이에요. 강추!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 45);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '계곡 소리 들으면서 커피 마시면 딱일 듯.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 47);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 어르신들이랑 같이 가도 좋아하시겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 47);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 포스팅 너무 좋아요. 정보 짱이에요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 48);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '저도 여기 가본 적 있어요. 분위기 굿굿.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 49);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 사진 보면 여행 떠나고 싶어져요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 49);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '계절별로 또 다른 모습일 것 같아요. 봄에도 예쁘겠죠?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 50);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '카메라 들고 나들이 가고 싶어지는 곳이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 50);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '와... 이거 보고 당장 가고 싶어졌어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 51);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 감성 무엇... 너무 예쁘네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 51);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 꼭 가보고 싶어요! 음식이 너무 맛있어 보이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 53);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '다음 주말에 가볼까 고민 중이에요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 53);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '맛집 정보는 언제나 환영입니다!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 53);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '날씨 좋은 날 산책하기 딱이겠네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 54);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 동네 처음 들어봤는데 엄청 매력 있네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 55);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 숨은 장소 너무 좋아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 55);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가족끼리 나들이 가면 좋을 듯!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 55);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여긴 무조건 차 끌고 가야겠네요 ㅎㅎ', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 57);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기서 먹는 디저트 진짜 맛있을 것 같아요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 57);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '노을이 진짜 장관이네요. 시간 잘 맞춰야겠어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 58);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 뷰 있는 카페는 못 참죠.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 58);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이렇게 깔끔한 숙소는 무조건 찜이죠!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 60);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '침구류 상태 너무 좋아보이네요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 60);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '야경이 진짜 예술이네요. 꼭 가볼게요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 61);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 코스 따라 걷고 싶어졌어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 61);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '진짜 이 사진 하나로 힐링되네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 63);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가족 여행지로 딱이에요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 63);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '풍경 너무 아름다워요 ㅠㅠ', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 63);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 맛집은 진짜 찐이네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 65);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가성비도 좋아 보여요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 65);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '조용한 분위기 너무 좋네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 66);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 뷰 있는 카페는 무조건 가야죠!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 67);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '디저트도 맛있을 것 같아요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 67);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '분위기 대박... 데이트 코스로 추천합니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 67);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '드라이브 코스로 완전 좋겠네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 69);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '감성 터지는 풍경이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 69);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 숙소 예약 어떻게 하나요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 70);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 보니까 바로 떠나고 싶어졌어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 71);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여긴 계절마다 분위기가 다르겠네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 71);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '자연이 주는 힐링 그 자체...', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 71);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진만 봐도 공기 맑은 게 느껴져요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 71);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 맛집은 숨겨놓고 싶어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 72);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '비주얼 미쳤다... 군침돌아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 72);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '주차는 잘 되나요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 72);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '혼밥하기도 좋을까요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 72);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '진짜 꼭 가볼게요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 72);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가을에 가면 진짜 예쁠 것 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 73);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '여기 산책로도 있나요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 73);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '연인과 꼭 같이 가고 싶은 장소네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 73);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '글만 봐도 힐링됩니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 73);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '날씨 좋을 때 가야겠어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 73);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '분위기 미쳤다... 무조건 저장!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 74);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '데이트 코스로 최고일 듯요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 74);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '인생샷 건질 수 있겠어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 74);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '가서 책 읽고 싶어지는 곳이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 74);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '감성 가득한 공간이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '브런치 메뉴도 맛있겠죠?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '혼자 가기에도 좋을 것 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '인테리어도 예쁘네요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '조용한 분위기 좋아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '노트북 들고 가도 괜찮을까요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 75);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 감성 카페 너무 좋아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 76);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이 근처에 주차공간 있나요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 76);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '카페 분위기가 진짜 따뜻해 보이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 76);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '커피도 맛있어 보이네요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 76);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '다음 주말에 꼭 가볼게요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 76);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '풍경이 진짜 예술이네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 77);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 잘 찍히는 포인트 어디인가요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 77);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '저도 작년에 다녀왔어요! 완전 추천입니다.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 77);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사계절 내내 예쁠 것 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 77);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '비오는 날 가도 운치 있겠네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 78);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '혼자 산책하기 좋은 코스인가요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 78);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '사진 보니 당장 떠나고 싶어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 78);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '근처 맛집도 추천해주세요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user7', 78);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '인테리어 진짜 예쁘다!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user8', 79);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '조용히 힐링하기 딱 좋은 곳 같아요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user9', 79);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 데서 하루 종일 있고 싶어요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user10', 79);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '이런 장소 공유해주셔서 감사해요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user1', 79);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '음식도 분위기도 최고네요.', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user2', 80);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '친구랑 꼭 가보고 싶어요!', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user3', 80);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '혼밥하기에도 좋겠죠?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user4', 80);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '예약은 가능한가요?', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user5', 80);
INSERT INTO comments (idx, context, created_at, members_id, articles_idx) VALUES (comments_seq.NEXTVAL, '리뷰 믿고 가볼게요~', TO_TIMESTAMP('2025-04-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'user6', 80);
SELECT * FROM comments;

-- 해시태그 데이터 삽입
-- 여행관련(13개)
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '감성여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '해외여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '국내여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '혼자여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '커플여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '가족여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '인생샷');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '힐링여행');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '자연풍경');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '산과들');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '바다');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '캠핑');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '여행코스');
-- 맛집관련(12개)
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '맛집탐방');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '숨은맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '미슐랭맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '길거리음식');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '디저트카페');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '브런치맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '고기맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '해산물맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '매운맛');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '한식사랑');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '일식맛집');
INSERT INTO hashtags (idx, name) VALUES (hashtags_seq.NEXTVAL, '세계음식');
SELECT * FROM hashtags;

-- 해시태그와 게시글 관계 데이터 삽입
-- 1. 맛집 탐방: 숨겨진 고깃집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (1, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (1, 15); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (1, 20); -- 고기맛집
-- 2. 여행 추천: 강릉 당일치기 코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (2, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (2, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (2, 11); -- 바다
-- 3. 맛집 후기: 한남동 이탈리안 레스토랑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (3, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (3, 25); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (3, 16); -- 미슐랭맛집
-- 4. 여행지 추천: 부산 감천문화마을
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (4, 1);  -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (4, 7);  -- 인생샷
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (4, 3);  -- 국내여행
-- 5. 맛집 리스트: 종로 맛집 3선
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (5, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (5, 23); -- 한식사랑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (5, 15); -- 숨은맛집
-- 6. 여행 코스: 제주 서부 드라이브
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (6, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (6, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (6, 8);  -- 힐링여행
-- 7. 맛집 리뷰: 을지로 고기집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (7, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (7, 20); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (7, 23); -- 한식사랑
-- 8. 여행지 소개: 전주 한옥마을
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (8, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (8, 6);  -- 가족여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (8, 1);  -- 감성여행
-- 9. 맛집 탐방: 망원동 핫도그 가게
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (9, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (9, 17); -- 길거리음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (9, 15); -- 숨은맛집
-- 10. 여행 후기: 남해 독일마을
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (10, 8);  -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (10, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (10, 9);  -- 자연풍경
-- 11. 맛집 추천: 합정 브런치 카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (11, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (11, 19); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (11, 18); -- 디저트카페
-- 12. 여행지 탐방: 대관령 양떼목장
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (12, 9);  -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (12, 6);  -- 가족여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (12, 8);  -- 힐링여행
-- 13. 맛집 소개: 논현동 초밥집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (13, 24); -- 일식맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (13, 21); -- 해산물맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (13, 25); -- 세계음식
-- 14. 여행 일정: 경주 역사 투어
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (14, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (14, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (14, 10); -- 산과들
-- 15. 맛집 탐방: 청담동 프렌치 레스토랑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (15, 25); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (15, 16); -- 미슐랭맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (15, 14); -- 맛집탐방
-- 16번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (16, 1);  -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (16, 10); -- 산과들
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (16, 13); -- 여행코스
-- 17번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (17, 1 + 13); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (17, 18); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (17, 25); -- 세계음식
-- 18번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (18, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (18, 9);  -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (18, 13); -- 여행코스
-- 19번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (19, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (19, 17); -- 한식사랑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (19, 20); -- 길거리음식
-- 20번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (20, 5);  -- 가족여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (20, 12); -- 캠핑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (20, 13); -- 여행코스
-- 21번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (21, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (21, 16); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (21, 25); -- 세계음식
-- 22번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (22, 1);  -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (22, 6);  -- 인생샷
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (22, 11); -- 바다
-- 23번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (23, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (23, 18); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (23, 22); -- 미슐랭맛집
-- 24번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (24, 4);  -- 혼자여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (24, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (24, 13); -- 여행코스
-- 25번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (25, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (25, 22); -- 미슐랭맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (25, 25); -- 세계음식
-- 26번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (26, 2);  -- 해외여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (26, 6);  -- 인생샷
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (26, 13); -- 여행코스
-- 27번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (27, 15); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (27, 21); -- 매운맛
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (27, 25); -- 세계음식
-- 28번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (28, 7);  -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (28, 5);  -- 가족여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (28, 13); -- 여행코스
-- 29번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (29, 18); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (29, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (29, 23); -- 일식맛집
-- 30번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (30, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (30, 10); -- 산과들
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (30, 13); -- 여행코스
-- 31번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (31, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (31, 25); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (31, 22); -- 미슐랭맛집
-- 32번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (32, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (32, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (32, 11); -- 바다
-- 33번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (33, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (33, 19); -- 디저트카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (33, 20); -- 브런치맛집
-- 34번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (34, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (34, 8);  -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (34, 12); -- 힐링여행
-- 35번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (35, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (35, 20); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (35, 17); -- 한식사랑
-- 36번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (36, 1);  -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (36, 10); -- 산과들
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (36, 13); -- 여행코스
-- 37번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (37, 19); -- 디저트카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (37, 20); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (37, 25); -- 세계음식
-- 38번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (38, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (38, 7);  -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (38, 13); -- 여행코스
-- 39번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (39, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (39, 23); -- 일식맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (39, 17); -- 한식사랑
-- 40번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (40, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (40, 9);  -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (40, 12); -- 힐링여행
-- 41번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (41, 14); -- 맛집탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (41, 18); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (41, 17); -- 한식사랑
-- 42번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (42, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (42, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (42, 10); -- 산과들
-- 43번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (43, 19); -- 디저트카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (43, 20); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (43, 14); -- 맛집탐방
-- 44번 (여행)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (44, 3);  -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (44, 2);  -- 해외여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (44, 13); -- 여행코스
-- 45번 (맛집)
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (45, 15); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (45, 25); -- 세계음식
-- 게시글 46: 여행 후기: 서울숲 봄꽃 나들이
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (46, 1); -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (46, 9); -- 자연풍경
-- 게시글 47: 맛집 소개: 망원동 곱창구이
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (47, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (47, 10); -- 매운맛
-- 게시글 48: 여행지 추천: 인제 자작나무숲
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (48, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (48, 9); -- 자연풍경
-- 게시글 49: 맛집 탐방: 건대 앞 쌀국수집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (49, 12); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (49, 4); -- 길거리음식
-- 게시글 50: 여행 일정: 대관령 양떼목장
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (50, 9); -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (50, 8); -- 힐링여행
-- 게시글 51: 맛집 리뷰: 상암동 치즈 돈까스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (51, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (51, 5); -- 디저트카페
-- 게시글 52: 여행 후기: 담양 죽녹원 산책기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (52, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (52, 9); -- 자연풍경
-- 게시글 53: 맛집 탐방: 합정 냉모밀 전문점
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (53, 11); -- 일식맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (53, 4); -- 길거리음식
-- 게시글 54: 여행지 소개: 청산도 슬로우길
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (54, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (54, 9); -- 자연풍경
-- 게시글 55: 맛집 리스트: 동탄 카페거리 브런치 맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (55, 6); -- 브런치맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (55, 5); -- 디저트카페
-- 게시글 56: 여행 일정: 부여 백제문화 탐방
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (56, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (56, 10); -- 여행코스
-- 게시글 57: 맛집 소개: 부산 서면 돼지국밥
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (57, 10); -- 매운맛
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (57, 7); -- 고기맛집
-- 게시글 58: 여행 후기: 고성 통일전망대 방문기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (58, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (58, 10); -- 여행코스
-- 게시글 59: 맛집 리뷰: 종로 전통 찻집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (59, 5); -- 디저트카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (59, 6); -- 브런치맛집
-- 게시글 60: 여행 코스: 영월 별마로천문대
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (60, 1); -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (60, 13); -- 여행코스
-- 게시글 61: 맛집 탐방: 평택 쭈꾸미 볶음
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (61, 10); -- 매운맛
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (61, 7); -- 고기맛집
-- 게시글 62: 여행지 추천: 전주 한옥마을 골목길
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (62, 10); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (62, 1); -- 감성여행
-- 게시글 63: 맛집 소개: 이태원 인도커리 맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (63, 12); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (63, 10); -- 매운맛
-- 게시글 64: 여행 후기: 강화도 바다 낚시 체험
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (64, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (64, 11); -- 바다
-- 게시글 65: 맛집 리뷰: 광화문 갈비찜 맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (65, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (65, 10); -- 매운맛
-- 게시글 66: 여행 코스: 남이섬 봄꽃 산책길
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (66, 9); -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (66, 13); -- 여행코스
-- 게시글 67: 맛집 탐방: 상계동 해물칼국수
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (67, 8); -- 해산물맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (67, 10); -- 매운맛
-- 게시글 68: 여행 일정: 속초 해변 드라이브
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (68, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (68, 13); -- 여행코스
-- 게시글 69: 맛집 후기: 수유 시장 곱창전골집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (69, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (69, 4); -- 길거리음식
-- 게시글 70: 여행지 소개: 삼척 해양레일바이크
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (70, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (70, 11); -- 바다
-- 게시글 71: 맛집 탐방: 판교 수제버거 맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (71, 12); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (71, 7); -- 고기맛집
-- 게시글 72: 여행 일정: 태안 꽃지해변 노을 여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (72, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (72, 9); -- 자연풍경
-- 게시글 73: 맛집 리스트: 마포 삼겹살 골목
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (73, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (73, 4); -- 길거리음식
-- 게시글 74: 여행 후기: 문경새재 도립공원 산책
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (74, 9); -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (74, 8); -- 힐링여행
-- 게시글 75: 맛집 소개: 동작 고기국수 전문점
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (75, 7); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (75, 10); -- 매운맛
-- 게시글 76: 제주 사려니숲길 트래킹 → 자연, 힐링, 걷기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (76, 9); -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (76, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (76, 13); -- 여행코스
-- 게시글 77: 광진구 잔치국수 → 한식, 시원한 국물, 지역 맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (77, 14); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (77, 22); -- 한식사랑
-- 게시글 78: 속리산 법주사와 정이품송 → 사찰, 유적, 산길
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (78, 10); -- 산과들
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (78, 9); -- 자연풍경
-- 게시글 79: 서초구 생선구이 골목 → 구이, 생선, 노포 분위기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (79, 14); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (79, 20); -- 해산물맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (79, 22); -- 한식사랑
-- 게시글 80: 강릉 경포대, 안목해변 카페거리 → 바다, 감성, 카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (80, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (80, 1); -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (80, 8); -- 힐링여행
-- 게시글 81: 천호동 즉석떡볶이 → 분식, 매운맛, 추억
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (81, 17); -- 길거리음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (81, 21); -- 매운맛
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (81, 22); -- 한식사랑
-- 게시글 82: 울산 대왕암공원 → 기암괴석, 해안절경, 걷기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (82, 11); -- 바다
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (82, 9); -- 자연풍경
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (82, 13); -- 여행코스
-- 게시글 83: 이문동 족발 골목 → 고기, 족발, 로컬맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (83, 14); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (83, 20); -- 고기맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (83, 22); -- 한식사랑
-- 게시글 84: 해인사와 가야산 산책 → 사찰, 계곡, 걷기
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (84, 10); -- 산과들
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (84, 8); -- 힐링여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (84, 13); -- 여행코스
-- 게시글 85: 홍대 파스타 전문점 → 감성, 파스타, 이탈리안
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (85, 18); -- 디저트카페
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (85, 23); -- 세계음식
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (85, 14); -- 숨은맛집
-- 게시글 86: 안동 하회마을 → 전통, 조용한 마을, 역사
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (86, 3); -- 국내여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (86, 1); -- 감성여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (86, 13); -- 여행코스
-- 게시글 87: 분당 순대국밥 명가 → 고깃국물, 진한 맛, 추운 날
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (87, 22); -- 한식사랑
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (87, 14); -- 숨은맛집
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (87, 21); -- 매운맛
-- 게시글 88: 청도 와인터널, 레일바이크 → 테마여행, 이색, 와인
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (88, 6); -- 가족여행
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (88, 13); -- 여행코스
INSERT INTO hashtags_articles (articles_idx, hashtags_idx) VALUES (88, 1); -- 감성여행
SELECT * FROM hashtags_articles;

-- 좋아요 데이터 삽입
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 1);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 1);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 1);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 2);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 2);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 3);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 5);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 5);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 5);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 5);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 6);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 7);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 7);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 7);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 7);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 7);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 8);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 8);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 10);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 10);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 10);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 11);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 11);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 11);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 11);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 11);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 12);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 12);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 14);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 14);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 14);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 14);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 15);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 15);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 15);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 17);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 17);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 17);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 18);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 18);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 19);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 19);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 20);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 20);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 20);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 20);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 21);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 21);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 21);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 21);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 21);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 22);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 23);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 23);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 23);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 23);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 23);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 25);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 25);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 25);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 26);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 27);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 27);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 28);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 28);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 28);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 28);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 30);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 30);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 30);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 31);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 31);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 31);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 31);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 32);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 32);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 32);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 34);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 34);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 34);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 34);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 35);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 35);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 36);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 36);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 36);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 36);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 36);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 37);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 37);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 37);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 37);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 37);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 39);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 39);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 39);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 40);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 40);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 41);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 41);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 41);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 42);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 42);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 42);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 42);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 44);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 44);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 45);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 45);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 45);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 46);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 46);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 46);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 46);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 47);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 47);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 48);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 48);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 48);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 48);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 50);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 50);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 50);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 51);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 51);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 51);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 52);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 52);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 54);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 54);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 54);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 55);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 55);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 55);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 55);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 56);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 56);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 56);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 58);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 58);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 58);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 59);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 59);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 59);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 60);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 60);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 61);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 61);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 61);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 62);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 62);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 64);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 64);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 64);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 65);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 65);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 66);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 66);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 66);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 66);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 68);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 68);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 68);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 69);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 69);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 70);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 70);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 71);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 71);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 71);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 72);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 72);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 72);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 72);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 72);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 74);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 74);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 74);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 74);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 74);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 75);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 75);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 75);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 76);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 76);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 76);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 76);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 76);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 77);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 77);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 77);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 78);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 78);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 78);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 78);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 78);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 79);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 79);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 80);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 82);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 82);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 82);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 82);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 83);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 83);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 83);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 83);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 84);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 85);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 85);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 85);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 85);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 86);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 86);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 86);
INSERT INTO likes (members_id, articles_idx) VALUES ('user1', 86);
INSERT INTO likes (members_id, articles_idx) VALUES ('user3', 86);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 87);
INSERT INTO likes (members_id, articles_idx) VALUES ('user2', 87);
INSERT INTO likes (members_id, articles_idx) VALUES ('user9', 87);
INSERT INTO likes (members_id, articles_idx) VALUES ('user7', 88);
INSERT INTO likes (members_id, articles_idx) VALUES ('user10', 88);
INSERT INTO likes (members_id, articles_idx) VALUES ('user5', 88);
INSERT INTO likes (members_id, articles_idx) VALUES ('user8', 88);
INSERT INTO likes (members_id, articles_idx) VALUES ('user6', 88);
INSERT INTO likes (members_id, articles_idx) VALUES ('user4', 88);
SELECT * FROM likes;

select * from articles;
select * from categories;
select * from comments;
select * from hashtags;
select * from hashtags_articles;
select * from likes;
select * from members;

commit;
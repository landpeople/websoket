-- 세션이 필요해서 테스트용으로 만들어 쓰는 테이블
CREATE TABLE LPUSER(
	USER_EMAIL VARCHAR2(50) NOT NULL,
	USER_PASSWORD VARCHAR2(100) NOT NULL,
	USER_NICKNAME VARCHAR2(20) NOT NULL,
	USER_AUTH CHAR(1),
	USER_DELFLAG CHAR(1) DEFAULT 'F',
	USER_EMAILCHK CHAR(1),
	USER_EMAILKEY VARCHAR2(300)
);

-- 회원가입 (이메일) OK
INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILCHK, USER_EMAILKEY) VALUES('lee', 123, 'lee', 'Y', 'U', '');
INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILCHK, USER_EMAILKEY) VALUES('cho', 123, 'cho', 'Y', 'U', '');
INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILCHK, USER_EMAILKEY) VALUES('kim', 123, 'kim', 'Y', 'U', '');
INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILCHK, USER_EMAILKEY) VALUES('na', 123, 'na', 'Y', 'U', '');

-- 채팅 ==========================================================================================================================================			
-- 테이블 재생성을 위해 테이블을 DROP하는 쿼리
DROP TABLE LPCHATLIST;
DROP TABLE LPCHATROOM;
DROP TABLE LPCHATIMAGE;

-- 시퀀스 재생성을 위해 시퀀스를 DROP하는 쿼리
DROP SEQUENCE LPCHATROOM_SEQ;
DROP SEQUENCE LPCHATIMAGE_SEQ;

-- 테이블 생성
CREATE TABLE LPCHATLIST(USER_NICKNAME VARCHAR2(20));
CREATE TABLE LPCHATROOM(CHR_ID VARCHAR2(20), CHR_SENDER VARCHAR2(20), CHR_RECEIVER VARCHAR2(50), CHR_SOUT CHAR(1), CHR_ROUT CHAR(1), CHR_CONTENT VARCHAR2(2000), CHR_REGDATE DATE);
CREATE TABLE LPCHATIMAGE(CHI_ID VARCHAR2(20), CHI_RPATH VARCHAR2(200), CHI_SPATH VARCHAR2(200), FILE_SIZE NUMBER);

-- 테이블 시퀀스 생성
CREATE SEQUENCE LPCHATROOM_SEQ START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE LPCHATIMAGE_SEQ START WITH 1 INCREMENT BY 1;

-- 세션에 접속중인 상대방들과만 채팅할 수 있도록 테스트 하기 위해서 defalut로 사용자 몇 명 넣어줌 
INSERT INTO LPCHATLIST VALUES('접속자1');
INSERT INTO LPCHATLIST VALUES('접속자2');
INSERT INTO LPCHATLIST VALUES('접속자3');
INSERT INTO LPCHATLIST VALUES('접속자4');
INSERT INTO LPCHATLIST VALUES('접속자5');
INSERT INTO LPCHATLIST VALUES('접속자6');

-- 세션에 접속한 모든 사용자를 보여줌
SELECT * FROM LPCHATLIST;

DELETE FROM LPCHATLIST WHERE USER_NICKNAME NOT IN ('lee','kim');

-- default로 하나의 채팅방을 생성해줌
INSERT INTO LPCHATROOM (CHR_ID, CHR_SENDER, CHR_RECEIVER, CHR_SOUT, CHR_ROUT, CHR_CONTENT, CHR_REGDATE)
VALUES(LPCHATROOM_SEQ.NEXTVAL, '접속자1', '접속자2', 'F', 'F', '<p id="접속자 1">접속자 1님의 시간</p><p id="접속자1">안녕하세요!!!</p><p id="접속자 2">접속자2님의 시간</p><p id="접속자2">오냐</p>', SYSDATE);

-- 1. 세션에 접속한 사용자 리스트 출력 =================================================================================================
SELECT * FROM LPCHATLIST;

-- 1. 채팅방 생성 ==========================================================================================================================================			
-- 1. 기존에 상대방과 채팅방이 있는지 확인
SELECT CHR_ID FROM LPCHATROOM WHERE (CHR_SENDER, CHR_RECEIVER) IN (('접속자1', '접속자2'),('접속자2','접속자1'));

-- 2.1 만약에 기존에 만들었던 채팅방이 있다면 나의 채팅 목록에서 보이게 만들어줌
UPDATE LPCHATROOM SET CHR_SOUT='F', CHL_ROUT = 'F' WHERE CHR_ID = '1';

-- 2.2 기존에 채팅방이 없다면 -> 채팅 리스트에 추가
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '접속자1', '접속자2', 'F', 'F', '', SYSDATE);
-- 추가한 채팅 리스트 확인
SELECT * FROM LPCHATLIST;
-- ==========================================================================================================================================
-- 2. 채팅방 삭제(TT이면 다 삭제)
-- 내가 SENDER인지 RECEIVER인지 확인하고 SENDER일 때와 RECEIVER인지 확인 위함
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER, CHL_RECEIVER) IN (('a1@naver.com', 'b1@naver.com'),('b1@naver.com','a1@naver.com'));
			
-- 만약에 내가 SENDER이면
UPDATE LPCHATLIST SET CHL_SDEL='T' WHERE CHL_ID = '7' ;

-- 만약에 내가 RECEIVER이면
UPDATE LPCHATLIST SET CHL_RDEL='T' WHERE CHL_ID = '7' ;

-- 채팅방 진짜 삭제
DELETE FROM LPCHATLIST WHERE CHL_SDEL = 'T' AND CHL_RDEL ='T' AND CHL_ID = '7';
-- ==========================================================================================================================================			
-- 3. 채팅방 메시지 보내기
DELETE FROM LPCHATROOM;

INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링1', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링2', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링3', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링4', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링5', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링6', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링7', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링8', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'a1@naver.com', 'a1 : 방가링9', 'F', SYSDATE);
INSERT INTO LPCHATROOM VALUES(LPCHATROOM_SEQ.NEXTVAL, '1', 'b1@naver.com', 'b1 : 방가링10', 'F', SYSDATE);

-- 추가한 채팅방 메시지 확인
SELECT * FROM LPCHATROOM;
-- ==========================================================================================================================================			
--4. 채팅방 이미지 보내기
INSERT INTO LPCHATIMAGE VALUES(LPCHATIMAGE_SEQ.NEXTVAL, '21', 'a1@naver.com', '진짜경로', '상대경로', 1000, 'F', SYSDATE);

-- 추가한 채팅방 이미지 확인
SELECT * FROM LPCHATIMAGE;
-- ==========================================================================================================================================			
--5. 채팅방 상세페이지 보기
SELECT CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_READFLAG, CHT_TIME FROM
	(SELECT CHR_ID, NULL CHI_ID, CHL_ID, USER_EMAIL, CHR_CONTENT, NULL CHI_RPATH, NULL CHI_SPATH, NULL FILE_SIZE, CHT_READFLAG, CHT_TIME FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT NULL CHR_ID, CHI_ID, CHL_ID, USER_EMAIL, NULL CHR_CONTENT, CHI_RPATH, CHI_SPATH, FILE_SIZE, CHT_READFLAG, CHT_TIME FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
ORDER BY CHT_TIME;

UPDATE LPCHATROOM SET CHT_READFLAG = 'T' WHERE CHL_ID = '1' AND USER_EMAIL != 'a1@gmail.com';
UPDATE LPCHATIMAGE SET CHT_READFLAG = 'T' WHERE CHL_ID = '1' AND USER_EMAIL != 'a1@gmail.com';
-- ==========================================================================================================================================	
--6. 채팅방 리스트 보기(접속한 사용자가 나가지 않은 방, 필요한 정보는 내가 보내는 사람인지 받는 사람인지 그리고 마지막 메시지와 시간)
SELECT CHL_ID, CHL_SENDER, CHL_RECEIVER FROM LPCHATLIST WHERE (CHL_SENDER = 'a1@naver.com' AND CHL_SDEL = 'F') OR (CHL_RECEIVER = 'a1@naver.com' AND CHL_RDEL = 'F');

-- 마지막 메시지와 시간 만약에 CHR_ID와 CHI_ID가 NULL 인지 아닌지에 따라서 뿌려줌
SELECT RN, CHR_ID, CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM
 (SELECT ROW_NUMBER() OVER (ORDER BY CHT_TIME DESC) RN, CHR_ID, CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM
	(SELECT CHR_ID, NULL CHI_ID, CHL_ID, CHR_CONTENT, CHT_TIME FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT NULL CHR_ID, CHI_ID, CHL_ID, NULL CHR_CONTENT, CHT_TIME FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
) WHERE RN = '1';
-- ==========================================================================================================================================			
-- 7. 채팅방 안 읽은 메시지 갯수 세기
SELECT COUNT(*) FROM
	(SELECT CHT_READFLAG FROM LPCHATROOM WHERE LPCHATROOM.CHL_ID='1'
		UNION ALL
	SELECT CHT_READFLAG FROM LPCHATIMAGE WHERE LPCHATIMAGE.CHL_ID='1')
WHERE CHT_READFLAG = 'F';

--  배치로 CHL_RDEL과 CHL_WDEL이 모두 T인 채팅방을 삭제
DELETE FROM LPCHATLIST WHERE CHL_RDEL = 'T' AND CHL_WDEL = 'T';
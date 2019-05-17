-- 회원 관리 쿼리

CREATE TABLE LPUSER(
	USER_EMAIL  VARCHAR2(50) NOT NULL,
	USER_PASSWORD VARCHAR2(100) NOT NULL,
	USER_NICKNAME VARCHAR2(20) NOT NULL,
	USER_AUTH CHAR(1),
	USER_DELFLAG CHAR(1) DEFAULT 'F',
	USER_EMAILCHK CHAR(1) DEFAULT 'N',
	USER_EMAILKEY VARCHAR2(300)
);




<!-- 회원가입 (이메일) OK-->

	INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILKEY) 
	VALUES(#{user_email}, #{user_password}, #{user_nickname}, 'U', '')

<!-- 회원가입 (네이버)  OK-->

	INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILKEY) 
	VALUES(#{user_email}, #{user_password}, #{user_nickname}, 'N', '')


<!-- 회원가입 (구글)  OK-->

	INSERT INTO LPUSER (USER_EMAIL, USER_PASSWORD, USER_NICKNAME, USER_AUTH, USER_EMAILKEY) 
	VALUES(#{user_email}, #{user_password}, #{user_nickname}, 'G', '')


<!-- 이메일 중복체크  -->

	SELECT COUNT(USER_EMAIL) USER_EMAIL FROM LPUSER WHERE USER_EMAIL = #{user_email}

<!-- 닉네임 중복체크 -->

	SELECT COUNT(USER_NICKNAME) USER_NICKNAME FROM LPUSER WHERE USER_NICKNAME = #{user_nickname}









<!-- 로그인 -->
	SELECT  USER_PASSWORD, USER_AUTH,   USER_EMAILCHK
	FROM LPUSER
	WHERE LOWER(USER_EMAIL) = LOWER(#{user_email})  AND USER_DELFLAG ='F'





<!-- ///////////////////////정보수정 //////////////////////////-->

<!-- 일반회원 정보수정 (비밀번호)-->

UPDATE LPUSER SET USER_PASSWORD = #{user_password} WHERE USER_EMAIL = #{user_email} AND USER_AUTH = 'U'


<!-- 일반회원,API 정보수정 (닉네임) -->

UPDATE LPUSER SET USER_NICKNAME = #{user_nickname} WHERE USER_EMAIL = #{user_email}



<!-- 회원탈퇴 -->

UPDATE LPUSER SET USER_DELFLAG = 'T' WHERE USER_EMAIL = #{user_email}





<!--/////////////////////////////////// 이메일인증/////////////////////// -->

<!-- 이메일 키저장  ok-->
	UPDATE LPUSER SET USER_EMAILKEY = #{user_emailkey} WHERE USER_EMAIL = #{user_email}


<!-- 이메일 인증 상태 변경  ok  -->

	UPDATE LPUSER SET USER_EMAILCHK = 'Y' WHERE  USER_EMAIL = #{user_email}


<!-- 이메일로 온 비밀번호 수정 -->
	UPDATE LPUSER SET USER_PASSWORD = #{user_password} WHERE USER_EMAIL = #{user_email}



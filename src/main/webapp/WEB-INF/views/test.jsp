<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h3>InternalResourceViewResolver</h3>
	<p>DispatcherServlet에서 반환 받은 String 전후처리를 함</p>
	<a href="./init.do">init.do 호출 -> start 문자열을 반환 ->
		/WEB-INF/views/start.jsp</a>

	<h3>interceptor</h3>
	<!-- 라이프사이클을 따라가지 않는 빈들.. 처리해줄거? -->
	<p>가로채기 기술을 응용한 Bean Spring에서 흐름 및 제어를 하기 위함</p>
	<a href="./interceptor.do">servlet-context.xml에 설정을 하면 로그인 정보를
		담고S있는session을 확인</a>

	<hr>
	<h3>Email</h3>
	<p>email 서버를 제공해주는 환경을 servlet-context.xml에 설정 smtp 예) 구글 메일 사용</p>
	<form action="./mail.do" method="post">
		<input type="text" name="toEmail" placeholder="toEmail"><br>
		<input type="text" name="title" placeholder="title"><br>
		<textarea rows="4" cols="10" name="content" placeholder="content"></textarea>
		<br> <input type="submit" value="email 테스트">
	</form>

	<hr>
	<h3>데이터 베이스 연동</h3>
	<p>annotation-driven에 의해 호출된 Controller -> Service -> Repository ->
		SqlsessionTemplate</p>
	<button onclick="location.href='./jobAll.do'">데이터 전체보기</button>

	<hr>
	<h3>트렌젝션 실행</h3>
	<p>@Transactional을 통한 처리</p>
	<button onclick="location.href='./transaction.do'">트랜젝션 처리 되나?</button>

    <hr>
    <p>Spring security Password 보안 처리</p>
    <form action="./cryptographic.do" method="post">
         id : <input type="text" name="job_id"><br>    
         title : <input type="text" name="job_title"><br>    
         min_salary : <input type="text" name="min_salary"><br>    
         max_salary : <input type="text" name="max_salary"><br>    
         <input type="submit">    
    </form>
    
    <hr>
    <h3>암호화 값 비교</h3>
    <form action="./crytographicCompare.do" method="post">
      id : <input type="text" name="job_id"><br>
      title : <input type="text" name="job_title" value="123"><br>
      <input type="submit" value="전송">
    </form>
</body>
</html>
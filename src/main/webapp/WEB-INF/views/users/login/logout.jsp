<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그아웃 임시</title>
</head>
<body>

로그아웃 확인할라고 임시로 만든 페이지임
${session}
${ldto}
<form action="./logout.do" method="get">

<input type="submit" value="로그아웃">
</form>

</body>
</html>

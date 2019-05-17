<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 하러옴 regiForm페이지</title>
</head>
<script type="text/javascript" src="./js/jquery-3.3.1.js"></script>

<script type="text/javascript">

function regicheck() {
	 var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
     var getCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
     
     
     //비밀번호 똑같은지
     if($("#pw").val() != ($("#pwOK").val())){ 
     alert("비밀번호가 틀렸네용.");
     $("#tbPwd").val("");
     $("#cpass").val("");
     $("#tbPwd").focus();
     return false;
    }
     
     
}

</script>
<body>
<h1>환영합니다 ~~~~ landpeople</h1>

<div>

<form action="./signUp.do" method="post" onsubmit="return regicheck()">

<input type="text" name="user_email" id="email" placeholder="이메일" required="required">
<br>

<input type="text"  name="user_password" id="pw" placeholder="비밀번호" required="required" maxlength="12">
<br>&nbsp;<span id="pwresult">4~10자리의 영문+숫자</span><br>

<input type="text" id="pwOK" placeholder="비밀번호 확인" required="required" maxlength="12">
<br>&nbsp;<span id="pwchk"></span><br>

<input type="text" name="user_nickname" id="nickname" placeholder="닉네임" required="required" maxlength="10"><br><br>

<input type="submit" value="가입!">

<input type="button" value="돌아가기" onclick="javascript:history.back(-1)">
</form>
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/lp-style.css">

<title>여긴 로그인 페이지</title>
</head>
<body>
   <!--젤로 레이아웃- 전체 영역 감싸는 div-->
   <div class="main-wrapper">
      <h1 style="text-align: center">로그인 해주세요</h1>
      <form action="./login.do" method="post">
         <table>
            <tr>
               <td>
                  <input type="text" name="user_email" placeholder="이메일" required="required">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="text" name="user_password" placeholder="비밀번호" required="required">
               </td>
            </tr>
            <tr>
               <td>
                  <input type="submit" value="이메일 로그인">
               </td>
            </tr>
         </table>
      </form>
      <!-- </div> 여기까지 메인 컨텐츠  -->

      <form action="./regiForm.do" method="get">
         <input type="submit" value="회원가입">
      </form>
      ${url}

      <!-- 네이버 로그인 화면으로 이동 시키는 URL -->
      <!-- 네이버 로그인 화면에서 ID, PW를 올바르게 입력하면 callback 메소드 실행 요청 -->
      <div id="naver_id_login" style="text-align: center">
         <a href="${url}">
            <img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png" />
         </a>
      </div>
      <br>

      <!-- 구글 로그인 화면으로 이동 시키는 URL -->
      <!-- 구글 로그인 화면에서 ID, PW를 올바르게 입력하면 oauth2callback 메소드 실행 요청-->
      ${google_url}
      <div id="google_id_login" style="text-align: center">
         <a href="${google_url}">
            <img width="230" src="${pageContext.request.contextPath}/img/googlelogin.png" />
         </a>
      </div>
   </div>

</body>
</html>

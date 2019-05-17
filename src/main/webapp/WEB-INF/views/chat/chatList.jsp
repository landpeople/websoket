<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html id="html">
<head>
<meta charset="UTF-8">
<style>
#html,#body {
 width: 236px; height: 131px; margin: 0px;
}
</style>
<title>Insert title here</title>
</head>
<body id="body">

 채팅 리스트 페이지 : ${ldto.user_email }

   <div style="width: 100%; height: 45px; background-color: black; color: white;">접속한 사용자 정보</div>
   <div style="width: 100%; height: 100%; overflow: auto;">
      <c:forEach items="${users}" var="user">
         <c:if test="${ldto.user_email ne user}">
            <a href="#">${user}</a>
         </c:if>
      </c:forEach>
      <input id="refresh" type="button" value="새로고침"></input>
   </div>


   <script type="text/javascript">
         var refresh = document.getElementById("refresh");
         refresh.onclick = function() {
             alert("● chatList.jsp / 접속자 정보를 새로고침 합니다.");
             window.location.reload();
         };

      function click() { // 내부함수로 사용되며, thisHTML은 채팅을 하고 싶은 상대방의 닉네임을 가져옴
          alert("● chatList.jsp / 상대 : " + this.innerHTML);
          alert("● chatList.jsp / 나 : ${ldto.user_email}");
          window.open("./socketOpen.do?sender=${ldto.user_email}&receiver="+this.innerHTML,'resizable=yes,width=600px,height=600px');
      }

      var as = document.getElementsByTagName("a");
//       alert("● chatList.jsp / 세션에 접속한 인원(나를 제외) : " + as.length);

      [].forEach.call(as, function(e) {
          e.addEventListener("click", click); // 접속한 회원마다 이벤트를 붙여줌
      });
       </script>
</body>
</html>
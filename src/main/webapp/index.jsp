<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>

<script src="./js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./css/lp-style.css">
<link rel="stylesheet" href="./css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
    function sketchBookMake() {
	var user_email = "128@happy.com"
	//	alert();
	ajaxSketchMake(user_email);

    }

    var ajaxSketchMake = function(user_email) {
	//alert(user_email);

	$
		.ajax({
		    url : "sketchMakeForm.do",
		    type : "get",
		    data : {
			"user_email" : user_email
		    },
		    dataType : "json",
		    success : function(map) {

			if (map.user_iswrite == "F" || map.user_iswrite == null)
			    alert("작성권한이 없습니다.");
			else {
			    //alert(map.user_iswrite);
			    //alert(map.user_email);
			    $("#sketchForm").modal();
			    var htmlModal = "<input type='hidden' name='user_email' value='"+map.user_email+"'>"
				    +

				    "<div class='form-group'>"
				    + "<label>스케치북 제목</label>"
				    + "<div class='modal-input'>"
				    + "<input type='text' class='form-control' id='sketchtitle' name='sketch_title' style='width : 400px;' required='required'></div>"
				    + "</div>"
				    +

				    "<div class='form-group'>"
				    + "<label>스케치북 테마</label>"
				    + "<div class='themeradio'>"
				    + "<input type='radio' id='familytheme' name='sketch_theme' value='가족여행'><label for='familytheme'>가족여행</label>"
				    + "<input type='radio' id='solotheme' name='sketch_theme' value='나홀로여행'><label for='solotheme'>나홀로여행</label>"
				    + "<input type='radio' id='coupletheme' name='sketch_theme' value='연인과 함께'><label for='coupletheme'>연인과 함께</label>"
				    + "<input type='radio' id='friendtheme' name='sketch_theme' value='친구와 함께'><label for='friendtheme'>친구와 함께</label></div>"
				    + "</div>"
				    +

				    "<div class='form-group'>"
				    + "<label>스케치북 커버이미지</label>"
				    + "<input type='text' class='form-control' id='cover' name='coverimage' style='width : 400px;'>"
				    + "</div>"
				    +

				    "<div class='modal-footer'>"
				    + "<input class='btn btn-success' type='button' value='작성완료 ' onclick='sketchInsert()'>"
				    + "<button type='button' class='btn btn-default' data-dismiss='modal'>닫기</button>"
				    + "</div>";

			    $("#makeSketchBook").html(htmlModal);
			}

		    },
		    error : function() {
			alert("실패");
		    }
		});
    }

    function sketchInsert() {
	var sketch = document.getElementById("makeSketchBook");
	var sketch_theme = $("input[name=sketch_theme]:checked").val();
	sketch.action = "./writeSketch.do";
	var title = $("#sketchtitle").val();
	var theme = $("input[name=sketch_theme]:checked").length;

	if (title == "" || theme == 0) {
	    alert("스케치북 제목 혹은 스케치북 타입을 확인해주세요");
	} else if (title.length >= 20) {
	    alert("스케치북의 제목이 너무 깁니다.");
	    $("#sketchtitle").val("");
	} else {
	    sketch.submit();
	    alert("스케치북 작성완료");
	}

    }
</script>
</head>
<body>
   <!--젤로 레이아웃- 전체 영역 감싸는 div-->
   <div class="main-wrapper">
      <!-- SIDEBAR -->
      <div class="sidebar-menu">
         <div class="top-section">
            <!-- 프로필 사진 영역 전체 감싸는  div -->
            <div class="profile-image"></div>
         </div>
         <!-- 여기까지 프로필 사진 영역 전체 감싸는 div -->

         <!-- 네비게이션 메뉴 -->
         <div class="main-navigation">
            <ul class="navigation">
               <li><a href="./loginPage.do">로그인 </a></li>
               <li><a href="./logout.do">로그아웃</a></li>
               <li><a href="#" onclick="sketchBookMake()">여행일정 작성</a></li>
               <li><a href="#">마이페이지</a></li>
               <li><a href="#">관리자 페이지</a></li>
            </ul>
         </div>
         <!-- .main-navigation 여기까지 네비게이션 메뉴 -->

         <!-- 채팅 -->
         <div class="chatting">
            <iframe class="panel" id="lot" frameborder="0"></iframe>
         </div>
         <!-- 채팅 -->
      </div>
      <!-- .sidebar-menu 여기까지 사이드 바 -->
      
		<div class="content-wrapper">
			<!-- 헤더 그림 -->
			<div class="banner-bg" id="top">
				<div class="banner-overlay"></div>
				<div class="welcome-text"></div>
			</div>
			<!-- 메인 컨텐츠   -->
			<div class="main-lpcontents">
            <div class="content">
               <a href="./test.do">테스트 페이지로 이동</a>
               <br>
               <a href="./kim.do">김태우 페이지로 이동</a>
               <br>
               <a href="./na.do">나원서 페이지로 이동</a>
               <br>
               <a href="./lee.do">이연지 페이지로 이동</a>
               <br>
               <a href="./jang.do">장석영 페이지로 이동</a>
               <br>
               <a href="./jung.do">정희태 페이지로 이동</a>
               <br>
               <a href="./cho.do">조태규 페이지로 이동</a>
               <br>
                <!-- 스케치북 생성 Modal -->
               <div class="modal fade" id="sketchForm" role="dialog">
                  <div class="modal-dialog">
                     <div class="modal-content">
                        <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal">&times;</button>
                           <h4 class="modal-title">스케치북 작성</h4>
                        </div>
                        <div class="modal-body">
                           <form action="#" role="form" method="post" id="makeSketchBook"></form>

                        </div>
                     </div>
                  </div>
               </div>
               <!-- 여기까지 스케치북 생성 Modal -->
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>
</body>
</html>

<!-- </head> -->
<!-- <body> -->
<!--    <!--젤로 레이아웃- 전체 영역 감싸는 div--> -->
<!--    <div class="main-wrapper"> -->

<!--       SIDEBAR -->
<!--       <div class="sidebar-menu"> -->
<!--          <div class="top-section"> -->
<!--             프로필 사진 영역 전체 감싸는  div -->
<!--             <div class="profile-image"></div> -->
<!--          </div> -->
<!--          여기까지 프로필 사진 영역 전체 감싸는 div -->

<!--          네비게이션 메뉴 -->
<!--          <div class="main-navigation"> -->
<!--             <ul class="navigation"> -->
<!--                <li><a href="#">로그인/로그아웃</a></li> -->
<!--                <li><a href="#" onclick="sketchBookMake()">여행일정 작성</a></li> -->
<!--                <li><a href="#">마이페이지/관리자 페이지</a></li> -->
<!--             </ul> -->
<!--          </div> -->
<!--          .main-navigation 여기까지 네비게이션 메뉴 -->

<!--          채팅 -->
<!--          <div class="chatting"> -->
<!--             	<iframe src="http://www.daum.net"></iframe> -->
<!--          </div> -->
<!--          채팅 -->
<!--       </div> -->
<!--       .sidebar-menu 여기까지 사이드 바 -->

<!--       <div class="content-wrapper"> -->
<!--          헤더 그림 -->
<!--          <div class="banner-bg" id="top"> -->
<!--             <div class="banner-overlay"></div> -->
<!--             <div class="welcome-text"></div> -->
<!--          </div> -->
<!--          메인 컨텐츠   -->
<!--          <div class="main-lpcontents"> -->
<!--             <div class="content"> -->
<!--                <a href="./test.do">테스트 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./kim.do">김태우 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./na.do">나원서 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./lee.do">이연지 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./jang.do">장석영 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./jung.do">정희태 페이지로 이동</a> -->
<!--                <br> -->
<!--                <a href="./cho.do">조태규 페이지로 이동</a> -->
<!--                <br> -->
<!--                스케치북 생성 Modal -->
<!--                <div class="modal fade" id="sketchForm" role="dialog"> -->
<!--                   <div class="modal-dialog"> -->
<!--                      <div class="modal-content"> -->
<!--                         <div class="modal-header"> -->
<!--                            <button type="button" class="close" data-dismiss="modal">&times;</button> -->
<!--                            <h4 class="modal-title">스케치북 작성</h4> -->
<!--                         </div> -->
<!--                         <div class="modal-body"> -->
<!--                            <form action="#" role="form" method="post" id="makeSketchBook"></form> -->

<!--                         </div> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                여기까지 스케치북 생성 Modal -->
<!--             </div> -->
<!--          </div> -->
<!--           여기까지 메인 컨텐츠  -->
<!--          <div class="footer">landpeople</div> -->
<!--       </div> -->
<!--    </div> -->
<!-- </body> -->
<!-- </html> -->
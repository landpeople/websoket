<%@page import="java.util.List"%>
<%@page import="happy.land.people.dto.kim.LPDaysDto"%>
<%@page import="happy.land.people.dto.kim.LPCanvasDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	LPCanvasDto canvasDto = (LPCanvasDto) session.getAttribute("canvas");
	List<LPDaysDto> daysList = (List<LPDaysDto>) session.getAttribute("days");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김태우 화면 테스트</title>

<script src="./js/jquery-3.3.1.js"></script>
<!-- 책모양  -->
<link href="./css/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>

<script src="./js/vendor/modernizr-2.6.2.min.js"></script>
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- 카카오 지도를 위한 js파일 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=559fa9d8ea227159941f35acba720d2b&libraries=services"></script>



</head>
<body>

   <!--젤로 레이아웃- 전체 영역 감싸는 div-->
   <div class="main-wrapper">
      <%@include file="./common/Sidebar.jsp"%>
      <div class="content-wrapper">

         <!-- 메인 컨텐츠   -->
         <div class="lpcontents">
            <div class="content">
               <div id="mybook" style="border: 1px solid black;">
                  <div id="page"></div>
                  <div>
                     <div id='map' style='width: 440px; height: 560px;'></div>
                     <input id="updateCanvas" type="button" value="수정완료"></input>
                  </div>
               </div>
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>



<!--    <!-- SIDEBAR --> -->
<!--    <div class="sidebar-menu hidden-xs hidden-sm"> -->
<!--       <div class="top-section" style="padding-bottom: 0;"> -->
<!--          <div class="profile-image"> -->
<!--             <img src="img/제주배경임.png" alt="Volton"> -->
<!--          </div> -->
<!--           <h3 class="profile-title">Volton</h3>
<!--                 <p class="profile-description">Digital Photography</p> --> -->
<!--       </div> -->
<!--       .top-section -->
<!--       <div class="main-navigation"> -->
<!--          <ul class="navigation"> -->
<!--             <li><a href="#"> -->
<!--                   <i class="fa fa-globe"></i>Welcome -->
<!--                </a></li> -->
<!--             <li><a href="#"> -->
<!--                   <i class="fa fa-pencil"></i>About Me -->
<!--                </a></li> -->
<!--             <li><a href="#"> -->
<!--                   <i class="fa fa-paperclip"></i>My Gallery -->
<!--                </a></li> -->
<!--             <li><a href="#"> -->
<!--                   <i class="fa fa-link"></i>Contact Me -->
<!--                </a></li> -->
<!--          </ul> -->
<!--       </div> -->
<!--       .main-navigation -->

<!--       채팅 -->
<!--       <div class="chatting"></div> -->
<!--    </div> -->
<!--    <!-- .sidebar-menu --> -->

<!--    <div class="main-content"> -->

<!--       <div id="mybook" style="border: 1px solid black;"> -->

<!--          <div id="page"></div> -->
<!--          <div> -->
<!--             <div id='map' style='width: 440px; height: 560px;'></div> -->
<!--             <input id="updateCanvas" type="button" value="수정완료"></input> -->
<!--          </div> -->
<!--       </div> -->
<!--    </div> -->

   <!-- 여기에 div 잡아서 작업하면 됨 -->
   <!-- templatemo-style.css에 보면 이안에 들어가는 div 클래스가 있음. 아니면 css를 temp -->
   <script type="text/javascript">		
	 //책 모양 가져오기
	    $('#mybook').booklet({
	    		width:  960,
	            height: 650,
	            shadow: false,	           
	    });
	 
	 // 카카오 지도
	 var container = document.getElementById("map");
	    		var options = {
	    			center: new daum.maps.LatLng(<%=daysList.get(0).getDays_x()%>, <%=daysList.get(0).getDays_y()%>),
	    			level: 5,
	    			disableDoubleClickZoom : true			
	    		};	    		
	 var map = new daum.maps.Map(container, options);
	  
	 // 일정 마커들
	 var daysMarker = [];
	 // 일정 마커들의 인포윈도우
		var daysInfo = [];		
		// 윈포 윈도우가 열려있는지 확인
		var isInsertOpen = false;
		// 일정 마커들의 시작시간,종료시간 정보
		var daysStart = [];
		var daysEnd = [];				
		// 선 정보를 담고있는 변수		
		var polyline;
		
		// 일정 마커들 정보 가져오기
		<%for (int j = 0; j < daysList.size(); j++) {%>
		// 마커 등록
		daysMarker[<%=j%>] = new daum.maps.Marker({ 			    
			position: new daum.maps.LatLng(<%=daysList.get(j).getDays_x()%>,<%=daysList.get(j).getDays_y()%>),
			clickable: true				   
		});
		// 인포 정보 등록
		daysInfo[<%=j%>] = '<%=daysList.get(j).getDays_title()%>';
		
		var infowindow = new daum.maps.InfoWindow({
	        content: '<div><%=daysList.get(j).getDays_title()%>
		</div>', // 인포윈도우에 표시할 내용
			    removable : true
			});
		// 시작시간 , 종료시간 

		daysStart.push(
	    <%=daysList.get(j).getDays_sdate().getHours()%>
		+ ":"
			+
	    <%=daysList.get(j).getDays_sdate().getMinutes()%>
		);
		daysEnd.push(
	    <%=daysList.get(j).getDays_edate().getHours()%>
		+ ":"
			+
	    <%=daysList.get(j).getDays_edate().getMinutes()%>
		);
		// 마커에  이벤트 등록	   
		daum.maps.event.addListener(daysMarker[
	    <%=j%>
		], 'click',
			makeOverListener(map, daysMarker[
	    <%=j%>
		], infowindow));
		daum.maps.event.addListener(daysMarker[
	    <%=j%>
		], 'dragend',
			initRender);
	    <%}%>
		// 지도에 마커를 표시합니다
		for (var i = 0; i < daysMarker.length; i++) {
		    daysMarker[i].setMap(map);
		    daysMarker[i].setDraggable(true);
		}
		// 선을 그려줌
		createRender();

		// 일정 페이지 정보 가져오기
		var daysPage = document.getElementById("page");

		for (var i = 0; i < daysMarker.length; i++) {
		    var div = document.createElement('div');
		    if (i >= 1) {
			//시작 지점 과 끝지점 가져와서 최단거리 설정
			div.innerHTML += "↓";
			var startCoord = new daum.maps.LatLng(daysMarker[i - 1]
				.getPosition().getLat(), daysMarker[i - 1]
				.getPosition().getLng());
			var endCoord = new daum.maps.LatLng(daysMarker[i]
				.getPosition().getLat(), daysMarker[i]
				.getPosition().getLng());
			div.innerHTML += "<a href='https://map.kakao.com/?sX="
				+ startCoord.toCoords().getX()
				+ "&sY="
				+ startCoord.toCoords().getY()
				+ "&sName=출발점&eX="
				+ endCoord.toCoords().getX()
				+ "&eY="
				+ endCoord.toCoords().getY()
				+ "&eName=도착점'"
				+ " onclick='window.open(this.href, \"_경로보기\", \"width=1000px,height=800px;\"); return false;'"
				+ ">최단경로보기</a><br>";
		    }
		    div.innerHTML += "<span>"
			    + (i + 1)
			    + "번째 일정:"
			    + daysInfo[i]
			    + "</span>"
			    + "<input type='button' class='deleteDays' title='"+i+"' value='일정삭제'>";
		    daysPage.appendChild(div);
		}

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
			infowindow.open(map, marker);
		    };
		}
		// 초기화 후 그려주기
		function initRender() {
		    if (polyline != null) {
			polyline.setMap(null);
			initLine();
		    }
		}
		// 생성시 그려주기
		function createRender() {
		    initLine();
		}

		// 라인  그려주기
		function initLine() {
		    var linePath = [];
		    for (var i = 0; i < daysMarker.length; i++) {
			var path = new daum.maps.LatLng(daysMarker[i]
				.getPosition().getLat(), daysMarker[i]
				.getPosition().getLng());
			linePath.push(path);
		    }
		    if (daysMarker.length >= 2) {
			// 지도에 표시할 선을 생성합니다
			polyline = new daum.maps.Polyline({
			    path : linePath, // 선을 구성하는 좌표배열 입니다
			    strokeWeight : 5, // 선의 두께 입니다
			    strokeColor : '#FF0000', // 선의 색깔입니다
			    strokeOpacity : 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle : 'solid' // 선의 스타일입니다
			});
			// 지도에 선을 표시합니다 
			polyline.setMap(map);
		    }
		}

		// 지도 클릭시 일정 등록
		daum.maps.event
			.addListener(
				map,
				'click',
				function(mouseEvent) {
				    if (isInsertOpen != true) {

					// 클릭한 위도, 경도 정보를 가져옵니다 
					var latlng = mouseEvent.latLng;

					// 마커 생성			
					marker = new daum.maps.Marker({
					    position : new daum.maps.LatLng(
						    latlng.getLat(), latlng
							    .getLng()),
					    clickable : true
					});
					marker.setMap(map);
					marker.setDraggable(true);
					// 입력 윈도우를 생성합니다
					infoWindow = new daum.maps.InfoWindow(
						{
						    content : '<div style="width:200px; height:140px;">일정제목 &nbsp;<input style="width:100px; height=30px;" type="text" id="daysTitle">'
							    + '<br>시작시간:&nbsp;<input id="startDays" style="width:120px; height=40px; text-align:center;" type="time">'
							    + '<br>종료시간:&nbsp;<input id="endDays" style="width:120px; height=40px; text-align:center;" type="time">'
							    + '<br><br><button style="width:100px; height=30px;" onclick="daysMake()">일정등록</button><button style="width:100px; height=30px;" onclick="closeInfo()">취소</button></div>',
						});
					infoWindow.open(map, marker);
					isInsertOpen = true;
					map.setDraggable(false);
					map.setZoomable(false);
				    }
				});

		// 일정 만들기
		function daysMake() {
		    var title = document.getElementById('daysTitle').value;
		    var startDays = $('#startDays').val();
		    var endDays = $('#endDays').val();
		    if (title == "" || title == null) {
			alert("일정 제목을 입력해주세요.");
		    } else if (startDays == "" || startDays == null) {
			alert("시작 시간을 입력해주세요.");
		    } else if (endDays == "" || endDays == null) {
			alert("종료 시간을 입력해주세요.");
		    } else {
			// 완성이 되면 넣고 아니면 넣지 않는다.
			daysMarker.push(marker);
			marker.setMap(null);
			daysMarker[daysMarker.length - 1].setMap(map);
			// 내용에 넣기
			daysInfo.push(title);
			daysStart.push($('#startDays').val());
			daysEnd.push($('#endDays').val());

			// 클릭 이벤트 설정
			var addwindow = new daum.maps.InfoWindow({
			    content : '<div>' + title + '</div>', // 인포윈도우에 표시할 내용
			    removable : true
			});
			// 마커에  이벤트 등록	
			daum.maps.event.addListener(
				daysMarker[daysMarker.length - 1], 'click',
				makeOverListener(map,
					daysMarker[daysMarker.length - 1],
					addwindow));
			// 생성시 그리기
			createRender();

			// 일정 페이지 정보 가져오기
			var daysPage = document.getElementById("page");
			var div = document.createElement('div');

			if (daysMarker.length >= 2) {
			    //시작 지점 과 끝지점 가져와서 최단거리 설정
			    div.innerHTML += "↓";
			    var startCoord = new daum.maps.LatLng(
				    daysMarker[daysMarker.length - 2]
					    .getPosition().getLat(),
				    daysMarker[daysMarker.length - 2]
					    .getPosition().getLng());
			    var endCoord = new daum.maps.LatLng(
				    daysMarker[daysMarker.length - 1]
					    .getPosition().getLat(),
				    daysMarker[daysMarker.length - 1]
					    .getPosition().getLng());
			    div.innerHTML += "<a href='https://map.kakao.com/?sX="
				    + startCoord.toCoords().getX()
				    + "&sY="
				    + startCoord.toCoords().getY()
				    + "&sName=출발점&eX="
				    + endCoord.toCoords().getX()
				    + "&eY="
				    + endCoord.toCoords().getY()
				    + "&eName=도착점'"
				    + " onclick='window.open(this.href, \"_경로보기\", \"width=1000px,height=800px;\"); return false;'"
				    + ">최단경로보기</a><br>";
			}
			div.innerHTML += "<span>"
				+ daysMarker.length
				+ "번째 일정:"
				+ title
				+ "</span>"
				+ "<input type='button' class='deleteDays' title='"+i+"' value='일정삭제'>";
			daysPage.appendChild(div);
			infoWindow.close();
			isInsertOpen = false;
			map.setDraggable(true);
			map.setZoomable(true);
		    }
		}
		// 일정 등록시 info메세지 닫기
		function closeInfo() {
		    infoWindow.close();
		    isInsertOpen = false;
		    map.setDraggable(true);
		    map.setZoomable(true);
		    marker.setMap(null);
		}

		// 수정
		$("#updateCanvas").click(function() {
		    //alert(daysMarker[0].getPosition().getLat());		
		    var jsonObj = {};
		    for (var i = 0; i < daysMarker.length; i++) {
			var testVal = {
			    'title' : String(daysInfo[i]),
			    'content' : "내용" + i,
			    'startDate' : "2019-05-14 " + daysStart[i] + ":00",
			    'endDate' : "2019-05-14 " + daysEnd[i] + ":00",
			    'x' : String(daysMarker[i].getPosition().getLat()),
			    'y' : String(daysMarker[i].getPosition().getLng()),
			    'address' : "제주특별자치도 서귀포시 성산읍 고성리 127-2"
			};
			jsonObj["days" + i] = testVal;
		    }
		    alert(jsonObj);
		    $.ajax({
			url : "updateDaysCanvas.do", //요청 url
			type : "post", // 전송 처리방식
			asyn : false, // true 비동기 false 동기
			contentType : 'application/json',
			data : JSON.stringify(jsonObj), // 서버 전송 파라메터
			dataType : "json", // 서버에서 받는 데이터 타입
			success : function(msg) {
			    alert("성공");
			},
			error : function() {
			    alert("삶의 지혜가 부족하다.");
			}
		    });
		});

		$('.deleteDays').click(
			function() {
			    // 지울려는 배열 번호
			    var number = $(this).attr("title");
			    if (daysMarker.length == 1) {
				alert("일정을 한개이상 입력하셔야 합니다.");
			    } else {
				// 해당 일정의 데이터들 지우기
				daysMarker[number].setMap(null);
				daysMarker.splice(number, 1);
				daysInfo.splice(number, 1);
				daysStart.splice(number, 1);
				daysEnd.splice(number, 1);

				alert(daysMarker);
				// 선 다시 그려주기
				initRender();
				var diffDays = document
					.getElementsByClassName("deleteDays");
				var diffNum;
				for (var i = 0; i < diffDays.length; i++) {
				    diffNum = parseInt(diffDays[i].title);
				    if (diffNum > parseInt(number)) {
					diffDays[i].title = --diffNum;
				    }
				}

				$(this).closest('div').remove();
				if (number == "0") {
				    // 0일경우 다음 일정에 있는 최단경로보기 찍어준 링크 찾아서 지워주기						
				    $('.deleteDays').parent().children('a')
					    .remove();
				}
			    }
			});
	    </script>

</body>
</html>
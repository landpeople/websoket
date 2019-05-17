<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                  <div id="page3" style="width: 470px; height: 630px; overflow: auto; background-color: lime;">
                     페이지 제목:
                     <input type="text" id="pageTitle">
                  </div>
                  <div>
                     <a href="./loadMap.do">아아아</a>
                     <button onclick="showFood()">음식점</button>
                     <button onclick="showTrip()">관광지</button>
                     <button onclick="showRest()">숙소</button>
                     <div id="map" style="width: 440px; height: 560px;"></div>
                     <input id="insertCanvas" type="button" value="DB에 저장"></input>
                  </div>
               </div>
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>


   <!-- main에 있는 header 영역임 main 페이지 말고는 사용을 안하지만, 그냥 주석함. 지워도 됨-->
   <!-- <div class="banner-bg" id="top"> -->
   <!-- 	<div class="banner-overlay"></div> -->
   <!-- 		<div class="welcome-text"> -->
   <!-- 			<h2>LandPeople</h2> -->
   <!--            <h5>This is a mobile friendly layout with Bootstrap v3.3.1 framework. Maecenas eu ante at nunc posuere fringilla sit amet non dolor. Proin condimentum fermentum nunc.</h5> -->
   <!--        </div> -->
   <!--    </div> -->
   <!-- </div> -->

   <!-- 여기에 div 잡아서 작업하면 됨 -->
   <!-- templatemo-style.css에 보면 이안에 들어가는 div 클래스가 있음. 아니면 css를 temp -->

   <script>
		//첫번째 일정 표시
		var daysNum = 1;
		//다음 맵 세팅
		var container = document.getElementById('map');
		var options = {
		    center : new daum.maps.LatLng(33.450701, 126.570667),
		    level : 3,
		    disableDoubleClickZoom : true
		};
		var map = new daum.maps.Map(container, options);
		// 관광지/음식점/숙소 마커들
		var markers = [];
		// 일정 마커들
		var daysMarker = [];
		// 일정 마커들의 인포윈도우
		var daysInfo = [];
		// 일정 마커들의 시작시간,종료시간 정보
		var daysStart = [];
		var daysEnd = [];

		//클릭시 나오는 임시 마커
		var marker;
		//입력 윈도우
		var infoWindow;
		// 윈도우 창이 열려있는지 확인
		var isInsertOpen = false;
		// 선 그려주는 변수
		var polyline = null;
		/* var icon = new daum.maps.MarkerImage(
		        './food.png',
		        new daum.maps.Size(32, 32)); */
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
					//마커에 넣기
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
			daum.maps.event.addListener(
				daysMarker[daysMarker.length - 1], 'dragend',
				initRender);
			// 선 그리기
			createRender();
			// 일정 페이지 정보 가져오기
			var daysPage = document.getElementById("page3");
			var div = document.createElement('div');

			if (daysNum >= 2) {
			    //시작 지점 과 끝지점 가져와서 최단거리 설정
			    div.innerHTML += "↓";
			    var startCoord = new daum.maps.LatLng(
				    daysMarker[daysNum - 2].getPosition()
					    .getLat(), daysMarker[daysNum - 2]
					    .getPosition().getLng());
			    var endCoord = new daum.maps.LatLng(
				    daysMarker[daysNum - 1].getPosition()
					    .getLat(), daysMarker[daysNum - 1]
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
				+ daysNum
				+ "번째 일정:"
				+ title
				+ "</span>"
				+ "<input type='button' class='deleteDays' title='"
				+ (daysNum - 1) + "' value='일정삭제'>";
			daysPage.appendChild(div);
			infoWindow.close();
			isInsertOpen = false;
			map.setDraggable(true);
			map.setZoomable(true);
			daysNum++;
		    }
		}
		// 초기화 후 그려주기
		function initRender() {
		    if (polyline != null) {
			polyline.setMap(null);
			render();
		    }
		}
		// 생성시 그려주기
		function createRender() {
		    render();
		}
		// 그려주기
		function render() {
		    var linePath = [];
		    // 지도에 라인을 표시합니다.
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
		// 일정 등록시 info메세지 닫기
		function closeInfo() {
		    infoWindow.close();
		    isInsertOpen = false;
		    map.setDraggable(true);
		    map.setZoomable(true);
		    marker.setMap(null);
		}
		// db에 저장
		$("#insertCanvas").click(function() {

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
			url : "insertDaysCanvas.do", //요청 url
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

		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
			infowindow.open(map, marker);
		    };
		}

		//https://map.kakao.com/?sX=400437.5000000028&sY=-11539.999999998836&sName=%EC%9A%B0%EB%A6%AC%EC%A7%91&eX=400437.5000000028&eY=-11538.999999998836&eName=%EC%97%AD%EC%82%BC%EC%97%AD
		//alert(coord.toCoords().getX());
		//alert(coord.toCoords().getY());

		//wtmX = 160082.538257218, // 변환할 WTM X 좌표 입니다
		// wtmY = -4680.975749087054; // 변환할 WTM Y 좌표 입니다
		// var ps = new daum.maps.services.Places(); 

		/*  // 키워드로 장소를 검색합니다
		 ps.keywordSearch('쇠소깍', placesSearchCB); 

		 // 키워드 검색 완료 시 호출되는 콜백함수 입니다
		 function placesSearchCB (data, status, pagination) {
		     if (status === daum.maps.services.Status.OK) {

		         // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		         // LatLngBounds 객체에 좌표를 추가합니다
		         var bounds = new daum.maps.LatLngBounds();

		         for (var i=0; i<data.length; i++) {
		             displayMarker(data[i]);    
		             bounds.extend(new daum.maps.LatLng(data[i].y, data[i].x));
		         }       

		         // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		         map.setBounds(bounds);
		     } 
		 } */

		// 지도에 마커를 표시하는 함수입니다
		/*  function displayMarker(place) {	     
		     // 마커를 생성하고 지도에 표시합니다
		     var marker = new daum.maps.Marker({
		         map: map,
		         position: new daum.maps.LatLng(place.y, place.x) 
		     });	   
		 } */

		function showFood() {
		    alert("음식점 보여주기");
		    for (var i = 0; i < markers.length; i++)
			markers[i].setMap(null);

		    $
			    .ajax({
				url : "showFood.do", //요청 url
				type : "post", // 전송 처리방식
				asyn : false, // true 비동기 false 동기
				data : {
				    'type' : "음식점"
				}, // 서버 전송 파라메터
				dataType : "json", // 서버에서 받는 데이터 타입
				success : function(msg) {
				    alert(msg.result[0].map_id);
				    for (var i = 0; i < msg.result.length; i++) {
					var foodMarker = new daum.maps.Marker({
					    position : new daum.maps.LatLng(
						    msg.result[i].map_y,
						    msg.result[i].map_x),
					    clickable : true
					});

					// 지도에 마커를 표시합니다
					foodMarker.setMap(map);
					markers.push(foodMarker);
					var foodMarkerInfo = new daum.maps.InfoWindow(
						{
						    content : '<div style="width:200px; height:90px; padding:5px;">'
							    + msg.result[i].map_title
							    + '</div><button style="width:99px; height:30px">일정등록</button><button style="width:99px; height:30px">닫기</button>',
						    removable : true
						});

					(function(foodMarker, foodMarkerInfo) {
					    // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
					    daum.maps.event
						    .addListener(
							    foodMarker,
							    'click',
							    function() {
								// 마커 위에 인포윈도우를 표시합니다						    
								foodMarkerInfo
									.open(
										map,
										foodMarker);
							    });
					})(foodMarker, foodMarkerInfo);

				    }
				},
				error : function() {
				    alert("실패");
				}
			    });
		}

		// 관광지보기
		function showTrip() {
		    for (var i = 0; i < markers.length; i++)
			markers[i].setMap(null);

		    $
			    .ajax({
				url : "showTrip.do", //요청 url
				type : "post", // 전송 처리방식
				asyn : false, // true 비동기 false 동기
				data : {
				    'type' : "관광"
				}, // 서버 전송 파라메터
				dataType : "json", // 서버에서 받는 데이터 타입
				success : function(msg) {
				    alert(msg.result[0].map_id);
				    for (var i = 0; i < msg.result.length; i++) {
					var foodMarker = new daum.maps.Marker({
					    position : new daum.maps.LatLng(
						    msg.result[i].map_y,
						    msg.result[i].map_x),
					    clickable : true
					});

					// 지도에 마커를 표시합니다
					foodMarker.setMap(map);
					markers.push(foodMarker);
					var foodMarkerInfo = new daum.maps.InfoWindow(
						{
						    content : '<div style="padding:5px;">'
							    + msg.result[i].map_title
							    + '</div><button>일정등록</button><button>닫기</button>',
						    removable : true
						});

					(function(foodMarker, foodMarkerInfo) {
					    // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
					    daum.maps.event
						    .addListener(
							    foodMarker,
							    'click',
							    function() {
								// 마커 위에 인포윈도우를 표시합니다						    
								foodMarkerInfo
									.open(
										map,
										foodMarker);
							    });
					})(foodMarker, foodMarkerInfo);

				    }
				},
				error : function() {
				    alert("실패");
				}
			    });
		}

		// 숙소 보기
		function showRest() {
		    for (var i = 0; i < markers.length; i++)
			markers[i].setMap(null);

		    $
			    .ajax({
				url : "showRest.do", //요청 url
				type : "post", // 전송 처리방식
				asyn : false, // true 비동기 false 동기
				data : {
				    'type' : "숙박"
				}, // 서버 전송 파라메터
				dataType : "json", // 서버에서 받는 데이터 타입
				success : function(msg) {
				    alert(msg.result[0].map_id);
				    for (var i = 0; i < msg.result.length; i++) {
					var foodMarker = new daum.maps.Marker({
					    position : new daum.maps.LatLng(
						    msg.result[i].map_y,
						    msg.result[i].map_x),
					    clickable : true
					});

					// 지도에 마커를 표시합니다
					foodMarker.setMap(map);
					markers.push(foodMarker);
					var foodMarkerInfo = new daum.maps.InfoWindow(
						{
						    content : '<div style="padding:5px;">'
							    + msg.result[i].map_title
							    + '</div><button>일정등록</button><button>닫기</button>',
						    removable : true
						});

					(function(foodMarker, foodMarkerInfo) {
					    // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
					    daum.maps.event
						    .addListener(
							    foodMarker,
							    'click',
							    function() {
								// 마커 위에 인포윈도우를 표시합니다						    
								foodMarkerInfo
									.open(
										map,
										foodMarker);
							    });
					})(foodMarker, foodMarkerInfo);

				    }
				},
				error : function() {
				    alert("실패");
				}
			    });
		}

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
   <script type="text/javascript">
		$(function() {
		    //single book
		    $('#mybook').booklet({
			width : 960,
			height : 650,
			shadow : false
		    });
		});
	    </script>
</body>
</html>
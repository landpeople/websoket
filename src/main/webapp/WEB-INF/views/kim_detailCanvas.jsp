<%@page import="happy.land.people.dto.kim.LPCanvasDto"%>
<%@page import="java.util.Map"%>
<%@page import="happy.land.people.dto.kim.LPDaysDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>김태우 화면 테스트</title>
<%
	Map<Integer,List<LPDaysDto>>  daysList = (Map<Integer,List<LPDaysDto>>)request.getAttribute("daysList");
	List<LPCanvasDto>	 canvasList = 	(List<LPCanvasDto>)request.getAttribute("daysType");
%>

<script src="./js/jquery-3.3.1.js"></script>

<!-- 책모양  -->
<script src="./js/jquery-ui.js"></script>
<script src="./js/jquery.easing.1.3.js"></script>
<script src="./js/jquery.booklet.latest.min.js"></script>
<link href="./css/jquery.booklet.latest.css" type="text/css" rel="stylesheet" media="screen, projection, tv" />

<script src="./js/vendor/modernizr-2.6.2.min.js"></script>
<script src="./js/min/plugins.min.js"></script>
<script src="./js/min/main.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<!-- 카카오 지도를 위한 js파일 -->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=559fa9d8ea227159941f35acba720d2b&libraries=services"></script>

</head>
<body>
   <div class="main-wrapper">
      <%@include file="./common/Sidebar.jsp"%>
      <div class="content-wrapper">

         <!-- 메인 컨텐츠   -->
         <div class="lpcontents">
            <div class="content">
               <input type="button" id="downloadExcel">
               <a href="./canvasDownloadExcel.do">테스트용 엑셀 다운로드</a>
               <a href="./canvasDownloadImage.do">테스트용 이미지 다운로드</a>
               <div id="mybook" style="border: 1px solid black;">
                  <div>입력된 캔버스가 없습니다.</div>
                  <div>입력된 캔버스가 없습니다.</div>
               </div>
               <button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">캔버스 입력</button>
               <input type="button" id="pageUpdate" value="페이지 수정"></input>
               <input type="button" id="pageDelete" value="페이지 삭제"></input>
               <input type="hidden" value="0" id="selectType">

               <form action="./insertDaysForm.do" onsubmit="return false" method="post">
                  <input type="hidden" value=1 id="nowPageNo" name="nowPageNo">
               </form>

               <!-- <form action="./updateDaysForm.do" onsubmit="return false" method="post">
            <input type="hidden" value=1 id="nowPageNo" name="nowPageNo">        
         </form>
         
         <form action="./deleteDaysForm.do" onsubmit="return false" method="post">
            <input type="hidden" value=1 id="nowPageNo" name="nowPageNo">        
         </form> -->

               <!-- Modal -->
               <div class="modal fade" id="myModal" role="dialog">
                  <div class="modal-dialog">

                     <!-- Modal content-->
                     <div class="modal-content" style="width: 1000px; height: 800px;">
                        <div class="modal-header">
                           <button type="button" class="close" data-dismiss="modal">&times;</button>
                           <h4 class="modal-title">Modal Header</h4>
                        </div>
                        <div class="modal-body">
                           <p>
                              <img src="./img/days.png" id="insertDaysForm"></img> <img src="./img/free2.png"></img> <img src="./img/free2.png"></img><br> <img src="./img/free3.png"></img> <img src="./img/free4.png"></img> <img src="./img/free5.png"></img>
                           </p>
                        </div>
                        <div class="modal-footer">
                           <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                           <button type="button" class="btn btn-default" id="canvasInsertFrom">ok</button>
                        </div>
                     </div>

                  </div>
               </div>
            </div>
         </div>
         <!-- </div> 여기까지 메인 컨텐츠  -->
         <div class="footer">landpeople</div>
      </div>
   </div>

 <script>  		
	$("document").ready(function() {		
		 //책 모양 가져오기
 	    $('#mybook').booklet({
 	    		width:  960,
 	            height: 650,
 	            shadow: false,
 	           change: function(event, data) { 
 	  			  $('#nowPageNo').val(data.index/2+1);
 	  		   }
 	    });				 
		// 일정 캔버스 클릭시(임시)
		$("#insertDaysForm").click(function(){
			$('#selectType').val("1");
			alert($('#selectType').val());
		});
		// 엑셀로 다운로드
		$("#downloadExcel").click(function() {
			alert("엑셀다운~");
		});
		// 수정 버튼 클릭시
		$("#pageUpdate").click(function() {
			alert("수정");			
			//location.href="./updateDaysForm.do?pageNo="+pageNo;			
			var updateForm = $('<form></form>');
			updateForm.attr('action', './updateDaysForm.do');
		    updateForm.attr('method', 'post');		    
		    updateForm.appendTo('body');		 
		    // 페이지 번호 받아옴
		    var pageNo = $('<input type="hidden" name="nowPageNo">');
		    pageNo.val($('#nowPageNo').val());
		    // 세션에 등록된 스케치북 받아오기		 
		    updateForm.append(pageNo);
		    updateForm.submit();	
		});
		//삭제 버튼 클릭시
		$("#pageDelete").click(function() {
			alert("삭제");
			
			var deleteForm = $('<form></form>');
			deleteForm.attr('action', './deleteDaysForm.do');
			deleteForm.attr('method', 'post');		    
			deleteForm.appendTo('body');		 
		    // 페이지 번호 받아옴
		    var pageNo = $('<input type="hidden" name="nowPageNo">');
		    pageNo.val($('#nowPageNo').val());
		    // 세션에 등록된 스케치북 받아오기		 
		    deleteForm.append(pageNo);
		    deleteForm.submit();	
		});
		
		// 등록 버튼 클릭시
		$("#canvasInsertFrom").click(function() {
			if($('#selectType').val() == "1"){
				alert("돌아가냐");
				 var pageNo = $('#nowPageNo').val();
				 document.forms[0].submit();				
			}
		});
		
		
		//페이지 만들기
		makePage();
		//일정 게시판일경우 불러오기
		daysLoad();	
				
		function makePage(){
			<%
			for(int i = 0 ; i < daysList.size(); i++){
			%>
				$('#mybook').booklet("add", <%=2*i%>,"<div id='page<%=i+1%>'></div>");
    			$('#mybook').booklet("add", <%=2*i+1%>,"<div><div id='map<%=i+1%>' style='width:440px;height:560px;'></div>");
    		<%    			
			}
    		%>
		}
		
		function daysLoad() {			
			<%
				for(int i = 0 ; i < daysList.size();i++){
					if(canvasList.get(i).getCan_type().equalsIgnoreCase("1")){
			%>
				var container = document.getElementById("map"+<%=i+1%>);
	    		var options = {
	    			center: new daum.maps.LatLng(<%=daysList.get(i).get(0).getDays_x()%>, <%=daysList.get(i).get(0).getDays_y()%>),
	    			level: 5,
	    			disableDoubleClickZoom : true
	    		};
	    		
	    		var map = new daum.maps.Map(container, options);
	    		
	    		// 일정 마커들
	    		var daysMarker = [];
	    		// 일정 마커들의 인포윈도우
	    		var daysInfo = [];	
	    		
	    		// 일정 마커들 정보 가져오기
	    		<%
	    			for(int j = 0; j < daysList.get(i).size(); j++){
	    		%>
	    		
	    		daysMarker[<%=j%>] = new daum.maps.Marker({ 			    
	    			position: new daum.maps.LatLng(<%=daysList.get(i).get(j).getDays_x()%>,<%=daysList.get(i).get(j).getDays_y()%>),
	    			clickable: true				   
	    		});
	    		daysInfo[<%=j%>] = '<%=daysList.get(i).get(j).getDays_title()%>';
	    		
	    		var infowindow = new daum.maps.InfoWindow({
    		        content: '<div><%=daysList.get(i).get(j).getDays_title()%></div>', // 인포윈도우에 표시할 내용
    		        removable : true
	    		});
    		    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    		    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    		    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    		    daum.maps.event.addListener(daysMarker[<%=j%>], 'click', makeOverListener(map, daysMarker[<%=j%>], infowindow));
    		    //daum.maps.event.addListener(daysMarker[<%=j%>], 'mouseout', makeOutListener(infowindow));
	    		<%	
	    			}
	    		%>
	    		// 선그리기
	    		 var linePath = [];
	    			// 지도에 마커를 표시합니다
	    			for(var i = 0 ; i < daysMarker.length ; i++)
	    			{
	    				daysMarker[i].setMap(map);				
	    				var path =  new daum.maps.LatLng(daysMarker[i].getPosition().getLat(), daysMarker[i].getPosition().getLng());
	    				linePath.push(path);
	    			}
	    			
	    			if(daysMarker.length >= 2){		
	    				// 지도에 표시할 선을 생성합니다
	    				var polyline = new daum.maps.Polyline({
	    					    path: linePath, // 선을 구성하는 좌표배열 입니다
	    					    strokeWeight: 5, // 선의 두께 입니다
	    					    strokeColor: '#FF0000', // 선의 색깔입니다
	    					    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    					    strokeStyle: 'solid' // 선의 스타일입니다
	    				});
	    				// 지도에 선을 표시합니다 
	    				polyline.setMap(map);  
	    			}    
	    			
	    			// 일정 페이지 정보 가져오기
	    			var daysPage = document.getElementById("page"+<%=i+1%>);				
	    			
	    			for(var i = 0 ; i < daysMarker.length ; i++){
	    				var div = document.createElement('div');
	    				if(i >= 1){
	    					//시작 지점 과 끝지점 가져와서 최단거리 설정
	    					div.innerHTML += "↓";
	    					var startCoord = new daum.maps.LatLng(daysMarker[i-1].getPosition().getLat(), daysMarker[i-1].getPosition().getLng());
	    					var endCoord =  new daum.maps.LatLng(daysMarker[i].getPosition().getLat(), daysMarker[i].getPosition().getLng());
	    					div.innerHTML += "<a href='https://map.kakao.com/?sX="+startCoord.toCoords().getX()+"&sY="+startCoord.toCoords().getY()+"&sName=출발점&eX="+endCoord.toCoords().getX()+"&eY="+endCoord.toCoords().getY()+"&eName=도착점'"
	    							+ " onclick='window.open(this.href, \"_경로보기\", \"width=1000px,height=800px;\"); return false;'"
	    							+ ">최단경로보기</a><br>";
	    				}				
	    				div.innerHTML += "<span>"+(i+1)+"번째 일정:"+daysInfo[i]+"</span>";
	    				daysPage.appendChild(div);	
	    			}	
	    			
			<%
					}
				}
			%>
		}
		
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}
		
		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		} 
	});
	
/* 	// 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new daum.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });
    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}
*/
	</script> 

</body>
</html>
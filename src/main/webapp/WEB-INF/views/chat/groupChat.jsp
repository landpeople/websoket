<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>그룹채팅</title>

<style type="text/css">
@import url(//fonts.googleapis.com/earlyaccess/jejugothic.css);
/*    @font-face{
      font-family: "the120";
      src: url('font/The120.ttf');
   } */

   body{
      padding: 0px;
      font-family: 'Jeju Gothic', sans-serif;
   }

   table{
      border: 1px solid #B4B4B4;
      border-collapse: collapse;
   }
   
   .sender_img{
      border: 6px solid;
      background-color: #69B55B; 
      background-clip: padding-box;
      -webkit-border-image: url(images/sender_bubble.png) 25 25 round;
      -o-border-image: url(images/sender_bubble.png) 25 25 round;
      border-image: url(images/sender_bubble.png) 25 25 round; 
      padding-top: 3px;
      padding-bottom: 3px;
      padding-left: 3px;
      padding-right: 11px;
      float: right;
      font-size: 12px;
      text-align: justify;
   }
   
   .receiver_img{
      border: 6px solid;
      background-color: #E6F4B5; 
      background-clip: padding-box;
      -webkit-border-image: url(images/receiver_bubble.png) 25 25 round;
      -o-border-image: url(images/receiver_bubble.png) 25 25 round;
      border-image: url(images/receiver_bubble.png) 25 25 round; 
      padding-top: 3px;
      padding-bottom: 3px;
      padding-right: 3px;
      padding-left: 11px;
      float: left;
      font-size: 12px;
      text-align: justify;
   }
   
   .receive_msg{
      padding: 3px;
      width: 350px;
      height: 400px;
      overflow: auto;
      overflow-x: hidden;
      background: #F3F3F3;
   }
   
   .chat{
      width: 340px;
      height: 35px;
      padding: 5px;
      float:left; 
      margin-top:4px; 
      margin-left: 2px;
      resize: none;
      border: 0.5px solid #F3F3F3;
   }
   
   .chat:focus{
      outline: none;
   }
   
   .chat_btn{
      margin-top: 0px;
      margin-left: 5px;
      width: 52px;
      height: 31px;
      background-image: url('images/btn_send.png');
      background-size: 100% 100%;
      display: inline-block;
   }
   
   .memListBox{
      text-align: center; 
      vertical-align: text-top; 
      padding: 10px; 
      overflow: auto;
      /* background: #D8D8D8; */
   }
   
   .listTitle{
      height:50px; 
      vertical-align: top; 
      font-size: 12px; 
      font-weight: bold;
   }
   
   .mem_icon{
      padding: 0px;
      display : inline-block;
      float: left;
   }
   
   .memList{
      vertical-align: top;
   }
   
   .noticeTxt{
      clear:both;
      margin: 10px;
   }
   
   .noticeTxt font{
      padding-top: 5px;
      padding-bottom: 5px;
      padding-left: 20px;
      padding-right: 20px;
      background: white;
      border-radius: 3px;
   }
   
   .sendTxt{
      width:172px; 
      float:right; 
      margin:2px; 
      word-break:break-word;
   }
   
   .receiveTxt{
      width:172px; 
      float:left; 
      margin:2px; 
      word-break:break-word;
   }
   
</style>

   <% 
    String chr_id = (String)session.getAttribute("chr_id"); 
    String user = (String) session.getAttribute("user");
   %>

<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
      var ws = null ;
      var url = null ;
      var nick = null ; 
      
      $(document).ready(function() {
          nick = $("#nickName").val();
          alert(nick);
          $(".receive_msg").html('');
          $(".chat_div").show();
          $(".chat").focus();
          
          ws = new WebSocket("ws://192.168.4.31:8091/LandPeople/wsChat.do");
          
          ws.onopen = function() {
             alert("● groupChat.jsp ws.onopen");
             ws.send("#$nick_"+nick); // 소켓이 열렸을 때 사용자가 입장하면 입장 메시지를 화면에 띄워 줄 수있도록 이벤트를 발생하여 핸들러를 호출
          };
          
          ws.onmessage = function(event) {
            var msg = event.data;
            var id = "<%=chr_id%>";
            if(msg.startsWith("<font color=")){ // 입장,퇴장
               $(".receive_msg").append($("<div class = 'noticeTxt'>").append(msg+"<br/>"));
            viewList(id);
            }else if(msg.startsWith("[${user}]")){ //대화내용
//                msg = msg.substring(3);// [나] 라는거 자르는 거 였음
               $(".receive_msg").append($("<div class = 'sendTxt'>").append($("<span class ='sender_img'>").text(msg))).append("<br><br>");
            }else{
               $(".receive_msg").append($("<div class = 'receiveTxt'>").append($("<span class = 'receiver_img'>").text(msg))).append("<br><br>");
            }
            
            $(".receive_msg").scrollTop($(".receive_msg")[0].scrollHeight);
          }
          
          ws.onclose = function(event) {
             alert("● groupChat.jsp ws.close / 웹소켓 닫힘");  //
          }
      
         $(".chat_btn").bind("click",function() {
        	 var canWrite;
        	 var nullval;
        	 $.ajax({
                 type: "POST",
                 url: "./chkChatMember.do",
                 data: { chr_id: <%=chr_id%> },
                 dataType: "json",
                 async: false,
                 success: function(result){
                	 canWrite = result.result;
                  },
                  error : function() {
					alert("실패");
				}
               });
        	 
            if($(".chat").val() == '' ) {
               alert("● groupChat.jsp / 내용을 입력하세요. ");
               $('#txtarea').val(nullval);
               return;
            }else if(canWrite=='cantChat'){
            	alert("● 대화 상대가 없습니다. *채팅 불가*");
            	return;
            }else {
               ws.send(nick+" : "+$(".chat").val());
               $(".chat").val('');
               $(".chat").focus();
            }
         });
      });
      
      function roomClose(){ // close 버튼 선택시 발생하는 이벤트 처리
        alert("● groupChat.jsp roomClose() / 채팅을 종료합니다.");
           $.ajax({
              type: "GET",
              url: "./socketOut.do", // 소켓 닫기
              async: false
           }); 
      }
      
      function disconnect() {
         ws.close();
         ws = null ;
      } 
      
      function viewList(grId){
        $(".memList").children().remove();
        $.ajax({
          type: "POST",
          url: "./viewChatList.do",
          data: "user="+$("#nickName"),
          async: false,
          success: function(result){
             for(var k in result.list){
               if(result.list[k]==grId){
                  $(".memList").prepend("<img class = 'mem_icon' src = 'img/smile.png' alt = '접속자 아이콘'><p style = 'font-size : 13px;padding : 5px;border-bottom: 0.5px solid #B4B4B4;'>"+k+"</p>"); 
               }
             }
          }
        });
      }      
</script>
</head>
<body onbeforeunload="roomClose()">
   <table>
      <tr>
         <td width="360x" height="390px" align="center">
         <div class ="receive_msg" style="border:1px">
         <div class = "last"></div> 
         <input type="text" id="nickName" value = <%=user%> />
         </div>
         </td>
         <td width="130px" class = "memListBox">
            <div class = "listTitle">접속자 목록</div>
            <div class = "memList"></div> 
         </td>
      </tr>   
   </table>
   
   <div class="chat_div" style="display:none; margin-top: 10px;">
      <textarea id="txtarea" class="chat"
             onKeypress="if(event.keyCode==13) $('.chat_btn').click();" ></textarea>
      <div class="chat_btn"></div>          
   </div>
     그룹아이디 : <%=chr_id%>
나의아이디 :   <%=user %>
</body>
</html>
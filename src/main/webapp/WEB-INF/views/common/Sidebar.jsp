<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="./js/chat/chat.js"></script>

<link rel="stylesheet" href="./css/bootstrap.min.css">
<link rel="stylesheet" href="./css/lp-style.css">

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
         <li><a href="#">여행일정 작성</a></li>
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

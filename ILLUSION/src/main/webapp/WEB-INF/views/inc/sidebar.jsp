<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<aside class="sidebar">
    <div class="sidebar-profile-new">
        <div class="sidebar-logo">ILLUSION</div>
        <div class="profile-card">
            <div class="profile-image">
                <a href="#"></a> <img src="${pageContext.request.contextPath}/resources/image/logop.png" alt="프로필 이미지">
            </div>
            <div class="username">일루션님</div>
            <div class="profile-actions">
                <a href="myPage" class="profile-btn">마이페이지</a>
                <a href="#" class="profile-btn token-btn"> 
                <i class='far fa-gem' style= "color : var(--main-color)"></i> 10 토큰</a>
                <a href="#" class="profile-btn">로그아웃</a>
            </div>
        </div>
    </div>
	<nav class="sidebar-nav">
	    <ul>
	        <%-- '홈' 메뉴 --%>
	       <li><a href="./"><i class="fa-solid fa-house"></i> 홈</a></li>
	
	       <li class="has-submenu current-category">
	           <a href="#">
	               <i class="fa-solid fa-briefcase"></i> 
	               취업도구 
	               <span class="arrow"><i class="fa-solid fa-angle-down"></i></span>
	           </a>
	           <ul class="submenu">
	               <%-- 이제 하위 메뉴에는 특별한 클래스가 필요 없습니다. --%>
	               <li class="submenu"><a href="coverletterCreate">자기소개서 생성기</a></li>
	               <li class="submenu"><a href="coverletterRefiner">자기소개서 다듬기</a></li>
	               <li class="submenu"><a href="interviewCreate">AI 면접 예상 질문</a></li>
	               <li class="submenu"><a href="chatbot">취업 챗봇</a></li>
	           </ul>
	       </li>
	       
	       <%-- 다른 메뉴들 --%>
	        <li><a href="recuritmentInfo"><i class="fa-solid fa-file-lines"></i> 채용정보</a></li>
	        <li><a href="communityMain"><i class="fa-solid fa-comments"></i> 커뮤니티</a></li>
	    </ul>
	</nav>
</aside>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="sidebar">
    <div class="sidebar-profile-new">
        <div class="sidebar-logo">ILLUSION</div>
        <div class="profile-card">
            <div class="profile-image">
            	<sec:authorize access="isAuthenticated()">
			        <c:set var="profileUrl"><sec:authentication property="principal.profile_picture_url" /></c:set>
			        <c:choose>
			            <c:when test="${not empty profileUrl and profileUrl ne 'null'}">
			                <img src="${pageContext.request.contextPath}/resources/upload/${profileUrl}" alt="프로필 이미지">
			            </c:when>
			            <c:otherwise>
			                <img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png" alt="기본 이미지" id="profilePreview">
			            </c:otherwise>
			        </c:choose>
			    </sec:authorize>
			    <sec:authorize access="isAnonymous()">
			        <img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png" alt="기본 이미지" id="profilePreview">
			    </sec:authorize>
            </div>
            <div class="username">
                <sec:authorize access="isAuthenticated()">
                    <%-- 인증된 사용자의 Id 표시. principal 객체에서 username을 가져옴. --%>
                    <sec:authentication property="principal.username" />님
                </sec:authorize>
                <sec:authorize access="isAnonymous()">
                    illusion
                </sec:authorize>
            </div>
            <div class="profile-actions">
                <sec:authorize access="isAuthenticated()">
                    <a href="myPage" class="profile-btn">마이페이지</a>
                    <a href="${pageContext.request.contextPath}/tokenpay" class="profile-btn token-btn"> 
                        <i class='far fa-gem' style= "color : var(--main-color)"></i> 
                        <span id="sidebar-token-count"><sec:authentication property="principal.token" /></span> 토큰
                    </a>
                    <a href="#" class="profile-btn" onclick="document.getElementById('logoutForm').submit(); return false;">로그아웃</a>
                </sec:authorize>
                
                <sec:authorize access="isAnonymous()">
                    <a href="${pageContext.request.contextPath}/login" class="profile-btn">로그인</a>
                </sec:authorize>
            </div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <%-- '홈' 메뉴 --%>
           <li><a href="./"><i class="fa-solid fa-house"></i> 홈</a></li>
    
           <li class="has-submenu">
               <a href="#">
                   <i class="fa-solid fa-briefcase"></i> 
                   취업도구 
                   <span class="arrow"><i class="fa-solid fa-angle-down"></i></span>
               </a>
               <ul class="submenu">
                   <li class="submenu"><a href="coverletterCreate">자기소개서 생성기</a></li>
                   <li class="submenu"><a href="coverletterRefiner">자기소개서 다듬기</a></li>
                   <li class="submenu"><a href="interviewCreate">AI 면접 예상 질문</a></li>
                   <li class="submenu"><a href="chatbot">취업 챗봇</a></li>
               </ul>
           </li>
           
           <%-- 다른 메뉴들 --%>
            <li><a href="recruitmentInfo"><i class="fa-solid fa-file-lines"></i> 채용정보</a></li>
            <li><a href="communityMain"><i class="fa-solid fa-comments"></i> 커뮤니티</a></li>
        </ul>
    </nav>
</aside>


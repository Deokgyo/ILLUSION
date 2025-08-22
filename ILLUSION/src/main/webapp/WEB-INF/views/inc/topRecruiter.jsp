<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
	작성자: 박덕교
	용도 : 기업 페이지 헤더 영역 
	작성일 : 25-07-28 
 --%>
	<meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
<header class="site-header">
    <div class="header-container">
    
        <!-- 로고 -->
        <div class="site-logo">
            <a href="./">
                <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="ILLUSION 로고" />
            </a>
        </div>
        
        <!-- 중앙 내비게이션 -->
        <nav class="main-nav">
            <ul>
	            <sec:authorize access="isAnonymous() or hasRole('MEM002')">
	            	<li><a href="recruiterMain">홈</a></li>
	            </sec:authorize>
	            <sec:authorize access="hasRole('MEM001') or hasRole('MEM003')">
	            	<li><a href="recruiterMainLogin">홈</a></li>
	            </sec:authorize>
                <li><a href="recruiterRegistForm">공고등록</a></li>
                <li><a href="recruiterList">공고목록</a></li>
            </ul>
        </nav>

 	 <nav class="user-menu">
            <ul>
                <sec:authorize access="isAnonymous()">
                    <li><a href="${pageContext.request.contextPath}/login">기업로그인</a></li>
                    <li class="separator">|</li>
                    <li><a href="${pageContext.request.contextPath}/register">회원가입</a></li>
                </sec:authorize>

                <sec:authorize access="hasRole('MEM001') or hasRole('MEM003')">
                    <li>
                        <a href="${pageContext.request.contextPath}/recruiterInfo">
                            <sec:authentication property="principal.username" />님
                        </a>
                    </li>
                    <li class="separator">|</li>
                    <li>
                        <%-- 로그아웃은 POST 방식 form으로 처리 (CSRF 보안) --%>
                        <form id="logoutRecruiterForm" action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <a href="#" onclick="document.getElementById('logoutRecruiterForm').submit(); return false;">로그아웃</a>
                        </form>
                    </li>
	                <li class="separator">|</li> 
	                <li><a href="recruiterInfo">정보 수정</a></li> 
                </sec:authorize>
            </ul>
        </nav>
    </div>
</header>
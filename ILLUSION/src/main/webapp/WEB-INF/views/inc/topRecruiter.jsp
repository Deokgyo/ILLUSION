<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

<%--
	작성자: 박덕교
	용도 : 기업 페이지 헤더 영역 
	작성일 : 25-07-28 
 --%>

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
                <li><a href="recruiterMain">홈</a></li>
                <li><a href="recruiterRegistForm">공고등록</a></li>
                <li><a href="recruiterList">공고목록</a></li>
            </ul>
        </nav>
        
        <!-- 우측 사용자 메뉴 -->
        <nav class="user-menu">
        	<ul>
	            <li><a href="#">기업로그인</a></li>
	            <li class="separator">|</li>
	            <li><a href="#" class="btn-primary">회원가입</a></li>
            </ul>
        </nav>
    </div>
</header>
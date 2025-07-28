<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
	작성자: 박덕교
	용도 : 기업 페이지 헤더 영역 
	작성일 : 25-07-28 
 --%>

<header class="site-header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="site-logo">
            <h1><a href="./">ILLUSION</a></h1>
        </div>

        <!-- 중앙 메뉴: 메인 네비게이션 + 검색창 -->
        <div class="center-menu">
            <!-- 메인 네비게이션 -->
            <nav class="main-nav">
                <ul>
                    <li><a href="recruiterMain">홈</a></li>
                    <li><a href="recruiterRegistForm">공고등록</a></li>
                    <li><a href="recruiterList">공고목록</a></li>
                </ul>
            </nav>
            
            <!-- 검색창 -->
            <form action="/search" method="get" class="search-form">
                <input type="text" name="query" class="search-input" placeholder="검색">
                <button type="submit" class="search-button">
                    <i class="bi bi-search"></i>
                </button>
            </form>
        </div>

        <!-- 우측 사용자 메뉴 -->
        <nav class="user-menu">
            <ul>
                <li><a href="/login">기업 로그인</a></li>
                <li class="separator">|</li>
                <li><a href="/register">회원가입</a></li>
            </ul>
        </nav>
    </div>
</header>
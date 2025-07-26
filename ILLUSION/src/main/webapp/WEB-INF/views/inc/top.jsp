<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Illusion - Header</title>
<style>
    /* 웹 폰트 및 기본 스타일 초기화 */
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap');

    body, h1, h2, ul, li, form, input, button, p {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Noto Sans KR', sans-serif;
        color: #333;
        line-height: 1.6;
        background-color: #f8f8f8;
    }

    a {
        text-decoration: none;
        color: inherit;
    }

    li {
        list-style: none;
    }

    /* 헤더 전체 컨테이너 */
    .site-header {
        width: 100%;
        background-color: #fff;
        border-bottom: 1px solid #EAEAEA;
        padding: 18px 0;
        box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    }

    /* 헤더 내부 컨텐츠 */
    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        max-width: 1280px;
        margin: 0 auto;
        padding: 0 25px;
    }

    /* 로고 스타일 */
    .site-logo h1 {
        font-size: 28px;
        font-weight: 700;
        color: #1A1A1A;
        letter-spacing: -0.5px;
    }
    
    .site-logo a {
        display: block;
        padding: 5px 0;
    }

    /* 중앙 메뉴 */
    .center-menu {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    /* 메인 네비게이션 */
    .main-nav ul {
        display: flex;
        gap: 30px;
        align-items: center; 
    }

    .main-nav a {
        font-size: 16px;
        font-weight: 500;
        color: #4A4A4A;
        padding: 8px 0;
        position: relative;
        transition: color 0.3s ease;
    }

    .main-nav a:hover {
        color: #007BFF;
    }
    
    .main-nav > ul > li:not(.dropdown) > a::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 0;
        height: 2px;
        background-color: #007BFF;
        transition: width 0.3s ease;
    }

    .main-nav > ul > li:not(.dropdown) > a:hover::after {
        width: 100%;
    }
    
    /* 검색창 */
    .search-form {
        display: flex;
        align-items: center;
        background-color: #F8F8F8;
        border-radius: 22px;
        padding: 10px 18px;
        border: 1px solid #E0E0E0;
        transition: all 0.3s ease;
    }

    .search-form:focus-within {
        border-color: #007BFF;
        box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1);
    }

    .search-input {
        border: none;
        background: transparent;
        outline: none;
        font-size: 15px;
        width: 180px;
        color: #333;
        padding-right: 10px;
    }
    .search-input::placeholder {
        color: #999;
    }

    .search-button {
        border: none;
        background: transparent;
        cursor: pointer;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .search-button img {
        width: 20px;
        height: 20px;
        opacity: 0.7;
        transition: opacity 0.3s ease;
    }
    .search-button:hover img {
        opacity: 1;
    }

    /* 우측 사용자 메뉴 */
    .user-menu ul {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .user-menu a {
        font-size: 14px;
        color: #666;
        padding: 5px 8px;
        border-radius: 5px;
        transition: all 0.3s ease;
    }
    
    .user-menu a:hover {
        color: #000;
        background-color: #F0F0F0;
    }
    
    .user-menu .separator {
        font-size: 12px;
        color: #DCDCDC;
    }
    
    .dropdown {
        position: relative;
    }
    
    .dropdown > a {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .dropdown > a::after {
        content: '▼';
        font-size: 10px;
        color: #999;
        transform-origin: center;
        transition: transform 0.3s ease, color 0.3s ease;
    }

    .dropdown:hover > a::after {
        transform: rotate(180deg);
        color: #007BFF;
    }
    
    .dropdown-menu {
        display: flex;
        flex-direction: column;
        gap: 4px;
        position: absolute;
        top: 100%;
        left: 50%;
        background-color: #fff;
        border-radius: 12px;
        border: 1px solid #F0F0F0;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        padding: 8px;
        min-width: 220px;
        z-index: 1000;
        opacity: 0;
        visibility: hidden;
        transform: translate(-50%, 10px);
        transition: opacity 0.3s ease, visibility 0.3s ease, transform 0.3s ease;
    }

    .dropdown:hover .dropdown-menu {
        opacity: 1;
        visibility: visible;
        transform: translate(-50%, 0);
    }

    .dropdown-menu li a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 500;
        color: #333;
        transition: background-color 0.2s ease, color 0.2s ease;
        white-space: nowrap;
    }

    .dropdown-menu li a:hover {
        background-color: #F8F9FA;
        color: #007BFF;
    }

    .dropdown-menu .icon {
        font-size: 18px;
        width: 20px;
        text-align: center;
        color: #888;
        transition: color 0.2s ease;
    }

    .dropdown-menu li a:hover .icon {
        color: #007BFF;
    }
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body>

<header class="site-header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="site-logo">
        	<!-- 이 부분에 만든 로고 이미지ㄹ 대체 -->
            <h1><a href="/">ILLUSION</a></h1>
        </div>

        <!-- 중앙 메뉴: 메인 네비게이션 + 검색창 -->
        <div class="center-menu">
            <!-- 메인 네비게이션 -->
            <nav class="main-nav">
                <ul>
                    <!-- ▼▼▼ HTML 구조에 icon 클래스를 가진 span 태그 추가 ▼▼▼ -->
                    <li class="dropdown">
                        <a href="#">취업도구</a>
                        <ul class="dropdown-menu">
                            <li><a href="/tool/resume-generator"><span class="icon">📄</span> 자소서 생성기</a></li>
                            <li><a href="/tool/resume-refiner"><span class="icon">✨</span> 자소서 다듬기</a></li>
                            <li><a href="/tool/interview-qa"><span class="icon">🎙️</span> 면접예상 질문 생성기</a></li>
                            <li><a href="/tool/chatbot"><span class="icon">💬</span> 취업 상담 챗봇</a></li>
                        </ul>
                    </li>
                    <!-- ▲▲▲ HTML 구조에 icon 클래스를 가진 span 태그 추가 ▲▲▲ -->
                    <li><a href="/job-info">채용정보</a></li>
                    <li><a href="/community">커뮤니티</a></li>
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
                <li><a href="/login">로그인</a></li>
                <li class="separator">|</li>
                <li><a href="/register">회원가입</a></li>
                <li class="separator">|</li>
                <li><a href="/corporate">기업서비스</a></li>
            </ul>
        </nav>
    </div>
</header>
</body>
</html>
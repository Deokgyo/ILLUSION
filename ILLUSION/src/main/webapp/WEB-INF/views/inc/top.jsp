<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="site-header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="site-logo">
            <a href="./">
            	    <img src="${pageContext.request.contextPath}/resources/image/test.png" alt="이미지 설명" />
            </a>
        </div>

        <!-- 중앙 메뉴: 메인 네비게이션 + 검색창 -->
        <div class="center-menu">
            <!-- 메인 네비게이션 -->
            <nav class="main-nav">
                <ul>
                    <li class="dropdown">
                        <a href="#">취업도구</a>
                        <ul class="dropdown-menu">
                            <li><a href="coverletterCreate"><span class="icon">📄</span> 자소서 생성기</a></li>
                            <li><a href="coverLetterRefiner"><span class="icon">✨</span> 자소서 다듬기</a></li>
                            <li><a href="interviewCreate"><span class="icon">🎙️</span> 면접예상 질문 생성기</a></li>
                            <li><a href="chatbot"><span class="icon">💬</span> 취업 상담 챗봇</a></li>
                        </ul>
                    </li>
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
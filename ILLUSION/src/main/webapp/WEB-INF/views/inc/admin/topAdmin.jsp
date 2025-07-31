<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header class="site-header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="site-logo">
            <a href="./">
            	    <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="이미지 설명" />
            </a>
        </div>

        <!-- 우측 사용자 메뉴 -->
        <nav class="user-menu">
            <ul>
                <li><a href="/login">로그아웃</a></li>
                <li class="separator">|</li>
                <li><a href="/register">사용자화면</a></li>
            </ul>
        </nav>
    </div>
</header>
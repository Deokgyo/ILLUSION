<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
	작성자: 박덕교
	용도 : 기업 페이지 헤더 영역 
	작성일 : 25-07-28 
 --%>

<header class="header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="logo">
            <a href="./">
                <img src="${pageContext.request.contextPath}/resources/image/test.png" alt="ILLUSION 로고" />
            </a>
        </div>
        <!-- 중앙 내비게이션 -->
        <nav class="navigation">
            <ul>
                <li><a href="recruiterMain">홈</a></li>
                <li><a href="recruiterList">공고등록</a></li>
                <li><a href="recruiterRegistForm">공고목록</a></li>
            </ul>
        </nav>
        <!-- 우측 사용자 메뉴 -->
        <div class="user-menu">
            <a href="#">기업로그인</a>
            <a href="#">회원가입</a>
        </div>
    </div>
</header>
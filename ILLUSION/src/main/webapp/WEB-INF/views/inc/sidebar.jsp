<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<aside class="sidebar">
    <div class="sidebar-profile-new">
        <div class="sidebar-logo">ILLUSION</div>
        <div class="profile-card">
            <div class="profile-image">
                <a href="#"></a> <img src="${pageContext.request.contextPath}/resources/image/logop.png" alt="프로필 이미지">
                </a>
            </div>
            <div class="username">일루션님</div>
            <div class="profile-actions">
                <a href="myPage" class="profile-btn">마이페이지</a>
                <a href="#" class="profile-btn token-btn"> 
                <img src="${pageContext.request.contextPath}/resources/image/token.jpg" alt="토큰 이미지"> 10 토큰</a>
                <a href="#" class="profile-btn">로그아웃</a>
            </div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <ul>
            <li><a href="./" class="text-box"><i class="fa-solid fa-house"></i> 홈</a></li>
            <li class="has-submenu">
                <a href="#" class="text-box"><i class="fa-solid fa-briefcase"></i> 취업도구 <span class="arrow"><i class="fa-solid fa-angle-down"></i></span></a>
                <ul class="submenu">
                    <li><a href="coverletterCreate">자기소개서 생성기</a></li>
                    <li><a href="coverletterRefiner">자기소개서 다듬기</a></li>
                    <li><a href="interviewCreate">AI 면접 예상 질문</a></li>
                    <li><a href="chatbot">취업 챗봇</a></li>
                </ul>
            </li>
            <li><a href="#" class="text-box"><i class="fa-solid fa-comment"></i> 커뮤니티</a></li>
            <li><a href="recuritmentInfo" class="text-box"><i class="fa-solid fa-file-alt"></i> 채용정보</a></li>
        </ul>
    </nav>
</aside>
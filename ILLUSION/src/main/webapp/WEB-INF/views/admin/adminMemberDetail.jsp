<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 회원 관리</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    	 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMember.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMemberDetail.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/dashboard.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
</head>
<body>
	<div class="main-container">
	    <div class="admin-wrapper">
	        <!-- =======================
	             왼쪽 사이드바 (Aside)
	            ======================== -->
	        <aside class="admin-sidebar">
	            <div class="sidebar-header">
	                <a href="./adminMain" class="logo">
	                    <!-- 로고 이미지를 나중에 추가하세요 -->
	                    <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="이미지 설명" />
	                </a>
	            </div>
	            
	            <nav class="sidebar-nav">
	                <ul>
	                    <li><a href="./adminMember" class="nav-item">회원 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminRecuritment" class="nav-item">공고 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminCommunity" class="nav-item">게시글 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminSupport" class="nav-item">고객 문의<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminPayment" class="nav-item">결제 이력<!-- <span>▼</span> --></a></li>
	                    <li><a href="./comcodeRegist" class="nav-item">공통 코드 관리<!-- <span>▼</span> --></a></li>
	                </ul>
	            </nav>
	        </aside>
	
	        <!-- =======================
	             메인 영역 (오른쪽)
	            ======================== -->
	        <div class="main-content-area">
	            <!-- 메인 헤더 -->
	            <header class="admin-header">
	                <div class="user-actions">
	                    <a href="./">로그아웃</a>
	                    <a href="./">사용자 화면</a>
	                </div>
	            </header>
	
	            <!-- 메인 콘텐츠가 표시될 영역 -->
	            <main class="admin-content">
	            
	            <!-- 1. 페이지 헤더 -->
		         <div class="page-title-header">
	         	    <p class="header-text"><strong>구직자/기업 회원목록</strong></p>
	             </div>
        
			        <div class="detail-layout">
			            <!-- =======================
			                 왼쪽 정보 컬럼
			                ======================== -->
			            <div class="form-column left">
			                <div class="form-group">
			                    <label>아이디</label>
			                    <div class="form-value">honeyCombo</div>
			                </div>
			                <div class="form-group">
			                    <label>이름</label>
			                    <div class="form-value">김교촌</div>
			                </div>
			                <div class="form-group">
			                    <label>이메일</label>
			                    <div class="form-value"><a href="mailto:kyochon@chicken.com">kyochon@chicken.com</a></div>
			                </div>
			                <div class="form-group">
			                    <label>주소</label>
			                    <div class="form-value">부산 부산진구 동천로 109 삼한골든게이트 7층</div>
			                </div>
			                <div class="form-group">
			                    <label>성별</label>
			                    <div class="form-value">남</div>
			                </div>
			                 <div class="form-group">
			                    <label>회원 유형</label>
			                    <div class="form-value">개인회원</div>
			                </div>
			                 <div class="form-group">
			                    <label>가입일자</label>
			                    <div class="form-value">2025-01-10</div>
			                </div>
			            </div>
			
			            <!-- =======================
			                 오른쪽 정보 컬럼
			                ======================== -->
			            <div class="form-column right">
			                	<img src="${pageContext.request.contextPath}/resources/image/kyochon.jpg" class="image-placeholder">
			                 <div class="form-group">
			                    <label>기업이름</label>
			                    <div class="form-value">교촌치킨</div>
			                </div>
			                 <div class="form-group">
			                    <label>회원 상태</label>
			                    <div class="form-value">정상</div>
			                </div>
			                <div class="form-group">
			                    <label>탈퇴일자</label>
			                    <div class="form-value">미탈퇴</div>
			                </div>
			            </div>
			        </div>
		      
	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>
</body>
</html>
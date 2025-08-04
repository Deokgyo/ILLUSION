<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용공고 페이지</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    	 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css">
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
	                    <a href="#">로그아웃</a>
	                    <a href="#">사용자 화면</a>
	                </div>
	            </header>
	
	            <!-- 메인 콘텐츠가 표시될 영역 -->
	            <main class="admin-content">
		            <main class="dashboard-content">
		
		        <!-- =======================
		             상단 요약 카드 그리드
		            ======================== -->
		        <section class="stats-grid">
		            <!-- 6개의 카드를 동일한 구조로 배치합니다. -->
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">구직자 회원수</span>
		                    <p class="stat-value">800명</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-person fs-1"></i>
		                </div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">구인자 회원수</span>
		                    <p class="stat-value">100명</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-briefcase fs-1"></i>
		                </div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">등록된 공고수</span>
		                    <p class="stat-value">500개</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-clipboard-check fs-1"></i>
		                </div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">매출액</span>
		                    <p class="stat-value">5000 만원</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-coin fs-1"></i>
		                </div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">AI 첨삭 건수</span>
		                    <p class="stat-value">340건</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-filetype-ai fs-1"></i>
		                </div>
		            </div>
		            <div class="stat-card">
		                <div class="stat-info">
		                    <span class="stat-title">문의 접수</span>
		                    <p class="stat-value">10건</p>
		                </div>
		                <div class="stat-icon">
		                    <i class="bi bi-person-exclamation fs-1"></i>
		                </div>
		            </div>
		        </section>
		
		        <!-- =======================
		             하단 차트 그리드
		            ======================== -->
		        <section class="charts-grid">
		            <div class="chart-card">
		                <h4 class="chart-title">매출액 추이</h4>
		                <div class="chart-container">
		                    <canvas id="salesChart"></canvas>
		                </div>
		            </div>
		            <div class="chart-card">
		                <h4 class="chart-title">AI 이용 건수 추이</h4>
		                 <div class="chart-container">
		                    <canvas id="aiUsageChart"></canvas>
		                </div>
		            </div>
		        </section>
		
		    		</main>
	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>
	
	<!-- 📊 차트를 그리는 스크립트 파일 -->
    <script src="${pageContext.request.contextPath}/resources/js/admin/dashboard-charts.js"></script>    
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용공고 상세페이지</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/applyModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/recuritmentDetail.css"> 
    
</head>
<body>
     <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        
	        <div class="container">
	         <div class="page-title-header">
         	    <p class="header-text"><strong>채용공고 상세페이지</strong></p>
             </div>
	
	        <main class="job-posting">
	            <section class="job-title-section">
	                <div class="title-wrapper">
	                    <span class="company-name-top">(주) 일루션</span>
	                    <h2>신입 개발자 채용</h2>
	                </div>
	                <div class="action-buttons">
	                    <button class="bookmark-btn"><i class="fa-regular fa-bookmark"></i></button>
	                    <a href="#" class="btn btn-yellow" id="job-apply-btn">입사지원<i class="fa-solid fa-paper-plane"></i></a>
	                    
	                </div>
	            </section>
	
	            <section class="job-details-grid">
	                <dl><dt>경력</dt><dd>신입, 경력</dd></dl>
	                <dl><dt>직급</dt><dd>면접 후 결정</dd></dl>
	                <dl><dt>우대사항</dt><dd>정보처리기사</dd></dl>
	                <dl><dt>학력</dt><dd>학력무관</dd></dl>
	                <dl><dt>근무 지역</dt><dd>부산시 부산진구</dd></dl>
	                <dl><dt>근무 시간</dt><dd>08:00 ~ 18:00</dd></dl>
	                <dl><dt>근무 형태</dt><dd>정규직</dd></dl>
	                <dl><dt>근무 요일</dt><dd>월 ~ 금</dd></dl>
	            </section>
	
	            <section class="job-description">
	                <p>기업에서 제공하는 채용에 대한 설명</p>
	            </section>
	
	            <section class="info-section">
	                <h3 class="section-title">기업정보</h3>
	                <div class="company-info-content">
	                    <div class="company-details">
	                        <h4>ILLUSION</h4>
	                        <p>대표자명: 박덕교/조영재</p>
	                        <p>기업 형태: 중소기업</p>
	                        <p>설립일: 2025년 7월 8일</p>
	                        <p>기업 주소: 부산시 부산진구 삼한골드게이트 7층</p><br>
	                        <p>(추후 카카오맵 API 추가)</p>   
	                    </div>
	                    <div class="company-logo">
	                        <img src="https://i.ibb.co/L5kQV9j/illusion-logo.png" alt="Illusion Logo">
	                    </div>
	                </div>
	            </section>
	
	            <section class="info-section">
	                <h3 class="section-title">접수 기간 및 방법</h3>
	                <div class="application-info-content">
	                    <div class="countdown-timer">
	                        <p>남은 시간</p>
	                        <div class="timer">7일 03:23:18</div>
	                    </div>
	                    <div class="application-details">
	                        <div><span>접수일</span> 2025.07.18 09:00</div>
	                        <div><span>접수 마감</span> 2025.07.30 23:59</div>
	                        <div><span>접수 방법</span> 홈페이지 지원</div>
	                        <div><span>접수 양식</span> 이력서, 자기소개서</div>
	                    </div>
	                </div>
	            </section>
	
	            <section class="info-section">
	                <h3 class="section-title">지원자 통계</h3>
	                <div class="stats-container">
	                    <div class="stat-card">
	                        <p>지원자 수</p>
	                        <span class="applicant-count">29명</span>
	                    </div>
	                    <div class="stat-card">
	                        <p>성별 현황</p>
							<canvas id="pieChart" width="140" height="140"></canvas>
							<div class="gender-count">
								<p>여성 : 19명</p>
								<p>남성 : 12명</p>
							</div>
	                    </div>
	                    <div class="stat-card">
	                        <p>연봉별 현황</p>
						<canvas id="barChart" width="230" height="230"></canvas>
	                    </div>
	                </div>
	            </section>
	        </main>
	    </div>
    </div>
    

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
    
    <jsp:include page="/WEB-INF/views/recuritment/applyModal.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recuritment/chartEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recuritment/modalEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script>
		   	document.addEventListener('DOMContentLoaded', function(){
			  	pieChart('pieChart');
			    barChart('barChart');
	  		});
    </script>
</body>
</html>
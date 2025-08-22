<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruitment/applyModal.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruitment/recruitmentDetail.css"> 
    
</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	    <div class="container">
	        <div class="page-title-header">
         	    <p class="header-text"><strong>채용공고 상세페이지</strong></p>
            </div>
			
	        <main class="job-posting mt-4">
	            <section class="job-title-section">
	                <div class="title-wrapper">
	                    <span class="company-name-top">${recruit.company_name }</span>
	                    <h2>${recruit.recruit_subject }</h2>
	                </div>
	                <div class="action-buttons">
	                    <button class="bookmark-btn"><i class="fa-regular fa-bookmark"></i></button>
	                    <a href="#" class="btn btn-yellow" id="job-apply-btn">입사지원<i class="fa-solid fa-paper-plane"></i></a>
	                    <c:if test="${isAuthor}">
	                    	<a href="recruitModify?recruit_idx=${param.recruit_idx}" class="btn btn-yellow" id="job-apply-btn">수정하기<i class="fa-solid fa-paper-plane"></i></a>
	                    </c:if>
	                </div>
	            </section>
	
	            <section class="job-details-grid">
	                <dl><dt>경력</dt><dd>${recruit.experience }</dd></dl>
	                <dl><dt>직급</dt><dd>${recruit.position}</dd></dl>
	                <dl><dt>우대사항</dt><dd>${recruit.preferred}</dd></dl>
	                <dl><dt>학력</dt><dd>${recruit.degree }</dd></dl>
	                <dl><dt>근무 지역</dt>
	                <dd>${recruit.location } ${recruit.city_district }</dd></dl>
	                <dl><dt>근무 일시</dt><dd>${recruit.work_start_day } ~ ${recruit.work_end_day } <br> ${recruit.start_time } ~ ${recruit.end_time }</dd></dl>
	                <dl><dt>근무 형태</dt><dd>${recruit.recruit_type }</dd></dl>
	                <dl><dt>급여</dt><dd>${recruit.salary }</dd></dl>
	                <dl><dt>채용 인원</dt><dd>${recruit.recruit_hiring_num }명</dd></dl>
	            </section>
	
	            <section class="job-description">
	                <p>${recruit.recruit_context }</p> 
	            </section>
	
	            <section class="info-section">
	                <h3 class="section-title">기업정보</h3>
	                <div class="company-info-content">
	                    <div class="company-details">
	                        <h4>기업명 : ${recruit.company_name }</h4>
	                        <p>대표자명 : ${recruit.ceo_name }</p>
	                        <p>기업 형태 : ${recruit.company_type }</p>
	                        <p>설립일 : ${recruit.company_estab_date }</p>
	                        <p>기업 주소 : ${recruit.full_address }</p>
	                        <p>회사 이메일 : ${recruit.recruiter_member_email }</p><br>
	                    </div>
	                    <div class="company-logo">
	                        <img src="https://i.ibb.co/L5kQV9j/illusion-logo.png" alt="Illusion Logo">
	                    </div>
	                </div>
	            </section>
	            
	            <h3 class="section-title">근무지 위치</h3>
				<div id="map" style="width: 500px; height: 400px;"
				data-address="${recruit.full_address}" data-name="${recruit.company_name }">
				</div>

	            <section class="info-section">
	            	<h3 class="section-title">접수 기간 및 방법</h3>
	                <div class="application-info-content">
	                    <div class="countdown-timer">
	                        <p>남은 시간</p>
	                        <div id="countdown-timer" data-deadline="${recruit.endDateForTimer}"
	                        class="countdown-timer">
						        <span id="days" class="timer">00</span>일
						        <span id="hours" class="timer">00</span>시
						        <span id="minutes" class="timer">00</span>분
						        <span id="seconds" class="timer">00</span>초
						    </div>
	                    </div>
		                <div class="application-details">
		                    <div><span>접수일</span> ${recruit.startDateFormatted}</div>
		                    <div><span>접수 마감</span> ${recruit.endDateFormatted}</div>
		                    <div><span>접수 방법</span> ${recruit.apply_method }</div>
		                    <div><span>접수 양식</span> ${recruit.apply_doc }</div>
		                </div>
	            	</div>
	            </section>
	
	            <section class="info-section">
	                <h3 class="section-title">지원자 통계</h3>
	                <div class="stats-container">
	                    <div class="stat-card">
	                        <p>지원자 수</p>
	                        <span class="applicant-count">${recruit.app_count }명</span>
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
    
    <jsp:include page="/WEB-INF/views/recruitment/applyModal.jsp" />
    
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1b38e19508712285c3e7d184a62d45ba&libraries=services,clusterer"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruitment/kakaoApi.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruitment/chartEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruitment/modalEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruitment/countdownTimer.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    
    <script>
	   	document.addEventListener('DOMContentLoaded', function(){
		  	pieChart('pieChart');
		    barChart('barChart');
  		});
    </script>
    
</body>
</html>
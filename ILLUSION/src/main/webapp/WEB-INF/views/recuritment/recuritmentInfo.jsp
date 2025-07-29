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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/recuritmentInfo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/filterEvent.css">
    
</head>
<body>
     <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	        <div class="container">
	        <header class="search-header">
	            <h1 class="h1">채용정보</h1>
	            <div class="filter-bar-main">
	                <div class="search-box">
	                    <input type="text" placeholder="검색어를 입력하세요">
	                    <button class="search-btn"><i class="fas fa-search"></i></button>
	                </div>
	                <button class="reset-btn">초기화</button>
	            </div>
				<jsp:include page="/WEB-INF/views/recuritment/salaryFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recuritment/salaryFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recuritment/experienceFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recuritment/salaryFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recuritment/degreeFilter.jsp" />
	        </header>
	        
	        <main>
	            <section class="job-list-controls">
	                <div class="sort-options">
	                    <a href="#" class="active">최신순</a>
	                    <a href="#">마감순</a>
	                    <a href="#">조회순</a>
	                </div>
	            </section>
	
	            <section class="job-listings">
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name samsung">SAMSUNG</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>~9/30</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a> <!-- 추후 recruit_idx 가져와서 파라미터 값 전달 -->
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/samsung.jpg" alt="Samsung Building">
	                    </div>
	                </article>
	
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name hyundai">HYUNDAI</h2>
	                        <p class="job-title">경력, 신입 엔지니어 채용</p>
	                        <div class="card-meta">
	                            <span>~9/10</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/hyundai.jpg" alt="Hyundai Building">
	                    </div>
	                </article>
	
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name naver">NAVER</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>상시채용</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/naver.jpg" alt="naver font">
	                    </div>
	                </article>
	
	                 <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name samsung">SAMSUNG</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>~9/30</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/samsung.jpg" alt="Samsung Building">
	                    </div>
	                </article>
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name hyundai">HYUNDAI</h2>
	                        <p class="job-title">경력, 신입 엔지니어 채용</p>
	                        <div class="card-meta">
	                            <span>~9/10</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                         <img src="${pageContext.request.contextPath}/resources/images/hyundai.jpg" alt="Hyundai Building">
	                    </div>
	                </article>
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name naver">NAVER</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>상시채용</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/naver.jpg" alt="naver font">
	                    </div>
	                </article>
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name samsung">SAMSUNG</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>~9/30</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/samsung.jpg" alt="Samsung Building">
	                    </div>
	                </article>
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name hyundai">HYUNDAI</h2>
	                        <p class="job-title">경력, 신입 엔지니어 채용</p>
	                        <div class="card-meta">
	                            <span>~9/10</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                         <img src="${pageContext.request.contextPath}/resources/images/hyundai.jpg" alt="Hyundai Building">
	                    </div>
	                </article>
	                <article class="job-card">
	                    <div class="card-header">
	                        <h2 class="company-name naver">NAVER</h2>
	                        <p class="job-title">경력, 신입 개발자 채용</p>
	                        <div class="card-meta">
	                            <span>상시채용</span>
	                            <a href="recuritmentDetail" class="apply-btn">입사지원</a>
	                        </div>
	                    </div>
	                    <div class="card-image">
	                        <img src="${pageContext.request.contextPath}/resources/images/naver.jpg" alt="naver font">
	                    </div>
	                </article>
	            </section>
	        </main>
	
	        <nav class="pagination">
	            <a href="#" class="page-arrow">&laquo;</a>
	            <a href="#" class="active">1</a>
	            <a href="#">2</a>
	            <a href="#">3</a>
	            <a href="#">4</a>
	            <a href="#">5</a>
	            <a href="#" class="page-arrow">&raquo;</a>
	        </nav>
	    </div>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recuritment/filterEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
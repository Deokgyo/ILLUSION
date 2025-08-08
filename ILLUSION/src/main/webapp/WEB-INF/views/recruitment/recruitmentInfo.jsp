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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruitment/recruitmentInfo.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruitment/filterEvent.css">
    
</head>
<body>
     <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	        <div class="container">
	         <div class="page-title-header">
         	    <p class="header-text"><strong>채용정보</strong></p>
             </div>
	        <header class="search-header">
	            
	            <div class="filter-bar-main">
	                <div class="search-box">
	                    <input type="text" placeholder="검색어를 입력하세요">
	                    <button class="search-btn"><i class="fas fa-search"></i></button>
	                </div>
	            </div>
	            <div class="filter-button-wrapper">
				<jsp:include page="/WEB-INF/views/recruitment/locationFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recruitment/occupationFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recruitment/experienceFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recruitment/salaryFilter.jsp" />
				<jsp:include page="/WEB-INF/views/recruitment/degreeFilter.jsp" />
				<button class="reset-btn">초기화</button>
				</div>
				<div class="selected-filters-container">
				    <span class="filter-label">필터:</span>
				    <div class="tags-wrapper" id="selected-tags-area">
				    </div>
				    <button class="reset-btn">필터검색</button>
				</div>
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
	            	<c:forEach var="r" items="${recruitList }">
		                <article class="job-card">
		                    <div class="card-header">
								<div class="logo-image">
									<img src="${pageContext.request.contextPath}/resources/image/logo-samsung.jpg" alt="Samsung Logo">
								</div>
		                        <p class="job-title">${r.recruit_subject }</p>
		                        <p class="views-count">조회수 : ${r.views_count }</p>
		                        <p class="sub-title">지역 : ${r.location }</p><span class="sub-title">직종 : ${r.occupation }</span>
		                        <div class="sub-font">
		                        	<p>시작일 : ${r.start_date }</p> <%-- 공고 시작일 마감일 --%>
		                        	<p>마감일 : ${r.end_date }</p> <%-- 공고 시작일 마감일 --%>
		                        </div>
		                        <div class="card-meta">
		                            <a href="recruitmentDetail?recruit_idx=${r.recruit_idx }" class="btn-yellow">입사지원</a> <!-- 추후 recruit_idx 가져와서 파라미터 값 전달 -->
		                        </div>
		                    </div>
		                    <div class="card-image">
		                        <img src="${pageContext.request.contextPath}/resources/image/samsung.jpg" alt="Samsung Building">
		                    </div>
		                </article>
	                </c:forEach>
	            </section>
	        </main>
	
			<!-- 페이지네이션 -->
			<nav class="pagination">
				<a href="#" class="page-arrow">&laquo;</a> <a href="#"
					class="active">1</a> <a href="#">2</a> <a href="#">3</a> <a
					href="#">4</a> <a href="#">5</a> <a href="#" class="page-arrow">&raquo;</a>
			</nav>
	    </div>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruitment/filterEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
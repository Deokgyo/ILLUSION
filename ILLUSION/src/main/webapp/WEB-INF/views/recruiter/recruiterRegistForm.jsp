<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <%-- 외부 라이브러리 CSS --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="./resources/css/global.css">
    <link rel="stylesheet" href="./resources/css/top.css">
    <link rel="stylesheet" href="./resources/css/bottom.css">
    <link rel="stylesheet" href="./resources/css/recruiter/recruiterRegistForm.css">
    <link rel="stylesheet" href="./resources/css/components.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/filterEvent.css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
		
	</script>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
	<title>Home</title> <%-- 문구 수정 --%>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"> <%-- 사진추가 --%>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<main class="registration-form-container">
		<section class="form-header">
			<h1>공고 등록</h1>
		</section>
		
		<!-- 2. 실제 폼 내용이 들어갈 하얀색 바디 div -->
        <div class="form-body">
        	<form action="" method="post">
            	
            	<section class="subject">
	        	    <%-- 제목 입력 인풋 섹션 --%>
		            <i class="icon fa-regular fa-pen-to-square"></i>
		            <h3 class="title">제목</h3>
		            <input type="text" name="recruit_subject" class="form-control" placeholder="제목을 입력해주세요 (50자 이내)">
				</section>
				
				<%-- 채용 유형 섹션--%>
				<section class="recruit-type">
					<i class="fas fa-business-time icon"></i>
					<h3 class="title">채용 유형</h3>
		        	<select name="category" class="form-select category-select" required>
		        		<option disabled selected>채용 유형 선택</option>
		        		<option value="">정규직</option>
		        		<option value="">계약직</option>
		        		<option value="">파트타임</option>
		        		<option value="">프리랜서</option>
		        		<option value="">파견직</option>
		        		<option value="">인턴</option>
		        	</select>
	        	</section>
	        	
	        	<%-- 근무 시간 섹션 --%>
	        	<section class="work-time">
		        	<i class="fa-regular fa-clock icon"></i>
		        	<h3 class="title">근무 시간</h3>
		        	<select name="category" class="form-select category-select" required>
		        		<option disabled selected>근무 시간 선택</option>
		        		<option value="">09:00 ~ 18:00</option>
		        		<option value="">09:00 ~ 13:00</option>
		        		<option value="">14:00 ~ 18:00</option>
		        		<option value="">22:00 ~ 06:00</option>
		        		<option value="">자율 근무 / 협의</option>
		        	</select>
        		</section>
        	
        	<%-- --------------------------------근무 지역 섹션--------------------------- --%>
        	<section class="work-location">
        		
				<i class="fa-solid fa-street-view icon"></i>
	        	<h3 class="title">근무 지역</h3>
	        	
			    <%-- 상단 검색창 --%>
			    <div class="location-search-bar">
					<form id="search-form">
                		<input type="text" id="search-input" placeholder="지역을 입력하세요">
               			<button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
					</form>
      		    <hr class="divider">
			    </div>
		    	
				<%-- 근무 지역 셀렉트박스--%>
				<%-- 왼쪽: 시/도 목록 --%>
				<div class="region-panel-left">
					<ul id="major-region-list">
				    <%-- 이 부분은 JS로 동적 생성하거나, JSP로 직접 출력할 수 있습니다. --%>
						<li class="major-region-item active" data-region-code="seoul">서울</li>
						<li class="major-region-item" data-region-code="busan">부산</li>
						<li class="major-region-item" data-region-code="daegu">대구</li>
				<%-- (기타 시/도 생략) --%>
					</ul>	
				</div>
        	
				<%-- 오른쪽: 시/군/구 목록 --%>
				<div class="region-panel-right">
					<div class="filter-header">
				<%-- '전체' 체크박스 추가 --%>
						<label><input type="checkbox" id="check-all-sub-regions"> 전체</label>
						<button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
					</div>
					<div class="filter-options" id="sub-region-list">
				<%-- 시/도 클릭 시 JS가 이 영역을 동적으로 채웁니다. --%>
					</div>
					<input type="hidden" id="selected-locations" name="locations">
				</div>
        	</section>
        	<%-- -------------------------------근무 지역 섹션 끝--------------------------- --%>
        	
        	
        	<%-- 채용 인원 섹션 --%>
        	<section class="recruit-quota">
        		<i class="fa-solid fa-street-view icon"></i>
        		<h3 class="title">채용 인원</h3>
        		<!-- 체크박스 들어올 곳 -->
        		<span>미정(0명)</span>
	            <input type="text" name="recruit_subject" class="form-control" placeholder="채용인원 입력(단위:명)">
        	</section>
        	
        	
        	
        	
        	
        	
        	
        	
        	</form>
        </div>
	</main>
	
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

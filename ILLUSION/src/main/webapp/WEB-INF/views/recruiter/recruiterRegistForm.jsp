<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	
    <%-- 외부 라이브러리 CSS --%>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.9.1/summernote-bs4.min.css" rel="stylesheet">
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/recruiterRegistForm.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/filterEvent.css"> --%>
	
	
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
	<title>채용의 모든 솔루션, 일루션에서 시작됩니다.</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">
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
        	<form action="recruiterRegistForm" method="post">
            	
            	<section class="subject">
	        	    <%-- 제목 입력 인풋 섹션 --%>
	        	    <div class="title-undefined">
			            <i class="icon fa-regular fa-pen-to-square icon"></i>
			            <h3 class="title">제목</h3>
		            </div>
		            <input type="text" id="subject" name="recruit_subject" class="form-control valid" placeholder="제목을 입력해주세요 (50자 이내)">
				</section>
				
				<%-- 채용 유형 섹션--%>
				<section class="recruit-type">
					<div class="title-undefined">
						<i class="fas fa-business-time icon"></i>
						<h3 class="title">채용 유형</h3>
					</div>
		        	<select name="recruit_type" class="form-select category-select valid" required>
		        		<option disabled selected>채용 유형 선택</option>
		        		<c:forEach var="RCT" items="${commonListMap.RECRUIT_TYPE}">
		        			<option value="${RCT.code}">${RCT.code_name}</option>
		        		</c:forEach>
		        	</select>
	        	</section>
	        	
	        	<%-- 근무 시간 섹션 --%>
	        	<section class="work-time">
	        		<div class="title-undefined">
			        	<i class="fa-regular fa-clock icon"></i>
			        	<h3 class="title">근무 일시</h3>
		        	</div>
		        	<div class="workDayTime">
			        	<div class="startEndDate"> 
	       					<select name="work_start_day" class="form-select category-select valid">
							  <option disabled selected>근무 시작 요일 선택</option>
								<c:forEach var="WSD" items="${commonListMap.WORK_START_DAY}">
		        					<option value="${WSD.code}">${WSD.code_name}</option>
		        				</c:forEach>
							</select>
				        	~
	       					<select name="work_end_day" class="form-select category-select valid">
							  <option disabled selected>근무 종료 요일 선택</option>
								<c:forEach var="WED" items="${commonListMap.WORK_END_DAY}">
		        					<option value="${WED.code}">${WED.code_name}</option>
		        				</c:forEach>
							</select>
			        	</div>
			        	<div class="startEndDate"> 
				        	<input type="time" name="start_time" class="form-select category-select  valid">
				        	~
				        	<input type="time" name="end_time" class="form-select category-select  valid">
			        	</div>
		        	</div>
        		</section>
        	
        	<%-- --------------------------------근무 지역 섹션--------------------------- --%>
        	<section class="work-location">
        		<div class="title-undefined">
					<i class="fa-solid fa-street-view icon"></i>
		        	<h3 class="title">근무 지역</h3>
	        	</div>
	        	<div class="location-part">
				    <%-- 상단 검색창 --%>
<!-- 				    <div class="location-search-bar_my"> -->
<!-- 	                		<input type="text" class="form-control" id="search-input" placeholder="지역을 입력하세요"> -->
<!-- 				    </div> -->
					<%-- 근무 지역 셀렉트박스--%>
					<%-- 왼쪽: 시/도 목록 --%>
					<div class="region-panel-left">
						<ul id="major-region-list">
					    <%-- 이 부분은 JS로 동적 생성하거나, JSP로 직접 출력할 수 있습니다. --%>
					    	<c:forEach var="location" items="${locationList}">
					    		<li class="major-region-item" value="${location.code}">${location.code_name}</li>
					    	</c:forEach>
					<%-- (기타 시/도 생략) --%>
						</ul>	
					</div>
					<%-- 오른쪽: 시/군/구 목록 --%>
					<div class="region-panel-right">
						<div class="filter-header">
					<%-- '전체' 체크박스 추가 --%>
							<label class="allLabel"><input type="checkbox" id="check-all-sub-regions" class="checkbox"><span class="all">전체</span></label>
							<button type="button" class="filter-reset-btn">초기화<i class="fa-solid fa-arrows-rotate"></i></button>
						</div>
						<div class="filter-options" id="sub-region-list">
						<%-- 시/도 클릭 시 JS가 이 영역을 동적으로 채웁니다. --%>  
						</div>
						<input type="hidden" id="selected-locations" class="valid" name="location">
					</div>
					<div class="selected_location"></div>
				</div>
        	</section>
        	<%-- -------------------------------근무 지역 섹션 끝--------------------------- --%>
        	<%-- -------------------------------직무 선택 섹션----------------------------- --%>
			<section class="occupation-section">
				<div class="title-undefined">
					<i class="icon fa-regular fa-square-check"></i>
					<h3 class="title">직무 선택</h3>
				</div>
				<div class="category-grid">
					<div class="category-column">
						<h4 class="col-title">직무 카테고리</h4>
						<div class="category-options" id="occupations">
							<c:forEach var="occupation" items="${occupationList}">
								<div class="option-btn occupation" data-value="${occupation.code}">${occupation.code_name}</div>
							</c:forEach>
						</div>
					</div>			
					<div class="category-column">
						<h4 class="col-title">세부 직무</h4>
						<div class="category-options" id="jobs"></div>
					</div>
					<div class="selected-tags-area">
					<!--                           <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div> -->
					<!--                           <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div> -->
					</div>
					<input type="hidden" id="selected-occupation" class="valid" name="occupation">
				</div>
			</section>
        	<%-- -------------------------------직무 선택 섹션 끝--------------------------- --%>
        	<%-- -------------------------------채용 인원 섹션----------------------------- --%>
        	<section class="recruit-quota">
        		<div class="title-undefined">
	        		<i class="fa-solid fa-street-view icon"></i>
	        		<h3 class="title">채용 인원</h3>
	        		<input class="form-check-input" type="checkbox" id="undecided">
	        		<span>미정(0명)</span>
        		</div>
	            <input type="number" name="recruit_hiring_num" class="form-control valid" placeholder="채용인원 입력(단위:명)">
        	</section>
        	<%-- -------------------------------채용 인원 섹션 끝----------------------------- --%>
        	<section>
       			<div class="title-undefined">
		        	<i class="bi bi-person-badge icon"></i>
		        	<h3 class="title">직급 선택</h3>
	        	</div>
				<select name="position" class="form-select category-select valid">
				  <option disabled selected>직급 선택</option>
						<c:forEach var="POS" items="${commonListMap.POSITION}">
        					<option value="${POS.code}">${POS.code_name}</option>
        				</c:forEach>
				</select>
        	</section>
        	
        	<%-- -------------------------------경력 섹션 ---------------------------------- --%>
        	<section class="work-time">
        		<div class="title-undefined">
		        	<i class="fa-solid fa-briefcase icon"></i>
		        	<h3 class="title">경력 조건</h3>
	        	</div>
	        	<select name="experience" class="form-select category-select valid" required>
	        		<option disabled selected>경력 조건 선택</option>
	        		<c:forEach var="EXP" items="${commonListMap.EXPERIENCE}">
        					<option value="${EXP.code}">${EXP.code_name}</option>
       				</c:forEach>
	        	</select>
       		</section>
        	<%-- -------------------------------경력 섹션 끝--------------------------------- --%>
        	<%-- -------------------------------학력 섹션 ---------------------------------- --%>
	    	    <section class="work-time">
	        		<div class="title-undefined">
			        	<i class="bi bi-mortarboard icon"></i>
			        	<h3 class="title">학력</h3>
		        	</div>
		        	<select name="degree" class="form-select category-select valid" required>
		        		<option disabled selected>학력 선택</option>
		        		<c:forEach var="DEG" items="${commonListMap.DEGREE}">
        					<option value="${DEG.code}">${DEG.code_name}</option>
        				</c:forEach>
		        	</select>
	       		</section>
	        	<%-- -------------------------------학력 섹션 끝----------------------------- --%>
	        	<%-- -------------------------------급여 섹션 ---------------------------------- --%>
	    	   	<section class="salary">
	        		<div class="title-undefined">
			        	<i class="fa-solid fa-hand-holding-dollar icon"></i>
			        	<h3 class="title">급여</h3>
		        	</div>
		        	<select name="salary" class="form-select category-select valid" required>
		        		<option disabled selected>급여 선택</option>
			        	<c:forEach var="SAL" items="${commonListMap.SALARY}">
	        					<option value="${SAL.code}">${SAL.code_name}</option>
	        				</c:forEach>
		        	</select>
	       		</section>
	        	<%-- -------------------------------급여 섹션 끝----------------------------- --%>
        	<%-- -------------------------------채용 공고 내용 섹션------------------------ --%>
        	<section class="recruit-detail">
	 		    <div class="title-undefined">
	            	<i class="icon fa-regular fa-pen-to-square icon"></i>
	            	<h3 class="title">채용 정보 상세 입력</h3>
	             </div>
	             <textarea id="summernote" name="recruit_context" class="valid"></textarea> 
       		</section>
       		<%-- -------------------------------채용 공고 내용 섹션 끝------------------------ --%> 
       		<%----------------------------------우대사항 섹션------------------------------ --%>
       		<section>
	 		    <div class="title-undefined">
	            	<i class="bi bi-stars icon"></i>
	            	<h3 class="title">우대사항</h3>
	            </div>
            	<input type="text" name="preferred" class="form-control" placeholder="우대사항 입력(선택사항)"/>	       		
       		</section>
       		<%-- -------------------------------우대사항 섹션 끝------------------------ --%> 
       		<%----------------------------------마감 날짜 섹션------------------------------ --%>
	 		<section class="deadLine">
	 		    <div class="title-undefined">
	            	<i class="fa-regular fa-calendar-days icon"></i>
	            	<h3 class="title">채용 시작 · 마감 일</h3>
	            </div>
	            <div class="startEndDate">
	            	<input type="datetime-local" name="start_date" class="form-control valid"/>
	            	<input type="datetime-local" name="end_date" class="form-control valid"/>
	            </div>
	        </section> 
       		<%----------------------------------마감 날짜 섹션 끝---------------------------- --%>
			<%-- 지원 서류 지원 방법 섹션  --%>
			<section class="section-applyDocMethod">
	 		    <div class="title-undefined">
	            	<i class="bi bi-file-earmark-text icon"></i>
	            	<h3 class="title">지원 서류</h3>
	            </div>				
	 		    <div class="title-undefined">
	            	<i class="bi bi-box-arrow-up-right icon"></i>
	            	<h3 class="title">지원 방법</h3>
	            </div>	
					<input type="text" name="apply_doc" class="form-control valid" placeholder="필요 지원 서류 입력"/>
					<input type="text" name="apply_method" class="form-control valid" placeholder="지원 방법 입력"/>			
			</section>
			<%-- 지원 서류 지원 마감 섹션 끝 --%>
			<%-- 채용중 상태 히든으로 올리기 --%>
			<input type="hidden" name="rec_status" value="RECS01"> 
        	<div class="btn-container">
	        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        		<input type="submit" id="submit" class="btn-yellow" value="등록">
        	</div>
        	</form>
        </div>
	</main>
	
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
	<%-- js 관련 설정들 --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.9.1/summernote.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/lang/summernote-ko-KR.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/recruiter/recruiterRegistForm.js"></script>
	
	
</body>
</html>

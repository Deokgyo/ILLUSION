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
<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recuritment/filterEvent.css"> --%>
	
	
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
        	<form action="recruiterRegistForm" method="post">
            	
            	<section class="subject">
	        	    <%-- 제목 입력 인풋 섹션 --%>
	        	    <div class="title-undefined">
			            <i class="icon fa-regular fa-pen-to-square icon"></i>
			            <h3 class="title">제목</h3>
		            </div>
		            <input type="text" name="recruit_subject" class="form-control" placeholder="제목을 입력해주세요 (50자 이내)">
				</section>
				
				<%-- 채용 유형 섹션--%>
				<section class="recruit-type">
					<div class="title-undefined">
						<i class="fas fa-business-time icon"></i>
						<h3 class="title">채용 유형</h3>
					</div>
		        	<select name="recruit_type" class="form-select category-select" required>
		        		<option disabled selected>채용 유형 선택</option>
		        		<option value="RCT001">정규직</option>
		        		<option value="RCT002">계약직</option>
		        		<option value="RCT004">프리랜서</option>
		        		<option value="RCT003">인턴</option>
		        		<option value="RCT005">파트타임</option>
		        		<option value="RCT006">파견직</option>
		        	</select>
	        	</section>
	        	
	        	<%-- 근무 시간 섹션 --%>
	        	<section class="work-time">
	        		<div class="title-undefined">
			        	<i class="fa-regular fa-clock icon"></i>
			        	<h3 class="title">근무 시간</h3>
		        	</div>
		        	<select name="workTime" class="form-select category-select" required>
		        		<option disabled selected>근무 시간 선택</option>
		        		<option value="WT001">09:00 ~ 18:00</option>
		        		<option value="WT002">09:00 ~ 13:00</option>
		        		<option value="WT003">14:00 ~ 18:00</option>
		        		<option value="WT004">22:00 ~ 06:00</option>
		        		<option value="WT005">자율 근무 / 협의</option>
		        	</select>
        		</section>
        	
        	<%-- --------------------------------근무 지역 섹션--------------------------- --%>
        	<section class="work-location">
        		<div class="title-undefined">
					<i class="fa-solid fa-street-view icon"></i>
		        	<h3 class="title">근무 지역</h3>
	        	</div>
	        	<div class="location-part">
				    <%-- 상단 검색창 --%>
				    <div class="location-search-bar_my">
	                		<input type="text" class="form-control" id="search-input" placeholder="지역을 입력하세요">
				    </div>
			    	
					<%-- 근무 지역 셀렉트박스--%>
					<%-- 왼쪽: 시/도 목록 --%>
					<div class="region-panel-left">
						<ul id="major-region-list">
					    <%-- 이 부분은 JS로 동적 생성하거나, JSP로 직접 출력할 수 있습니다. --%>
<!-- 							<li class="major-region-item" data-region-code="seoul">서울</li> -->
<!-- 							<li class="major-region-item" data-region-code="busan">부산</li> -->
<!-- 							<li class="major-region-item" data-region-code="daegu">대구</li> -->
					<%-- (기타 시/도 생략) --%>
						</ul>	
					</div>
	        	
					<%-- 오른쪽: 시/군/구 목록 --%>
					<div class="region-panel-right">
						<div class="filter-header">
					<%-- '전체' 체크박스 추가 --%>
							<label><input type="checkbox" id="check-all-sub-regions" class="checkbox"><span>전체</span></label>
							<button type="button" class="filter-reset-btn">초기화<i class="fa-solid fa-arrows-rotate"></i></button>
						</div>
						<div class="filter-options" id="sub-region-list">
						<%-- 시/도 클릭 시 JS가 이 영역을 동적으로 채웁니다. --%>  
						</div>
						<input type="hidden" id="selected-locations" name="full_address">
					</div>
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
<!-- 				            <div class="option-btn occupation">디자인</div> -->
<!-- 				            <div class="option-btn active">개발자</div> -->
<!-- 				            <div class="option-btn">마케팅</div> -->
				        </div>
				    </div>			
                   <div class="category-column">
	                   <h4 class="col-title">세부 직무</h4>
	                   <div class="category-options" id="jobs">
<!-- 	                       <div class="option-btn job" >마케팅 기획</div> -->
<!-- 	                       <div class="option-btn active job" >백엔드</div> -->
<!-- 	                       <div class="option-btn">컨설턴트</div> -->
	                   </div>
	               </div>
                  <div class="selected-tags-area">
                          <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div>
                          <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div>
                     </div>
                     <input type="hidden" id="selected-occupation" name="occupation">
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
	            <input type="number" name="recruit_hiring_num" class="form-control" placeholder="채용인원 입력(단위:명)">
        	</section>
        	<%-- -------------------------------채용 인원 섹션 끝----------------------------- --%>
        	<%-- -------------------------------경력 섹션 ---------------------------------- --%>
        	<section class="work-time">
        		<div class="title-undefined">
		        	<i class="fa-solid fa-briefcase icon"></i>
		        	<h3 class="title">경력 조건</h3>
	        	</div>
	        	<select name="category" class="form-select category-select" required>
	        		<option disabled selected>경력 조건 선택</option>
	        		<option value="">경력</option>
	        		<option value="">신입</option>
	        		<option value="">무관</option>
	        	</select>
       		</section>
        	<%-- -------------------------------경력 섹션 끝--------------------------------- --%>
        	<%-- -------------------------------학력 섹션 ---------------------------------- --%>
	    	<div class="edusalary">   
	    	    <section class="work-time">
	        		<div class="title-undefined">
			        	<i class="fa-solid fa-briefcase icon"></i>
			        	<h3 class="title">학력</h3>
		        	</div>
		        	<select name="category" class="form-select category-select" required>
		        		<option disabled selected>학력 선택</option>
		        		<option value="">고등학교 졸</option>
		        		<option value="">전문대 졸</option>
		        		<option value="">대학교 졸</option>
		        		<option value="">석사</option>
		        		<option value="">박사</option>
		        		<option value="">학력 무관</option>
		        	</select>
	       		</section>
	        	<%-- -------------------------------학력 섹션 끝----------------------------- --%>
	        	<%-- -------------------------------급여 섹션 ---------------------------------- --%>
	    	   	<section class="salary">
	        		<div class="title-undefined">
			        	<i class="fa-solid fa-hand-holding-dollar icon"></i>
			        	<h3 class="title">급여</h3>
		        	</div>
		        	<select name="category" class="form-select category-select" required>
		        		<option disabled selected>급여 선택</option>
		        		<option value="">1000 ~ 2000 만원</option>
		        		<option value="">2000 ~ 3000 만원</option>
		        		<option value="">3000 ~ 4000 만원</option>
		        		<option value="">4000 ~ 5000 만원</option>
		        		<option value="">5000 ~ 6000 만원</option>
		        		<option value="">면접 후 협의</option>
		        	</select>
	       		</section>
        	</div>
	        	<%-- -------------------------------급여 섹션 끝----------------------------- --%>
        	<%-- -------------------------------채용 공고 내용 섹션------------------------ --%>
        	<section class="recruit-detail">
	 		    <div class="title-undefined">
	            	<i class="icon fa-regular fa-pen-to-square icon"></i>
	            	<h3 class="title">채용 정보 상세 입력</h3>
	            </div>
			
				<div class="editor" id="editor" contenteditable="true">
				  담당 업무, 자격 요건, 우대 조건, 근무 환경, 채용 절차 등 지원자에게 필요한 정보를 구체적으로 입력해주세요.
				</div>
				<textarea name="content" id="hiddenContent" hidden></textarea>
		           	<div class="toolbar">
					  <button type="button" onclick="format('bold')"><i class="fa-solid fa-bold icon btn"></i></button>
					  <button type="button" onclick="format('italic')"><i class="fa-solid fa-italic icon btn"></i></button>
					  <button type="button" onclick="document.getElementById('upload').click()"><i class="fa-solid fa-arrow-up-from-bracket icon btn"></i></button>
					  <input type="file" accept="image/*" id="upload" hidden>
					</div>
<!-- 	            <textarea name="content" placeholder="담당 업무, 자격 요건, 우대 조건, 근무 환경, 채용 절차 등 지원자에게 필요한 정보를 구체적으로 입력해주세요."></textarea> -->
       		</section>
       		<%-- -------------------------------채용 공고 내용 섹션 끝------------------------ --%>            
       		<%----------------------------------마감 날짜 섹션------------------------------ --%>
	 		<section class="deadLine">
	 		    <div class="title-undefined">
	            	<i class="fa-regular fa-calendar-days icon"></i>
	            	<h3 class="title">공고 마감 날짜</h3>
	            </div>
	            	<input id="datepicker" class="form-control" placeholder="날짜 선택"/>
	        </section>    
       		<%----------------------------------마감 날짜 섹션 끝---------------------------- --%>
       		<%----------------------------------문의 email 섹션------------------------------ --%>
 		    <section class="email">
	 		    <div class="title-undefined">
	           		<i class="fa-regular fa-envelope icon"></i>
	            	<h3 class="title">문의 E-mail</h3>
	            </div>
	            <input type="text" name="email" class="form-control" placeholder="E-mail을 입력해주세요">
       		</section>
       		<%----------------------------------문의 email 섹션 끝---------------------------- --%>
        	<div class="btn-container">
        		<button class="btn-yellow"> 제출 </button>
        	</div>
        	</form>
        </div>
	</main>
	
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
	<%-- js 관련 설정들 --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/recruiter/recruiterRegist.js"></script>
	 <script src="https://cdn.jsdelivr.net/npm/@easepick/bundle@1.2.1/dist/index.umd.min.js"></script>
	    <script>
      const picker = new easepick.create({
        element: document.getElementById('datepicker'),
        css: [
          'https://cdn.jsdelivr.net/npm/@easepick/bundle@1.2.1/dist/index.css',
        ],
      });
    </script>
	
</body>
</html>

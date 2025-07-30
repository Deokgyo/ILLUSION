<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%-- 
	작성자 : 박덕교 
	용도 : 채용 공고 등록 폼 
	작성일 : 25-07-08
	수정일 : 25-07-08

 --%>
<html>
<head>
    <%-- 외부 라이브러리 CSS --%>
    
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="./resources/css/global.css">
    <link rel="stylesheet" href="./resources/css/top.css">
    <link rel="stylesheet" href="./resources/css/bottom.css">
    <link rel="stylesheet" href="./resources/css/recruiter/recruiterRegistForm.css">
    <link rel="stylesheet" href="./resources/css/components.css">
	<title>Home</title>
</head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<main>
		<%-- 메인 상단 공고현황 & 프로필 정보 묶음 --%>
		<div class="dashboard-layout">
		
			<div class="section-name">
			  	<p>현재 상황을 한눈에 보세요!</p>
			</div>
			<%-- 페이지 상단 공고현황 섹션 --%>
			<section class="recruit-info-section section-container">
			
				<div class="section-dash01">
				  <%-- 대시보드 안내문구 --%>
				  <div class="section-content">
				  	<h1>공고 현황</h1>
				  	<p>진행중 공고</p>
				  	<h2>10</h2>
					<hr>				  	
				  	<p>미열람 이력서</p>
				  	<h2>10</h2>
				  	<input type="button" value="공고관리" class="btn-yellow">
				  </div>
				 </div>  
				<div class="section-dash02">
					<div class="section-content">
						<h1>공고목록</h1>
					</div>
				</div>   
			</section>
			
			<%-- 페이지 상단 프로필 정보 --%>
			<section class="profile-section section-container">
				<h1>박덕교님</h1>
			</section>
		</div>
		<%-- 페이지 상단 공고현황 섹션 끝--%>
		
		
		<%-- 메인 중간 회사 맞춤 인재 --%>
		<section class="company-fit-section">
			<div class="section-name">
			  	<p>우리회사 맞춤 인재</p>
			</div>
			<%-- 카드들 담는 컨테이너 --%>
			<div class="cards-container">
			<%-- 카드 1개씩 각각 --%>
				<div class="card">
					<h1>사용자의 경험을 생각하는 웹 디자이너</h1>
					<p>
						경력 : 신입<br>
						학력 : 대졸 | 시각디자인학과<br>
						거주지 : 부산
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
				<div class="card">
					<h1>문제 해결에 강한 백엔드 개발자</h1>
					<p>
						경력 : 2년<br>
						학력 : 대졸 | 컴퓨터공학과<br>
						거주지 : 김해
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
				<div class="card">
					<h1>꼼꼼함과 책임감을 갖춘<br> 행정사무 지원자</h1>
					<p>
						경력 : 신입<br>
						학력 : 대졸 | 경영학과<br>
						거주지 : 서울
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
				<div class="card">
					<h1>데이터로 문제를 해결하는 분석가</h1>
					<p>
						경력 : 5년<br>
						학력 : 대졸 | 통계학<br>
						거주지 : 부산
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
				<div class="card">
					<h1>정확하고 책임감 있는 생산현장 사원</h1>
					<p>
						경력 : 2년<br>
						학력 : 고졸<br>
						거주지 : 울산
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
				<div class="card">
					<h1>학생 눈높이에 맞춘 영어교육 전문가</h1>
					<p>
						경력 : 신입<br>
						학력 : 대졸 | 교육학<br>
						거주지 : 서울
					</p>
					<input type="button" class="btn" value="이력서보기"> 
				</div>
			</div>
		</section>
		
		<%--메인 하단 5가지 팁 --%>
		<section class="tip-section section-container">
			<div class="section-name">
			  	<p>좋은 인재를 고르는 5가지 팁</p>
			  	<hr>
			</div>
			<div class="tips-container">
				<div class="tip">
					<h1>제목</h1>
					<p>내용</p>
				</div>			
				<div class="tip">
					<h1>제목</h1>
					<p>내용</p>
				</div>			
				<div class="tip">
					<h1>제목</h1>
					<p>내용</p>
				</div>			
				<div class="tip">
					<h1>제목</h1>
					<p>내용</p>
				</div>			
			</div>			
		</section>
		<%--메인 하단 5가지 팁 끝--%>
		
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

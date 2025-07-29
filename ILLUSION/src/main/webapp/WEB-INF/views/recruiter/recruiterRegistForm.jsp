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
		<%-- 페이지 상단 공고현황 & 프로필 정보 묶음 --%>
		<div class="dashboard-layout">
		
			<%-- 페이지 상단 공고현황 섹션 --%>
			<section class="recruit-info-section">
			  <div class="section-title">
			  	<p>현재 상황을 한눈에 보세요!</p>
			  </div>
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
			<section class="profile-section">
			
			</section>
		</div>
		<section></section>
		<section></section>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</main>
	
	
	

	

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

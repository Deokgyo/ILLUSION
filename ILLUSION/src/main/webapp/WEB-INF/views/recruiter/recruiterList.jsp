<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    
    <%-- 외부 라이브러리 CSS --%>
	<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
   	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/recruiterList.css">
	
	<title>Home</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	
	<main>
		<section class="list-header">
			<h1>공고 목록</h1>
		</section>
		<section class="main-list">
			
			<div class="tab-container">
			  <div class="tab active">전체</div>
			  <div class="tab" data-value="RECS01">채용중인 공고</div>
			  <div class="tab" data-value="RECS02">마감된 공고</div>
			</div>
			<div id="grid" class="custom-grid"></div>
			
		</section>
		<section class="notice-box">
			<ul>
			    <li><span class="dot"></span> 등록된 공고는 최대 30일간 노출됩니다.</li>
			    <li><span class="dot"></span> 기업의 요청 또는 플랫폼 운영 방침에 따라 사전 고지 없이 삭제될 수 있습니다.</li>
			    <li><span class="dot"></span> 구직자의 신고 또는 플랫폼 검수에서 문제가 확인될 경우 즉시 비노출 처리됩니다</li>
			    <li><span class="dot"></span> 등록된 공고는 최대 30일간 노출됩니다.</li>
			    <li><span class="dot"></span> 기업의 요청 또는 플랫폼 운영 방침에 따라 사전 고지 없이 삭제될 수 있습니다.</li>
			    <li><span class="dot"></span> 구직자의 신고 또는 플랫폼 검수에서 문제가 확인될 경우 즉시 비노출 처리됩니다</li>
  			</ul>
		</section>
	
	</main>	
	

	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
	<%-- js 파일  --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/recruiter/recruiterList.js"></script>
</body>
</html>

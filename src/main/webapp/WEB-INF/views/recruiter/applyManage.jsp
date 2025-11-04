<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	    <%-- 외부 라이브러리 CSS --%>
	<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/applyManage.css">
	<title>채용의 모든 솔루션, 일루션에서 시작됩니다.</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">

</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<main>
    	<section class="list-header">
			<h1>지원자 관리</h1>
		</section>
    		<div id="applicant-grid"></div>
	</main>
		
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<%-- js 파일 --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/commonJs.js"></script>
    <script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/recruiter/applyManage.js"></script>
</body>
</html>
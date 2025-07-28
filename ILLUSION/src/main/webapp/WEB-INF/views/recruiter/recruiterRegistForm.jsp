<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>

<%-- 
	작성자 : 박덕교 
	용도 : 채용 공고 등록 폼 
	작성일 : 25-07-08
	수정일 : 25-07-08

 --%>

<head>
    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
	
	<title>Home</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>


	<h1>채용 공고 등록 폼</h1>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

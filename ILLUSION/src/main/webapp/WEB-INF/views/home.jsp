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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
	<style type="text/css">
	.btn-bd-primary {
		background-color:#FFE585;
 		border-radius : 15px;			
}
	.btn-bd-primary:hover {
		background-color: #fcd34d;
}
	.btn-bd-primary:disabled {
		opacity:.65;
}
	
	</style>
	<title>Home</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<h1>
		<input class="btn-bd-primary" type="button" value="Input" disabled="disabled">
	</h1>
	
	

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

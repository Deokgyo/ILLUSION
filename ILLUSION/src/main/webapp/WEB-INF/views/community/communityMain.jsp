<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
</head>
<body>
	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp"></jsp:include>
		<main class="main-content">
			<div class="form-box">
				 <div class="page-title-header">
                    <p class="header-text"><strong>커뮤니티</strong></p>
                </div>
                <div class="">
                </div>
			</div>
		</main>
	</div>
	
	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>
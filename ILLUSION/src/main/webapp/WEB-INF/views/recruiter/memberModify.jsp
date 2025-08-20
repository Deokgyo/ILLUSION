<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/recruiter/memberModify.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>

		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text"> <strong>회원정보 수정 </strong></p>
			</div>
			
			<section class="memberInfo-container">
				<div class="memberInfo">
					<div class="attr">
						<div class="logo col">기업로고</div>
						<div class="companyName col">기업이름</div>
						<div class="CEOName col">대표자명</div>
						<div class="estDate col">설립일</div>
						<div class="addr col">주소</div>
						<div class="id col">아이디</div>
						<div class="managerName col">담당자 이름</div>
						<div class="email col">이메일</div>
					</div>
					<div class="val">
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
						<div class="row">기업로고</div>
					</div>
					<div class="btn-group">
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
						<button class="btn btn-yellow">수정</button>
					</div>
				</div>
			</section>
			

		</main>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>
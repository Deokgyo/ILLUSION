<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<%-- 외부 라이브러리 CSS --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%-- 우리가 만든 CSS 파일들 --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/home/home.css">
<style type="text/css">
.btn-bd-primary {
	background-color: #FFE585;
	border-radius: 15px;
}

.btn-bd-primary:hover {
	background-color: #fcd34d;
}

.btn-bd-primary:disabled {
	opacity: .65;
}
</style>
<title>Home</title>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<main class="center-content">
		<h1>
			<span class="bg-text">ILLUSION</span> <span class="highlight">ILLUSION이
				채용의<br> 시작을 바꿉니다
			</span>
		</h1>
		<p class="desc">이력서부터 면접까지, 당신의 커리어를 스마트하게 설계하세요.</p>
		<div class="btn-group">
			<button>자기소개서 생성하기</button>
			<button>채용정보 바로 가기</button>
		</div>
		<div class="bottom-menu">
			<span>📝 자기소개서 생성하기</span> <span>✏️ 자기소개서 다듬기</span> <span>🤖
				AI 면접 예상질문 생성</span> <span>💬 취업상담 챗봇</span>
		</div>

	</main>


	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

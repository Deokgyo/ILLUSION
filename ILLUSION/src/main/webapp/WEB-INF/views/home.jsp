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

	<!------------------------------ILLUSION 기능------------------------->
	<div class="illusion-container">
		<h1 class="illusion-title">ILLUSION의 기능</h1>

		<div class="illusion-feature-list">

			<div class="feature-card">
				<div class="feature-icon icon1"></div>
				<div class="feature-content">
					<h2 class="feature-title">자기소개서 생성기</h2>
					<p class="feature-desc">버튼만으로 경험과 직무에 맞춘 맞춤형 자기소개서를 편리하게 생성하는
						자기소개서 생성기</p>
					<button class="feature-btn">자세히 보기</button>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon icon2"></div>
				<div class="feature-content">
					<h2 class="feature-title">자기소개서 다듬기</h2>
					<p class="feature-desc">직접 작성한 자기소개서와 문서파일을 온라인으로 업로드하면 감정이 들어간
						피드백과 첨삭을 받을 수 있습니다.</p>
					<button class="feature-btn">자세히 보기</button>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon icon3"></div>
				<div class="feature-content">
					<h2 class="feature-title">AI 면접 예상 질문</h2>
					<p class="feature-desc">직무와 맞춤형 정보로 AI가 면접에 나올 법한 주요 질문을 미리 모아
						제공해드립니다.</p>
					<button class="feature-btn">자세히 보기</button>
				</div>
			</div>

			<div class="feature-card">
				<div class="feature-icon icon4"></div>
				<div class="feature-content">
					<h2 class="feature-title">취업상담 챗봇</h2>
					<p class="feature-desc">학습된 데이터를 토대로, 맞춤 피드백 및 취업 멘토처럼 취업에 관한
						고민상담이 가능한 챗봇입니다.</p>
					<button class="feature-btn">자세히 보기</button>
				</div>
			</div>

		</div>
	</div>


























	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

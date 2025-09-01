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
<title>ILLUSION</title>
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
			<button
				onclick="location.href='${pageContext.request.contextPath}/coverletterCreate'">자기소개서
				생성하기</button>
			<button
				onclick="location.href='${pageContext.request.contextPath}/recruitmentInfo'">채용정보
				바로 가기</button>
		</div>
		<div class="bottom-menu">
			<span>📝 자기소개서 생성하기</span> <span>✏️ 자기소개서 다듬기</span> <span>🤖
				AI 면접 예상질문 생성</span> <span>💬 취업상담 챗봇</span>
		</div>

	</main>

	<!------------------------------ILLUSION 기능------------------------->
	<div class="illusion-feature-wrap">
		<div class="illusion-feature-title">ILLUSION의 기능</div>

		<!-- 기능 1 -->
		<div class="illusion-feature-box">
			<div class="illusion-feature-icon">
				<img
					src="${pageContext.request.contextPath}/resources/image/home/Vector.jpg"
					alt="기능 이미지">
			</div>
			<div class="illusion-feature-content">
				<div class="illusion-feature-name">자기소개서 생성기</div>
				<div class="illusion-feature-desc">
					"사용자의 경험과 강점을 분석해 맞춤형 자기소개서를<br> 빠르게 생성하는 AI 자기소개서 생성기"
				</div>
				<button class="illusion-feature-btn"
					onclick="location.href='${pageContext.request.contextPath}/coverletterCreate'">자세히
					보기</button>
			</div>
		</div>

		<div class="illusion-feature-box">
			<div class="illusion-feature-icon">
				<img
					src="${pageContext.request.contextPath}/resources/image/home/done.jpg"
					alt="기능 이미지">
			</div>
			<div class="illusion-feature-content">
				<div class="illusion-feature-name">자기소개서 다듬기</div>
				<div class="illusion-feature-desc">"지원 직무와 회사 맞춤형으로 논리적이고 감정이
					돋보이는 문장으로 자동 첨삭해 드립니다."</div>
				<button class="illusion-feature-btn"
					onclick="location.href='${pageContext.request.contextPath}/coverletterRefiner'">자세히
					보기</button>
			</div>
		</div>

		<!-- 기능 3 -->
		<div class="illusion-feature-box">
			<div class="illusion-feature-icon">
				<img
					src="${pageContext.request.contextPath}/resources/image/home/AI.jpg"
					alt="기능 이미지">
			</div>
			<div class="illusion-feature-content">
				<div class="illusion-feature-name">AI 면접 예상 질문</div>
				<div class="illusion-feature-desc">"매번 달라지는 최신 트렌드를 반영한 직무/분기
					업종 맞춤 AI 면접 예상질문 생성 기능"</div>
				<button class="illusion-feature-btn"
					onclick="location.href='${pageContext.request.contextPath}/interviewResult'">자세히
					보기</button>
			</div>
		</div>

		<!-- 기능 4 -->
		<div class="illusion-feature-box">
			<div class="illusion-feature-icon">
				<img
					src="${pageContext.request.contextPath}/resources/image/home/Chat.jpg"
					alt="기능 이미지">
			</div>
			<div class="illusion-feature-content">
				<div class="illusion-feature-name">취업상담 챗봇</div>
				<div class="illusion-feature-desc">"채용 트렌드 분석, 지원서 작성, 면접 대비까지
					취업 전 과정을 챗봇이 친절하게 안내합니다."</div>
				<button class="illusion-feature-btn"
					onclick="location.href='${pageContext.request.contextPath}/chatbot'">자세히
					보기</button>
			</div>
		</div>

	</div>


	<!-------------------------- 자주묻는 질문 ----------------------------->
	<div class="clean-faq-list">
		<div class="clean-faq-title">자주묻는 질문</div>

		<div class="clean-faq-box">
			<button class="clean-faq-question" type="button">
				<span class="clean-faq-q-text">Q.ILLUSION에는 어떤 기능이 있나요?</span> <span
					class="clean-faq-plus">+</span>
			</button>
			<div class="clean-faq-answer">A. ILLUSION에는 자소서 다듬기, 생성기 등이
				있습니다.</div>
		</div>

		<div class="clean-faq-box">
			<button class="clean-faq-question" type="button">
				<span class="clean-faq-q-text">Q.회원가입은 어떻게 하나요?</span> <span
					class="clean-faq-plus">+</span>
			</button>
			<div class="clean-faq-answer">A. 상단 메뉴의 ‘회원가입’ 버튼을 눌러 이메일과
				비밀번호로 간단히 가입 가능합니다.</div>
		</div>

		<div class="clean-faq-box">
			<button class="clean-faq-question" type="button">
				<span class="clean-faq-q-text">Q.모바일에서도 사용할 수 있나요?</span> <span
					class="clean-faq-plus">+</span>
			</button>
			<div class="clean-faq-answer">A. 네, 모바일 브라우저에서도 동일하게 사용하실 수
				있습니다.</div>
		</div>
	</div>

	<!--------------------------채용정보 ----------------------------->

	<section class="team-job-listings">
		<h2 class="team-job-title-main">지금 핫한 채용정보는?</h2>
		<!-- 1줄: 네이버, 현대 -->
		<c:forEach var="r" items="${recruitList }">
			<div class="team-job-row">
				<article class="team-job-card">
					<div class="team-card-header">
						<div class="team-logo-image">
							<img src="/illusion/resources/image/logo-naver.jpg" alt="NAVER">
						</div>
						<p class="team-job-title">${r.recruit_subject }</p>
						<div class="team-card-meta">
							<span>마감일 : ${r.endDateFormatted } / 조회수 : ${r.views_count }</span>
							<a href="recruitmentDetail?recruit_idx=${r.recruit_idx }"
								class="stretched-link"></a>
						</div>
					</div>
					<div class="team-card-image">
						<img
							src="/illusion/resources/image/ILLUSION_recruitment_image.png"
							alt="ILLUSION_recruitment_image">
					</div>
				</article>
			</div>
		</c:forEach>
	</section>

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/home/home.js"></script>
</body>
</html>

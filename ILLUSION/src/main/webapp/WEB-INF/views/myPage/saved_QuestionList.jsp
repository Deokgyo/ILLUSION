<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/saved_Question.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<div class="page-container">

		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="ai-interview-container">
			<div class="page-title-header">
        <p class="header-text"><strong>저장된 AI 면접 예상질문 </strong> </p>
    </div>


				<!-- 질문 블록 -->
				<div class="question-block">
					<div class="question-header">
						<span class="question-icon">❓</span> <span class="question-text">자격증은
							어떤 이유로 취득하게 되었나요?</span>
						<div class="button-group">
							<button class="copy-btn">복사</button>
							<button class="delete-btn" onclick="confirm('저장하시겠습니까?')">삭제</button>
						</div>
					</div>

					<textarea class="user-answer" placeholder="내가 작성한 답변"></textarea>

					<div class="ai-feedback">
						<img src="https://cdn-icons-png.flaticon.com/512/4712/4712104.png"
							alt="AI 아이콘" class="ai-icon" /> <span class="feedback-text">
							질문은 좋으나 문장의 전체적 구성력과 근거들이 부족합니다 </span>
					</div>
				</div>

				<!-- 동일 블록 반복 추가 -->
				<div class="question-block">
					<!-- 동일 내용 반복 -->
					<div class="question-header">
						<span class="question-icon">❓</span> <span class="question-text">자격증은
							어떤 이유로 취득하게 되었나요?</span>
						<div class="button-group">
							<button class="copy-btn">복사</button>
							<button class="delete-btn" onclick="confirm('삭제하시겠습니까?')">삭제</button>
						</div>
					</div>
					<textarea class="user-answer" placeholder="내가 작성한 답변"></textarea>
					<div class="ai-feedback">
						<img src="https://cdn-icons-png.flaticon.com/512/4712/4712104.png"
							alt="AI 아이콘" class="ai-icon" /> <span class="feedback-text">질문은
							좋으나 문장의 전체적 구성력과 근거들이 부족합니다</span>
					</div>
				</div>

				<!-- 예시질문 추가 버튼 -->
				<div class="add-question-wrap">
					<button class="add-question-btn">+ 예상질문 생성하기</button>
				</div>
			</div>



		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
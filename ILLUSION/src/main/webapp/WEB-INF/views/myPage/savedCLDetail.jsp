<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자기소개서 상세페이지</title>
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
	href="${pageContext.request.contextPath}/resources/css/top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/savedCLDetail.css">
<style type="text/css">
.form-box{
box-shadow: var(--main-box-shadow);
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
	<div class="qna-container">
    <div class="qna-header">항상 최선을 다하는 개발자가 되겠습니다</div>

    <div class="qna-box">
      <div class="qna-count">
        <span>700자 중 현재 <strong>544자</strong></span>
      </div>

      <div class="qna-question">
        <div class="q-symbol">Q</div>
        <div class="q-text">자격증은 어떤 이유로 취득하게 되었나요?</div>
      </div>

      <div class="qna-answer-box">
        <textarea readonly>
		${cl.title }
        </textarea>
      </div>
    </div>

    <div class="button-group">
      <a href="savedCLList"><button class="btn">목록</button></a>
      <button class="btn">수정</button>
      <button class="btn">삭제</button>
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
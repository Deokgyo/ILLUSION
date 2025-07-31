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
	href="${pageContext.request.contextPath}/resources/css/mypage/savedCLDetail.css">
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
저는 창의적인 디자인에 관심이 많은 소프트웨어 개발자입니다. 면접을 준비하며 이력서의 작성 배경과 Illusion 프로젝트 경험을 상세하게 담기 위해 자격증을 준비하게 되었습니다. 자격증 준비를 하며 AI와 소프트웨어 설계 과정을 학습하였고, Java 언어의 기초부터 Spring과 MyBatis를 사용한 웹 개발, HTTP 통신 및 클라이언트-서버 구조의 이해도를 높일 수 있었습니다.

자격증 과정과 프로젝트의 연계를 통해, 문제 해결능력, 정보 수집능력, 의사소통능력을 배양하였으며, 실제 프로젝트에서는 DB 모델링, Eclipse를 통한 백엔드 개발과 API 설계 등 실무 능력을 익히게 되었습니다. 저는 이러한 경험을 통해 책임감을 갖고 꾸준히 학습하며 성장할 수 있다는 자신감을 얻었습니다.

향후에도 다양한 기술을 지속적으로 학습하여 소통과 협업에 강한 개발자로 성장하겠습니다.
        </textarea>
      </div>
    </div>

    <div class="button-group">
      <a href="saved_CLList"><button class="btn">목록</button></a>
      <button class="btn">수정</button>
      <button class="btn delete">삭제</button>
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
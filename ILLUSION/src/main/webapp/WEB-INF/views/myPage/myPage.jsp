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
	href="${pageContext.request.contextPath}/resources/css/mypage/mypage.css">
<style type="text/css">
#main {
	
}
</style>
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>

<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
		<div class="form-box">
			<div class="profile-box">
      <div class="profile-left">
        <div class="profile-img"><img src="image/profile1.png"></div>
        <div class="profile-info">
          <div class="username">일루션님</div>
          <div class="email">illusion@naver.com</div>
          <div class="token">🪙 30 토큰</div>
          <button class="edit-btn"><a href="User_Info_Edit">회원정보수정</a></button>
        </div>
      </div>
      <div class="profile-right">
        <div class="action-btn"><a href="resumeWrite">📄 이력서 작성</a></div>
        <div class="action-btn"><a href="token_pay">💰 토큰 충전</a></div>
      </div>
    </div>

    <!-- 저장한 파일 -->
    <div class="section">
      <h1>저장한 파일</h1>
      <div class="grid">
        <div class="file-card"><a href="saved_ResumeList">📄 생성된 이력서</a></div>
        <div class="file-card"><a href="saved_CLList">📝 생성된 자기소개서</a></div>
        <div class="file-card"><a href="saved_QuestionList">🎤 저장된 면접 예상 질문</a></div>
      </div>
    </div>

    <!-- 활동기록 -->
    <div class="section">
      <h1>활동기록</h1>
      <div class="grid">
        <div class="file-card"><a href="Scrap_recruitList">⭐ 관심 채용 공고</a></div>
        <div class="file-card"><a href="job_application_list">📬 입사 지원 현황</a></div>
        <div class="file-card"><a href="myPost">🗒️ 내가 쓴 게시글</a></div>
      </div>
    </div>
			
		</div>
	</main>
</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>

</html>
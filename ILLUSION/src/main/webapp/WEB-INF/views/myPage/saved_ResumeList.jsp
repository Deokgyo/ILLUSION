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
	href="${pageContext.request.contextPath}/resources/css/mypage/saved_ResumeList.css">
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>

<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
	<div class="resume-list-container">
  <h2 class="resume-title">이력서 현황</h2>

  <div class="resume-list">
    <div class="resume-list-header">
      <span>선택</span>
      <span>이력서 제목</span>
      <span>관리</span>
    </div>

    <div class="resume-item">
      <input type="checkbox" />
      <div class="resume-info">
        <div class="title">따뜻한 마음을 가진 개발자</div>
        <div class="date">25.07.25</div>
      </div>
      <button class="edit-btn">수정</button>
    </div>

    <div class="resume-item">
      <input type="checkbox" />
      <div class="resume-info">
        <div class="title">다양한 경험이 있는 개발자</div>
        <div class="date">25.07.25</div>
      </div>
      <button class="edit-btn">수정</button>
    </div>

    <div class="resume-item">
      <input type="checkbox" />
      <div class="resume-info">
        <div class="title">뚝심있는 개발자</div>
        <div class="date">25.07.25</div>
      </div>
      <button class="edit-btn">수정</button>
    </div>

    <div class="resume-item">
      <input type="checkbox" />
      <div class="resume-info">
        <div class="title">친구 같은 개발자</div>
        <div class="date">25.07.25</div>
      </div>
      <button class="edit-btn">수정</button>
    </div>
  </div>

  <div class="resume-footer">
    <button class="delete-btn">삭제</button>
    <div class="pagination">
      &laquo;
      <span class="page active">1</span>
      <span class="page">2</span>
      <span class="page">3</span>
      <span class="page">4</span>
      <span class="page">5</span>
      &raquo;
    </div>
  </div>
</div>
</main>
</div>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>

</html>
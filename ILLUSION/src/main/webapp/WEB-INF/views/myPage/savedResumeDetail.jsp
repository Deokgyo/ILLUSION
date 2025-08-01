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
	href="${pageContext.request.contextPath}/resources/css/mypage/savedResumeDetail.css">
	<style type="text/css">
	.form-box {padding: 0px;}
	.
	</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
	<div class="page-title-header">
                <p class="header-text"><strong>마이페이지 </strong></p>
            </div>
	<div class="form-box">
	<div class="container">
    <div class="form-box">
    <div class="profile-card-1">
      <div class="profile-img">
        <img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
      </div>
      <div class="profile-info">
        <div class="name">ILLUSION</div>
        <div>생년월일 : 2000.07.26</div>
        <div>전화번호 : 010-1234-5676</div>
        <div>이메일 : illusion@naver.com</div>
        <div>주소 : 부산시 부산진구 삼한골든게이트 7층</div>
      </div>
    </div>
</div>
    <div class="section">
      <div class="section-title">학력</div>
      <table class="info-table">
        <thead>
          <tr>
            <th>학교명</th>
            <th>전공</th>
            <th>재학기간</th>
            <th>졸업여부</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>1</td>
          </tr>    
        </tbody>
      </table>
    </div>

    <div class="section">
      <div class="section-title">경력사항</div>
      <table class="info-table">
        <thead>
          <tr>
            <th>회사명</th>
            <th>직급</th>
            <th>담당업무</th>
            <th>근무기간</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>1</td>
            <td>1</td>
            <td>1</td>
            <td>1</td>
          </tr>
        </tbody>
      </table>
    </div>
	
  <div class="button-wrapper">
  <button class="list-btn">목록</button>

  <div class="right-buttons">
  
    <button class="edit-btn" onclick="location.href='resumeWrite';">수정</button>
    <button class="delete-btn">삭제</button>
  </div>
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
<script type="text/javascript">
document.getElementById(".edit-btn").onclick = function () {
  location.href = "resumeWrite";
}
</script>
</body>
</html>
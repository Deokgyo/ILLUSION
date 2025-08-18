<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자소서 현황</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/savedCLLlist.css">
<style type="text/css">
 .form-box {
   padding: 0px;
  }
</style>
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>

<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
 <div class="page-title-header">
        <p class="header-text"><strong>자소서 현황</strong> </p>
    </div>
    <div class="form-box">
	<div class="resume-list-container">

  <div class="resume-list">
    <div class="resume-list-header">
      <span style="margin:auto;">선택</span>
      <span>자기소개서 제목</span>
      <span style="margin:auto;">관리</span>
    </div>

	<c:forEach var="cl" items="${clList}">
  <div class="resume-item">
    <input type="checkbox" class="checkbox"/>
    <a href="savedCLDetail?cl_idx=${cl.cl_idx}&member_idx=1" class="resume-link">
      <div class="resume-info">
        <div class="title">${cl.cl_title}</div>
        <div class="date">${cl.generation_date}</div>
      </div>
    </a>
    <button class="edit-btn" onclick="location.href='coverletterCreate?cl_idx=${cl.cl_idx}';">수정</button>
  </div>
</c:forEach>
  <div class="resume-footer">
    <button class="delete-btn" onclick="confirm('삭제하시겠습니까?')">삭제</button>
    
  </div>
  
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
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
<script type="text/javascript">
document.getElementById(".edit-btn").onclick = function () {
  location.href = "coverletterCreate";
}
</script>
<script>
  document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('tr.row-link').forEach(function (row) {
      row.addEventListener('click', function (e) {
        // 북마크나 체크박스를 클릭할 땐 무시
        if (e.target.tagName === 'INPUT' || e.target.tagName === 'BUTTON') return;
        const href = row.getAttribute('data-href');
        if (href) window.location.href = href;
      });
    });
  });
</script>	
</html>
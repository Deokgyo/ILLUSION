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
	href="${pageContext.request.contextPath}/resources/css/mypage/job_application_list.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">


  <div class="interest-section">
    <div class="page-title-header">
                <p class="header-text"><strong>입사 지원 현황</strong></p>
            </div>
    <table class="interest-table">
      <thead>
        <tr>
          <th>선택</th>
          <th>공고 제목</th>
          <th>공고 상태</th>
          <th>등록일</th>
          <th>마감일</th>
          <th>관리</th>
        </tr>
      </thead>
      <tbody>
        <tr class="trcss">
          <td><input type="checkbox"class="checkbox"></td>
          <td>[삼성전자] 백엔드 경력 채용</td>
          <td>채용중</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td>🔖</td>
        </tr>
        <tr class="trcss">
          <td><input type="checkbox"class="checkbox"></td>
          <td>[네이버] 풀텍스 신입 채용</td>
          <td>채용중</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td>🔖</td>
        </tr>
        <tr class="trcss">
          <td><input type="checkbox"class="checkbox"></td>
          <td>[네이버] 풀텍스 신입 채용</td>
          <td>마감</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td>🔖</td>
        </tr>
        <tr class="trcss">
          <td><input type="checkbox"class="checkbox"></td>
          <td>[네이버] 풀텍스 신입 채용</td>
          <td>채용중</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td>🔖</td>
        </tr>
      </tbody>
    </table>
  
  </div>
  <button class="delete-btn" onclick="confirm('저장하시겠습니까?')">삭제</button>

    <div class="pagination">
      <a href="#">«</a>
      <a href="#">1</a>
      <a href="#">2</a>
      <a href="#">3</a>
      <a href="#">4</a>
      <a href="#">5</a>
      <a href="#">»</a>
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
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
	href="${pageContext.request.contextPath}/resources/css/mypage/Scrap_recruitList.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
	<main class="main-content">
	<div class="favorite-container">
	
<!--   <h2 class="favorite-title">관심공고 목록</h2> -->
<div class="page-title-header">
                <p class="header-text"><strong>관심공고 목록</strong></p>
            </div>
  <div class="table-box">
    <table class="favorite-table">
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
        <tr class="selected">
          <td><input type="checkbox" /></td>
          <td>[네이버] 플랫폼 신입 채용</td>
          <td>채용중<br>10명</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td><button class="bookmark active">🔖</button></td>
        </tr>
        <tr>
          <td><input type="checkbox" /></td>
          <td>[삼성전자] 백엔드 경력 채용</td>
          <td>채용중<br>10명</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td><button class="bookmark">🔖</button></td>
        </tr>
        <tr>
          <td><input type="checkbox" /></td>
          <td>[네이버] 플랫폼 신입 채용</td>
          <td>마감<br>10명</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td><button class="bookmark">🔖</button></td>
        </tr>
        <tr>
          <td><input type="checkbox" /></td>
          <td>[네이버] 플랫폼 신입 채용</td>
          <td>채용중<br>10명</td>
          <td>25.07.25</td>
          <td>25.08.01</td>
          <td><button class="bookmark">🔖</button></td>
        </tr>
      </tbody>
    </table>
  </div>

  <div class="action-buttons">
    <button class="delete-btn">삭제</button>
  </div>

  <div class="pagination">
    <span>«</span>
    <span class="page-number">1</span>
    <span class="page-number">2</span>
    <span class="page-number">3</span>
    <span class="page-number">4</span>
    <span class="page-number">5</span>
    <span>»</span>
  </div>
</div>
	
	
	
	</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
</body>
</html>
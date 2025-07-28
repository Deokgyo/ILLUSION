<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이력서 등록</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/resumeWrite.css">
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>
<body>
<div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
	
  <h2 class="form-title">이력서 제목</h2>
  <input type="text" class="form-input large" placeholder="가져 올 정보" />

  <!-- 학력 -->
  <section class="form-section">
    <h3>학력</h3>
    <div class="form-grid">
      <input type="text" placeholder="학교명" />
      <input type="text" placeholder="전공" />
      <select>
        <option>학위 선택</option>
        <option>학사</option>
        <option>석사</option>
        <option>박사</option>
      </select>
      <select>
        <option>상태 선택</option>
        <option>졸업</option>
        <option>재학</option>
        <option>중퇴</option>
      </select>
      <input type="text" placeholder="학점 (ex. 4.5)" />
      <div class="form-date-group">
        <input type="date" /> ~ <input type="date" />
      </div>
      <textarea placeholder="기타 상세, 수상경력, 프로젝트 등 (선택)"></textarea>
    </div>
  </section>

  <!-- 경력사항 -->
  <section class="form-section">
    <h3>경력사항</h3>
    <div class="form-grid">
      <input type="text" placeholder="회사명" />
      <input type="text" placeholder="직책" />
      <input type="date" placeholder="입사일" />
      <input type="date" placeholder="종료일" />
      <textarea placeholder="주요 담당 업무 및 성과"></textarea>
    </div>
    <button class="add-btn">+ 경력 추가하기</button>
  </section>

  <!-- 자격증 -->
  <section class="form-section">
    <h3>자격증 <span class="optional">(선택)</span></h3>
    <input type="text" class="form-input" placeholder="보유한 자격증을 입력하세요" />
  </section>

  <!-- 저장 -->
  <div class="submit-wrapper">
    <button class="save-btn">저장</button>
  </div>
</main>
</div>
</body>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
</html>
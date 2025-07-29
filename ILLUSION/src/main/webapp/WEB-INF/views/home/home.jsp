<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/test.css"> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/home.css">
<title>Home</title>
</head>
<body>

	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>


  <<section class="illusion-recruit">
  <div class="illusion-inner">
    <div class="illusion-gradient-bg">
      <h2>
        <span>ILLUSION이 채용의</span><br>
        <strong>시작을 바꿉니다</strong>
      </h2>
      <p class="illusion-desc">
        이력서부터 면접까지, 당신의 커리어를 스마트하게 설계하세요.
      </p>
    </div>
    <!-- 아래 부분은 배경 없이 계속 -->
    <div class="illusion-btns">
      <button type="button" class="btn-main">자기소개서 생성하기</button>
      <button type="button" class="btn-sub">채용정보 바로 가기</button>
    </div>
    <div class="illusion-links">
      <span>자기소개서 생성하기</span>
      <span>자기소개서 다듬기</span>
      <span>AI 면접 예상질문 생성</span>
      <span>취업상담 챗봇</span>
    </div>
  </div>
</section>















	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>

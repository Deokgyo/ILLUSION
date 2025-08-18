<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
	
	<%-- js 파일 --%>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/home/login.js"></script>
		
    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/login.css">
<title>Home</title>
</head>
<body>

	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
	
	<main>
		<section class="form-body">
			<article class="box-left">
				<div class="logo">
					<img alt="" src="./resources/image/logo2.png">
				</div>
			 	<div class="welcom">
					<h1>채용의 모든 솔루션, <span>일루션</span>에서 시작됩니다</h1>
			 	</div>
			</article>
			
			<div class="divider"></div>
			
			<form action="login" method="post">
				<article class="box-right">
					<div class="tab">
						<ul class="member_type">
							<li class="type active">
								개인 회원
							</li>
							<li class="type">
								기업 회원
							</li>
						</ul>
					</div>	
					<ul class="login-input">
						<li>
							<input type="text" placeholder="아이디" class="form-control">
						</li>
						<li>
							<input type="text" placeholder="비밀번호" class="form-control">								
						</li>								
						<li>
							<label><input type="checkbox"> 로그인 유지</label>	
							<label><input type="checkbox"> 아이디 저장</label>					
						</li>								
					</ul>
					<div class="login-btn">
						<input type="submit" class="btn-yellow" value="로그인" />
					</div>				
				<ul class="find">
					<li><a href="idPwFind">아이디 찾기</a></li>
					<li><a href="idPwFind">비밀번호 찾기</a></li>
				</ul>
				<div class="social-login">
					<div class="mini-divider"></div>
					<span> 소셜 계정으로 로그인</span>
					<div class="mini-divider"></div>
				</div>
				<ul class="social-logo">
					<li><a href="naver"><img src="./resources/image/naverLogin.png" alt=""></a>
					<li><a href="kakao"><img src="./resources/image/kakaoLogin.png" alt=""></a>
					<li><a href="google"><img src="./resources/image/googleLogin.png" alt=""></a>
				</ul>
				</article>
			</form>
		</section>
	
	</main>
	
	

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>

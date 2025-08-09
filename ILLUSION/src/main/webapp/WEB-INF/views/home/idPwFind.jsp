<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
	
	<%-- js 파일 --%>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/home/idPwFind.js"></script>
		
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/idPwFInd.css">
<title>Home</title>
</head>
<body>

	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
	
	<main>
		<section class="form-body">
			<form action="idFind" method="post">
				<article class="box-left">
					
					
					<div class="idFind-btn">
						<input type="submit" class="btn-yellow" value="아이디 찾기" />
					</div>		
				</article>
			</form>
				
			<div class="divider"></div>
			
			<form action="pwFind" method="post">
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
						</li>
						<li>
						</li>								
						<li>
						</li>								
					</ul>
					<div class="pwFind-btn">
						<input type="submit" class="btn-yellow" value="비밀번호 찾기" />
					</div>				
				</article>
			</form>
		</section>
	</main>
	
	

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>

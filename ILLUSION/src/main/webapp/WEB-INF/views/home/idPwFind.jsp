<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
	
	<%-- js 파일 --%>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/home/idPwFind.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/commonJs.js"></script>
		
    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/idPwFind.css">
<title>Home</title>
</head>
<body>

	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
	
	
	<main>
		<section class="form-body">
			<form action="idFind" method="post" id="idFindForm">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			
				<article class="box-left">
					<span class="tab">아이디 찾기</span>
					<ul class="pw-find-input">
						<li>
							<div class="input-wrap">
								<input name="member_name" class="input" type="text" placeholder="이름을 입력해주세요">
							</div>
						</li>
						<li>
							<div class="email-input">
								<div class="input-wrap">
									<input name="member_email" class="input" type="text" placeholder="이메일을 입력해주세요">
								</div>
								<input id="email-btn" type="button" class="vaildNum-send btn-yellow" value="인증번호 발송">
							</div>
						</li>								
						<li>
							<div class="input-wrap">
								<input name="" class="input" type="text" placeholder="인증 번호 입력">
							</div>
						</li>
						<li>
							<span>*인증번호가 틀립니다. 다시 확인 해주세요</span>
						</li>
					</ul>
					<div class="idFind-btn">
<!-- 						<input type="submit" class="btn-yellow" value="인증확인" /> -->
						<input id="finding-id" type="submit" class="btn-yellow" value="인증확인" />
					</div>		
					<div id="id-divider" class="divider"></div>
					<div class="result">
						<p>회원님의 아이디는</p>
						<h3>id...(디비에서 가져올 데이터)</h3>
						<p>입니다.</p>
					</div>
				</article>
			</form>
			
			<div class="divider"></div>
			
			<form action="pwFind" method="post">
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /> 
			
				<article class="box-right">
					<span class="tab">비밀번호 찾기</span>
					<ul class="pw-find-input">
						<li>
							<div class="input-wrap">
								<input name="" class="input" type="text" placeholder="아이디를 입력해주세요">
							</div>
						</li>
						<li>
							<div class="email-input">
								<div class="input-wrap">
									<input name="" class="input" type="text" placeholder="이메일을 입력해주세요">
								</div>
								<input type="button" class="vaildNum-send btn-yellow" value="인증번호 발송">
							</div>
						</li>								
						<li>
							<div class="input-wrap">
								<input name="" class="input" type="text" placeholder="인증 번호 입력">
							</div>
						</li>
						<li>
							<span>*인증번호가 틀립니다. 다시 확인 해주세요</span>
						</li>							
					</ul>
					<div class="pwFind-btn">
						<input type="submit" class="btn-yellow" value="인증확인" />
					</div>				
				</article>
			</form>
		</section>
	</main>
	
	

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>채용의 모든 솔루션, 일루션에서 시작됩니다</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">	
	

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/mypage/identityCheck.css">
</head>
<body>
	<div class="login-box">
	<input type="hidden" id="member_idx" value="${member.member_idx}">
	<input type="hidden" id="member_id" value="${member.member_id}">
	<input type="hidden" id="_csrf" value="${_csrf.token}"/>
<input type="hidden" id="_csrf_header" value="${_csrf.headerName}"/>
		<div class="logo">
			<img
				src="${pageContext.request.contextPath}/resources/image/logo.png"
				alt="이미지 설명" />
		</div>
<!-- 		<div class="user-info"> -->
<%-- 			${member.member_id}<br> <small>${member.member_email}</small> --%>
<!-- 		</div> -->
		<p>계속하려면 먼저 본인임을 인증하세요.</p>

		<div class="input-group">
			<input type="password" name="member_pw" id="member_pw" class="passwd" placeholder="비밀번호 입력" autocomplete="off">
		</div>
		<input type="button" class="check" value="인증" onclick="checkIdentity()">
	</div>
<script src="${pageContext.request.contextPath}/resources/js/myPage/identityCheck.js"></script>
</body>
</html>
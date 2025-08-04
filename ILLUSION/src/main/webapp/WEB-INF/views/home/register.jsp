<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>

<%-- js 파일 --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/home/register.js"></script>

<%-- 외부 라이브러리 CSS --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%-- 우리가 만든 CSS 파일들 --%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
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
	href="${pageContext.request.contextPath}/resources/css/home/login.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/home/register.css">
<title>register</title>
</head>
<body>

	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>


	<div class="register-container">
		<div class="register-header">
			<img src="./resources/image/logo2.png" alt="logo">
			<p>
				<strong>채용의 모든 출발선</strong>에서 시작합니다.
			</p>
		</div>

		<div class="form-tabs">
			<div class="form-tab active">개인 회원</div>
			<div class="form-tab">기업 회원</div>
		</div>

		<form>
			<div class="form-group">
				<label for="userId">아이디</label> <input type="text" id="userId"
					placeholder="4-20자리 / 영문, 숫자, 특수문자 '_' 허용">
			</div>
			<div class="form-group">
				<label for="pw">비밀번호</label> <input type="password" id="pw"
					placeholder="8-16자리 / 영문, 숫자, 특수문자 조합">
			</div>
			<div class="form-group">
				<label for="pw2">비밀번호 확인</label> <input type="password" id="pw2"
					placeholder="비밀번호를 다시 입력해주세요">
			</div>
			<div class="form-group">
				<label for="username">이름</label> <input type="text" id="username"
					placeholder="실명을 입력하세요">
			</div>
			<div class="form-group">
				<label for="gender">성별</label> <select id="gender">
					<option>선택</option>
					<option>남성</option>
					<option>여성</option>
				</select>
			</div>
			<div class="form-group">
				<label for="birth">생년월일</label> <input type="date" id="birth">
			</div>
			<div class="form-group">
				<label for="address">주소</label> <input type="text" id="address"
					placeholder="주소 입력">
				<button type="button">주소 찾기</button>
			</div>
			<div class="form-group">
				<label for="email">이메일 주소</label> <input type="text" id="email"
					placeholder="이메일 입력">
				<button type="button">인증 메일 발송</button>
			</div>
			<div class="form-group">
				<label for="code">인증번호 확인</label> <input type="text" id="code"
					placeholder="인증번호 입력">
				<button type="button">인증번호 확인</button>
			</div>
			<div class="checkbox-group">
				<label class="checkbox-label"><input type="checkbox"
					id="all-agree"> 전체 동의</label> <label class="checkbox-label"><input
					type="checkbox"> 이용 약관 동의 (필수)</label> <a class="more-view">내용
					보기</a>
				<div class="checkbox-details">여기에 약관 상세 내용 등</div>
				<label class="checkbox-label"><input type="checkbox">
					개인정보 처리방침 (필수)</label> <a class="more-view">내용 보기</a>
				<div class="checkbox-details">여기에 개인정보 내용 등</div>
				<label class="checkbox-label"><input type="checkbox">
					마케팅 동의 (선택)</label> <a class="more-view">내용 보기</a>
				<div class="checkbox-details">여기에 마케팅 내용 등</div>
			</div>
			<button type="submit" class="register-submit">회원가입</button>
		</form>
	</div>



	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
</body>
</html>

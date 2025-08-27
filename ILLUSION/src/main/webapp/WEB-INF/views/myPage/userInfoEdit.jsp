<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
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
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/userInfoEdit.css">
<style type="text/css">
.form-box {
	padding: 40px;
	padding-right: 10px;
}

.form-box {
	margin: auto;
	width: 960px;
	margin-bottom: 30px;
}

.page-title-header {
	width: 1000px;
	margin: auto;
	margin-bottom: 30px;
}
</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<div class="page-container">

		<%-- 	<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" /> --%>
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>회원정보 수정 </strong>
				</p>
			</div>

			<div class="form-box">
				<div class="member-info-container">
					<hr>
					<form action="userInfoEdit" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<input type="hidden" name="member_idx" value="${member.member_idx }">
							<input type="hidden" name="member_id" value="${member.member_id}">
						<table class="info-table">
							<tr>
								<th>프로필 이미지</th>
								<td>
									<div class="profile-img">
										<img
											src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
									</div>
								</td>
								<td class="right-align"><button type="button"
										class="edit-button">수정</button></td>
							</tr>
							<tr>
								<th>아이디</th>
								<td rowspan="1"><input type="text" name="member_id" class="bg-text" value="${member.member_id}" disabled="disabled"></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type="text" name="member_name" class="bg-text"
									value="${member.member_name}"></td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td><input type="text" name="resume_birth" class="bg-text"
									value="<fmt:formatDate value='${member.resume_birth}' pattern='yyyy-MM-dd' />" ></td>
							</tr>
							<tr>
								<th>성별</th>
									 <td>
										<input type="text" name="gender" class="bg-text"
									value="${member.gender}">
   								 	</td>
							</tr>
							<tr>
								<th>주소</th>
								<td><input type="text" name="address_name" class="bg-text"
									value="${member.address_name }" ></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type="text" name="member_email" class="bg-text"
									value="${member.member_email }"></td>
							</tr>
							<tr>
							
								<td class="right-align">
									<button type="submit" class="edit-button">수정</button>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<hr>
				<button class="passwd-button"
    				onclick="location.href='changePasswd?member_idx=${member.member_idx}';">비밀번호 수정</button>
				<button class="infodelete-button"
					onclick="location.href='deleteMember?member_idx=${member.member_idx}';">회원탈퇴</button>
			</div>

		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
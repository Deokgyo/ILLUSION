<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User_Info_Edit</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/User_Info_Edit.css">
<style type="text/css">
.form-box {
	padding: 0px;
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
					<table>
						<tr>
							<th>프로필 이미지</th>
							<td>
								<div class="profile-img">
									<img
										src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
								</div>
							</td>
							<td class="right-align"><button class="edit-button" onclick="confirm('저장하시겠습니까?')">수정</button></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td rowspan="1">itwillbs3030</td>

						</tr>
						<tr>
							<th>이름</th>
							<td>홍길동</td>
							<td class="right-align"><button class="edit-button">수정</button></td>
						</tr>
						<tr>
							<th>생년월일</th>
							<td>19980201</td>
							<td class="right-align"><button class="edit-button">수정</button></td>
						</tr>
						<tr>
							<th>성별</th>
							<td>남자</td>
							<td class="right-align"><button class="edit-button">수정</button></td>
						</tr>
						<tr>
							<th>주소</th>
							<td>부산시 사상구 사상로 3333 33</td>
							<td class="right-align"><button class="edit-button">수정</button></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>kingejrry@naver.com</td>
							<td class="right-align"><button class="edit-button">수정</button></td>
						</tr>
					</table>
				</div>
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
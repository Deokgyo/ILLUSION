<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/savedResumeDetail.css">
	<style type="text/css">
	.form-box {padding: 0px;
	box-shadow: var(--main-box-shadow);}
	</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<div class="page-container">

	<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>이력서 상세페이지</strong>
				</p>
			</div>
			<div class="form-box">
				<div class="container">
					<c:forEach var="resume" items="${resume }">
						<div class="form-box">
							<div class="profile-card-1">
								<div class="profile-img">
									<img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
								</div>
								<div class="profile-info">
									<div class="name">${resume.member_name}</div>
									<div>${resume.resume_birth}</div>
									<div>${resume.member_phone}</div>
									<div>${resume.member_email}</div>
									<div>${resume.address_name}${resume.address_num}</div>
								</div>
							</div>
						</div>
						<div class="section">
							<div class="section-title">학력</div>
							<table class="info-table">
								<thead>
									<tr>
										<th>학교명</th>
										<th>전공</th>
										<th>재학기간</th>
										<th>졸업여부</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${resume.school_name}</td>
										<td>${resume.major}</td>
										<td>${resume.enroll_date}~${resume.graduation_date}</td>
										<td>${resume.degree}</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="section">
							<div class="section-title">경력사항</div>
							<table class="info-table">
								<thead>
									<tr>
										<th>회사명</th>
										<th>직위</th>
										<th>직종</th>
										<th>경력</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${resume.company_name}</td>
										<td>${resume.position}</td>
										<td>${resume.occupation}</td>
										<td>${resume.experience}</td>
									</tr>
								</tbody>
							</table>
						</div>

						<div class="button-wrapper">
							<button class="list-btn" onclick="location.href='recruiterMainLogin';">목록</button>
						</div>
					</c:forEach>
				</div>
			</div>
		</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
<script type="text/javascript">
ntById(".list-btn").onclick = function () {
	  location.href = "recruiterMainLogin";
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 상세페이지</title>
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
.form-box {
	padding: 0px;
	box-shadow: var(- -main-box-shadow);
}
</style>
</head>
<body>
 <input type="hidden" name="member_idx" value="${member.member_idx}" />
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<div class="page-container">

		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
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
									<img
										src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
								</div>
								<div class="profile-info">
									<div class="name">${resume.member_name}</div>
									<div>${resume.resume_birth}</div>
									<div>${resume.member_phone}</div>
									<div>${resume.member_email}</div>
									<div>${resume.address_name}</div>
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
										<th>학위</th>
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
							<div class="section-title">추가 정보</div>
							<table class="info-table">
								<thead>
									<tr>
										<th>추가 정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${resume.additional_information != null ? resume.additional_information : "-"}</td>	
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
						<div class="section">
							<div class="section-title">담당 업무 및 성과</div>
							<table class="info-table">
								<thead>
									<tr>
										<th>담당 업무 및 성과</th>

									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${resume.responsibilities != null ? resume.responsibilities : "-"}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="section">
							<div class="section-title">자격증</div>
							<table class="info-table">
								<thead>
									<tr>
										<th>자격증명</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>${resume.certificate != null ? resume.certificate : "-"}</td>
									</tr>
								</tbody>
							</table>
						</div>
						


						<div class="button-wrapper">
							<button class="list-btn" onclick="location.href='savedResumeList';">목록</button>
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
	<script
		src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
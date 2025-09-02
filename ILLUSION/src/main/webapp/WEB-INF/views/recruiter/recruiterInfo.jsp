<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Info</title>
	<%-- 외부 css 파일 --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
	<%-- 내부 css 파일  --%>	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/recruiterInfo.css">
 </head>

<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>

	<div class="page-container">
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">회원정보 수정 </p>
			</div>
			<div class="form-box">
				<div id="companyTable"></div>
				<input type="file" id="logoFile" accept="image/*" style="display:none" />
				<div class="btnGroup d-flex flex-row justify-content-end">
					<button type="button" class="passwd-button"
			    				onclick="location.href='changePasswd?member_idx=${member_idx}';">비밀번호 수정</button>
					<button type="button" class="infodelete-button"
								onclick="location.href='deleteMember?member_idx=${member_idx}';">회원탈퇴</button>
				</div>
				</div>
				<input type="hidden" name="company_idx" value="${company_idx}">
		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<%-- js 파일 --%>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/commonJs.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/recruiter/recruiterInfo.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지</title>
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
		href="${pageContext.request.contextPath}/resources/css/mypage/myPage.css">
	<style type="text/css">
		 .form-box {
		    margin-bottom: 30px;
		    box-shadow: var(--main-box-shadow);
		  }
	</style>
	
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text"><strong>마이페이지 </strong></p>
	        </div>
			<div class="form-box">
				<div class="profile-box">
					<div class="profile-left">
				        <div class="profile-img">
						    <c:choose>
						        <c:when test="${not empty member.profile_picture_url}">
						            <img src="${pageContext.request.contextPath}/resources/upload/${member.profile_picture_url}" alt="프로필 이미지" id="profilePreview">
						        </c:when>
						        <c:otherwise>
						            <img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png" alt="기본 이미지" id="profilePreview">
						        </c:otherwise>
						    </c:choose>
							</div>
				        <button class="edit-btn" onclick="location.href='userInfoEdit'">회원정보수정</button>
					</div>
				    <div class="profile-info">
				          <div class="main-username">${member.member_name }${member.company_name }님</div>
				          <div class="email">${member.member_type }</div>
				          <div class="email">${member.member_email }</div>
				          <div class="token">
				          	<img src="${pageContext.request.contextPath}/resources/mypage_image/token.png">
				          	${member.token } 토큰
				          </div>
				    </div>
				    <div class="profile-right">
				    	<i class="fa-solid fa-file-lines gradient-icon1"></i>
						<%-- 	    <img src="${pageContext.request.contextPath}/resources/mypage_image/resume3.png">   --%>
				    	<div class="btn-yellow"><a href="resumeWrite"> 이력서 작성</a></div>
				    </div>
				    <div class="profile-right"> 
				    	<i class="fa-solid fa-coins gradient-icon1"></i>
				   		<div class="btn-yellow"><a href="tokenpay"> 토큰 충전</a></div>
					</div>
				</div>
			</div>
		    <!-- 저장한 파일 -->
		    <div class="form-box">
		    	<div class="save-box">
		    		<div class="section">
		      		<div class="main-username">저장한 파일</div>
		      			<div class="grid">
					        <div class="file-card"><a href="savedResumeList">📄 생성된 이력서</a></div>
					        <div class="file-card"><a href="savedCLList">📝 생성된 자기소개서</a></div>
<!-- 					        <div class="file-card"><a href="savedQuestionList">🎤 저장된 면접 예상 질문</a></div> -->
		      			</div>
		    		</div>
				</div>
		    	<!-- 활동기록 -->
		    	<div class="save-box">
				    <div class="section">
				    	<div class="main-username">활동기록</div>
				      	<div class="grid">
					        <div class="file-card"><a href="scraprecruitList">⭐ 관심 채용 공고</a></div>
					        <div class="file-card"><a href="jobapplicationlist">📬 입사 지원 현황</a></div>
					        <div class="file-card"><a href="myPost">🗒️ 내가 쓴 게시글</a></div>
				      	</div>
				    </div>
			    </div>
			</div>
		</main>
	</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>	
</body>
</html>
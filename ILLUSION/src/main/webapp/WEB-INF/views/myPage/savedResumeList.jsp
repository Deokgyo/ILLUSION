<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 현황</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/savedResumeList.css">
<style type="text/css">
.form-box {
	padding: 0px;
}
</style>
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>
<body>
	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>이력서 현황 </strong>
				</p>
			</div>
			<div class="form-box">
				<div class="resume-list-container">
					<div class="resume-list">
						<div class="resume-list-header">
							<span>선택</span> <span>이력서 제목</span> <span>이력서 생성일</span> <span>관리</span>
						</div>
						<c:forEach var="resume" items="${resumeList}">
							<div class="resume-item">
								<input type="checkbox" class="checkbox" value="${resume.resume_idx }">
								<div class="title">
									<a href="savedResumeDetail?resume_idx=${resume.resume_idx}" class="resume-link">
										${resume.resume_title}
									</a>
								</div>
								<div class="date">${resume.resume_create_at}</div>
								<button class="edit-btn"
									onclick="location.href='resumeWrite?resume_idx=${resume.resume_idx}'">수정</button>
							</div>
						</c:forEach>
					</div>
					<div class="resume-footer">
						<button class="delete-btn" id="delete-btn">삭제</button>
					</div>
					<nav class="pagination">
					    <!-- 이전 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum > 1}">
					    	<c:url var="pageUrl" value="savedResumeList">
					    		<c:param name="pageNum" value="1"></c:param>
					    	</c:url>
					    	<a href="${pageUrl}">&laquo;</a>
					    </c:if>
					
					    <!-- 페이지 번호 -->
					    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						    <c:url var="pageUrl" value="savedResumeList">
						        <c:param name="pageNum" value="${i}" />
						    </c:url>
						    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
						</c:forEach>
					
					    <!-- 다음 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
					    	<c:url var="pageUrl" value="savedResumeList">
					    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
					    	</c:url>
			    		    <a href="${pageUrl}">&raquo;</a>
					    </c:if>
					</nav>
				</div>
			</div>
		</main>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	
	<script>
    	window.contextPath = "${pageContext.request.contextPath}";
	</script>
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/myPage/myPageDelete.js"></script>
	<script>
	    $(function() {
	        initializeMultipleDelete({
	        	deleteButtonId: '#delete-btn',
	        	itemCheckboxClass: '.checkbox',
	        	deleteApiUrl: '/api/mypage/myResume/delete',
	        	paramName: 'idList',
	        	itemName: '이력서'
	        });
	    });
	</script>
	
</body>
</html>
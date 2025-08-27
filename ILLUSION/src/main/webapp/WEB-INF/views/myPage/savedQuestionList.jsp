<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>저장된 AI 면접 예상질문</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/savedQuestionList.css">
<style type="text/css">
.form-box {
	padding: 0px;
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
				<p class="header-text">
					<strong>저장된 AI 면접 예상질문 </strong>
				</p>
			</div>
			<div class="form-box">
				<div class="ai-interview-container">
					<!-- 질문 블록 -->
					<c:forEach var="quest" items="${QuestionList}" >
						<div class="question-block">
							<div class="question-header">
								<input type="checkbox" class="checkbox" value="${quest.question_idx}">
								<span class="question-icon">❓</span> <span class="question-text">${quest.question_text}</span>
							</div>

							<textarea class="user-answer" placeholder="내가 작성한 답변">${quest.answer_text}</textarea>

							<div class="ai-feedback">
								<img
									src="https://cdn-icons-png.flaticon.com/512/4712/4712104.png"
									alt="AI 아이콘" class="ai-icon" /> <span class="feedback-text">${quest.ai_feedback}</span>
							</div>
						</div>
						<!-- 동일 블록 반복 추가 -->
					</c:forEach>
					<div class="button-group">
						<button class="delete-btn" id="delete-btn">삭제</button>
					</div>
					<div class="add-question-wrap">
						<button class="add-question-btn">+ 예상질문 생성하기</button>
					</div>
					
					<nav class="pagination">
					    <!-- 이전 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum > 1}">
					    	<c:url var="pageUrl" value="savedQuestionList">
					    		<c:param name="pageNum" value="1"></c:param>
					    	</c:url>
					    	<a href="${pageUrl}">&laquo;</a>
					    </c:if>
					
					    <!-- 페이지 번호 -->
					    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						    <c:url var="pageUrl" value="savedQuestionList">
						        <c:param name="pageNum" value="${i}" />
						    </c:url>
						    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
						</c:forEach>
					
					    <!-- 다음 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
					    	<c:url var="pageUrl" value="savedQuestionList">
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
	        	deleteApiUrl: '/api/mypage/myQuestionList/delete',
	        	paramName: 'idList',
	        	itemName: '면접 질문'
	        });
	    });
	</script>
</body>
</html>
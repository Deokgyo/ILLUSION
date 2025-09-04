<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용의 모든 솔루션, 일루션에서 시작됩니다</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">	
	
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
	href="${pageContext.request.contextPath}/resources/css/top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/savedCLLlist.css">
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
					<strong>자기소개서 현황</strong>
				</p>
			</div>
			<div class="form-box">
				<div class="resume-list-container">
				<c:if test="${empty CLList}">
						    <div class="resume-list-header">
							<span>선택</span> <span>자기소개서 제목</span> <span>작성일자</span>
							<span>자소서 종류</span> <span>생성된 면접 질문</span></div>
						        <div class="resume-empty-box">
						            <p class="resume-text">저장된 자기소개서가 없습니다</p>
						            <button class="resume-btn" onclick="location.href='coverletterCreate'">
						                + 자기소개서 생성하기
						            </button>
						        </div>
						    </c:if>
	    				 <c:if test="${not empty CLList}">
					<div class="resume-list">
						<div class="resume-list-header">
							<span>선택</span> <span>자기소개서 제목</span> <span>작성일자</span>
							<span>자소서 종류</span> <span>생성된 면접 질문</span>
						</div>
						<c:forEach var="cl" items="${CLList }">
							<div class="resume-item">
								<input type="checkbox" class="checkbox" value="${cl.cl_idx }">
																<div class="title">
									<c:choose>
										<c:when test="${not empty cl.original_cl_idx && cl.original_cl_idx != 0}">
											<a href="coverletterResult?cl_idx=${cl.cl_idx }&original_cl_idx=${cl.original_cl_idx }">${cl.cl_title}</a>
										</c:when>
										<c:otherwise>
											<a href="coverletterResult?cl_idx=${cl.cl_idx }&original_cl_idx=${cl.cl_idx }">${cl.cl_title}</a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="date">${cl.generation_date}</div>
								<div class="date">${cl.cl_type}</div>
						        <c:choose>
						            <c:when test="${cl.question_count > 0}">
						                <a href="savedQuestionList?cl_idx=${cl.cl_idx}">
						                    <button class="delete-btn">확인하기</button>
						                </a>
						            </c:when>
						            <c:otherwise>
						                <button class="delete-btn disabled" disabled>질문 없음</button>
						            </c:otherwise>
						        </c:choose>
							</div>
						</c:forEach>
						<div class="resume-footer">
							<button class="delete-btn" id="delete-btn">삭제</button>
		
						</div>
		
						<nav class="pagination">
						    <!-- 이전 페이지 버튼 -->
						    <c:if test="${pageInfo.pageNum > 1}">
						    	<c:url var="pageUrl" value="savedCLList">
						    		<c:param name="pageNum" value="1"></c:param>
						    	</c:url>
						    	<a href="${pageUrl}">&laquo;</a>
						    </c:if>
						
						    <!-- 페이지 번호 -->
						    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
							    <c:url var="pageUrl" value="savedCLList">
							        <c:param name="pageNum" value="${i}" />
							    </c:url>
							    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
							</c:forEach>
						
						    <!-- 다음 페이지 버튼 -->
						    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
						    	<c:url var="pageUrl" value="savedCLList">
						    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
						    	</c:url>
				    		    <a href="${pageUrl}">&raquo;</a>
						    </c:if>
						</nav>
					</div>
					</c:if>
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
	        	deleteApiUrl: '/api/mypage/myCL/delete',
	        	paramName: 'idList',
	        	itemName: '자기소개서'
	        });
	    });
	</script>
</body>
</html>
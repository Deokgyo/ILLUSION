<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		href="${pageContext.request.contextPath}/resources/css/sidebar.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bottom.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/components.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/mypage/scraprecruitList.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="favorite-container">
				<div class="page-title-header">
					<p class="header-text">
						<strong>관심공고 목록</strong>
					</p>
				</div>
					<c:if test="${empty scrapList}">
					<div class="table-box">
					<table class="favorite-table">
						<thead>
							<tr>
								<th>선택</th>
								<th>공고 제목</th>
								<th>공고 상태</th>
								<th>등록일</th>
								<th>마감일</th>
							</tr>
						</thead>
						</table>
						</div>
				        <div class="resume-empty-box">
				            <p class="resume-text">저장된 관심공고가 없습니다</p>
				            <button class="resume-btn" onclick="location.href='recruitmentInfo'">
				                + 공고 보러가기
				            </button>
				        </div>
				    </c:if>
				<c:if test="${not empty scrapList}">
				<div class="table-box">
					<table class="favorite-table">
						<thead>
							<tr>
								<th>선택</th>
								<th>공고 제목</th>
								<th>공고 상태</th>
								<th>등록일</th>
								<th>마감일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="scrap" items="${scrapList }">
								<tbody>
									<tr class="row-link">
										<td><input type="checkbox" class="checkbox" value="${scrap.recruit_idx}"></td>
										<td><a href="recruitmentDetail?recruit_idx=${scrap.recruit_idx }">${scrap.recruit_subject }</a></td>
										<td>${scrap.rec_status }</td>
										<td>${scrap.startDateFormatted }</td>
										<td>${scrap.endDateFormatted }</td>
									</tr>	
								</tbody>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<div class="action-buttons">
					<button id="delete-btn" class="delete-btn">삭제</button>
				</div>

				<nav class="pagination">
					    <!-- 이전 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum > 1}">
					    	<c:url var="pageUrl" value="scraprecruitList">
					    		<c:param name="pageNum" value="1"></c:param>
					    	</c:url>
					    	<a href="${pageUrl}">&laquo;</a>
					    </c:if>
					
					    <!-- 페이지 번호 -->
					    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
						    <c:url var="pageUrl" value="scraprecruitList">
						        <c:param name="pageNum" value="${i}" />
						    </c:url>
						    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
						</c:forEach>
					
					    <!-- 다음 페이지 버튼 -->
					    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
					    	<c:url var="pageUrl" value="scraprecruitList">
					    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
					    	</c:url>
			    		    <a href="${pageUrl}">&raquo;</a>
					    </c:if>
					</nav>
				</c:if>
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
	        	deleteApiUrl: '/api/mypage/scraps/delete',
	        	paramName: 'idList',
	        	itemName: '스크랩'
	        });
	    });
	</script>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>입사 지원 현황</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/jobapplicationlist.css">
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
					<strong>입사 지원 현황</strong>
				</p>
			</div>
			<c:if test="${empty applyList}">
					<div class="table-box">
				<table class="interest-table">
					<thead>
						<tr>
							<th>선택</th>
							<th>공고 제목</th>
							<th>공고 상태</th>
							<th>등록일</th>
							<th>마감일</th>
							<th>지원 상태</th>
							<th>기업 열람</th>
						</tr>
					</thead>
						</table>
						</div>
				        <div class="resume-empty-box">
				            <p class="resume-text">등록된 지원내역이 없습니다</p>
				            <button class="resume-btn" onclick="location.href='recruitmentInfo'">
				                + 지원 하러가기
				            </button>
				        </div>
				    </c:if>
				<c:if test="${not empty applyList}">
			<div class="interest-section">
				<table class="interest-table">
					<thead>
						<tr>
							<th>선택</th>
							<th>공고 제목</th>
							<th>공고 상태</th>
							<th>등록일</th>
							<th>마감일</th>
							<th>지원 상태</th>
							<th>기업 열람</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="app" items="${applyList }">
							<tr class="trcss">
								<td><input type="checkbox" class="checkbox" value="${app.apply_idx }"></td>
								<td><a href="recruitmentDetail?recruit_idx=${app.recruit_idx }">${app.recruit_subject }</a></td>
								<td>${app.rec_status }</td>
								<td>${app.applyDateFormatted }</td>
								<td>${app.endDateFormatted }</td>
								<td>${app.rec_status }</td>
								<td>${app.is_viewed }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
			<button id="delete-btn" class="delete-btn">삭제</button>

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
	        	deleteApiUrl: '/api/mypage/applys/delete',
	        	paramName: 'idList',
	        	itemName: '지원 내역'
	        });
	    });
	</script>
</body>
</html>
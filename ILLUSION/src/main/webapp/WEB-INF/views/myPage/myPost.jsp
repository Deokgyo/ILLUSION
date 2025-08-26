<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 글</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/myPost.css">
</head>
<style type="text/css">
.form-box {
	padding: 0px;
}
</style>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>내가 쓴 게시물</strong>
				</p>
			</div>
			<div class="community-search mt-4">
				<div class="filter-tags">
					<c:forEach var="category" items="${categoryList}">
						<c:url var="filterUrl" value="myPost">
							<c:param name="categoryCode" value="${category.code}" />
						</c:url>
						<a href="${filterUrl}"
							class="tag-item ${empty param.categoryCode && category.code eq 'BRD001' 
					                       || param.categoryCode eq category.code ? 'active' : ''}">
							${category.code_name} </a>
					</c:forEach>
				</div>
			</div>

			<div class="board-list">
				<div class="board-header">
					<span>선택</span> <span>게시글 유형</span> <span>게시물 제목</span> <span>조회수</span>
					<span>작성일자</span> <span>관리</span>
				</div>

				<!-- 게시물 항목 1 -->
				<c:forEach var="board" items="${myPostList}">
					<div class="board-item">
						<input type="checkbox" class="checkbox"
							value="${board.board_idx }">
						<div class="post-type">${board.board_type }</div>
						<div class="post-title">
							<a href="communityDetail?board_idx=${board.board_idx}">
								${board.board_title} [${board.cmt_count }] </a>
						</div>
						<div class="post-type">${board.board_viewcnt }</div>
						<div class="post-type">${board.board_create_at }</div>
						<div class="post-actions">
							<button class="edit-btn"
								onclick="location.href='communityModify?board_idx=${board.board_idx}';">수정</button>
						</div>
					</div>
				</c:forEach>
			</div>
			<button id="delete-btn" class="delete-btn">삭제</button>

			<nav class="pagination">
				<!-- 이전 페이지 버튼 -->
				<c:if test="${pageInfo.pageNum > 1}">
					<c:url var="pageUrl" value="myPost">
						<c:param name="pageNum" value="1"></c:param>
					</c:url>
					<a href="${pageUrl}">&laquo;</a>
				</c:if>

				<!-- 페이지 번호 -->
				<c:forEach var="i" begin="${pageInfo.startPage}"
					end="${pageInfo.endPage}">
					<c:url var="pageUrl" value="myPost">
						<c:param name="pageNum" value="${i}" />
					</c:url>
					<a href="${pageUrl}"
						class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
				</c:forEach>

				<!-- 다음 페이지 버튼 -->
				<c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
					<c:url var="pageUrl" value="myPost">
						<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
					</c:url>
					<a href="${pageUrl}">&raquo;</a>
				</c:if>
			</nav>
		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>

	<script>
		window.contextPath = "${pageContext.request.contextPath}";
	</script>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/community/communityMain.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/myPage/myPageDelete.js"></script>
	<script>
		$(function() {
			initializeMultipleDelete({
				deleteButtonId : '#delete-btn',
				itemCheckboxClass : '.checkbox',
				deleteApiUrl : '/api/mypage/myPost/delete',
				paramName : 'idList',
				itemName : '내가 쓴 글'
			});
		});
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
			<!-- 여기에 메인내용 -->
				<div class="page-title-header">
                <p class="header-text"><strong>내가 쓴 게시물</strong></p>
            </div>
			<div class="form-box">
			<div class="board-container">

				<div class="board-filter">
					<select>
						<option>게시글 유형</option>
						<option>자유게시판</option>
						<option>Q&A</option>
						<option>후기</option>
					</select>
				</div>

				<div class="board-list">
					<div class="board-header">
						<span>선택</span> <span>게시물 제목</span> <span>관리</span>
					</div>

					<!-- 게시물 항목 1 -->
					<c:forEach var="board" items="${boardList}">
					<div class="board-item">
						<input type="checkbox"class="checkbox" />
						<a href="communityDetail?board_idx=${board.board_idx}&member_idx=1">
						<div class="post-info">
							<div class="post-title">${board.board_title}</div>
							<div class="meta">
								<span>${board.board_create_at }</span> <span>💬${board.cmt_count }</span> <span>조회수${board.board_viewcnt } </span>
							</div>
							
						</div>
						</a>
						<div class="post-actions">
							<button class="edit-btn"onclick="location.href='communityModify?board_idx=${board.board_idx}';">수정</button>
							<button class="delete-btn" onclick="confirm('삭제 하시겠습니까?')">삭제</button>
						</div>
					</div>
					</c:forEach>
					
					

					<!-- 나머지 항목 동일하게 추가 -->
				</div>

				<div class="board-pagination">
					&laquo; <span class="page active">1</span> <span class="page">2</span>
					<span class="page">3</span> <span class="page">4</span> <span
						class="page">5</span> &raquo;
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
<script type="text/javascript">
document.getElementById(".edit-btn").onclick = function () {
  location.href = "communityWrite";
}
</script>
</body>
</html>
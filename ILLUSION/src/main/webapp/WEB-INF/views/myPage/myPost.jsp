<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>

	<div class="page-container">

		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<!-- 여기에 메인내용 -->
			<div class="board-container">
				<div class="page-title-header">
                <p class="header-text"><strong>내가 쓴 게시물</strong></p>
            </div>

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
						<span>선택</span> <span>게시물 제목</span> <span>작성일</span> <span>관리</span>
					</div>

					<!-- 게시물 항목 1 -->
					<div class="board-item">
						<input type="checkbox" />
						<div class="post-info">
							<div class="post-title">아이템 합격 하신 분</div>
							<div class="meta">
								<span>25.07.25</span> <span>💬 3</span> <span>조회수 17</span>
							</div>
						</div>
						<div class="post-actions">
							<button class="edit-btn">수정</button>
							<button class="delete-btn">삭제</button>
						</div>
					</div>

					<!-- 게시물 항목 2 -->
					<div class="board-item">
						<input type="checkbox" />
						<div class="post-info">
							<div class="post-title">자소서 합격 팁 좀 알려주세요</div>
							<div class="meta">
								<span>25.07.25</span> <span>💬 3</span> <span>조회수 17</span>
							</div>
						</div>
						<div class="post-actions">
							<button class="edit-btn">수정</button>
							<button class="delete-btn">삭제</button>
						</div>
					</div>

					<!-- 나머지 항목 동일하게 추가 -->
				</div>

				<div class="board-pagination">
					&laquo; <span class="page active">1</span> <span class="page">2</span>
					<span class="page">3</span> <span class="page">4</span> <span
						class="page">5</span> &raquo;
				</div>
			</div>



		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>
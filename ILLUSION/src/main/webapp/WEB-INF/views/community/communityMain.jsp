<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityMain.css">
    
    <style type="text/css">
    	.post-author img {
			width: 40px;
		}

		.post-author {
			display: flex;
			flex-direction: column;
		}
		
		hr {
  background-color: #fff;
  padding: 0;
  margin-top: 10px;
  margin-bottom: 30px;
 
}
		
		hr.hr-11 {
  border: 0;
  border-top: 1px dashed #8c8c8c;
  border-bottom: 1px dashed #fff;
}
		
    </style>
</head>
<body>
	<header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">

			<div class="page-title-header">
				<p class="header-text">
					<strong>커뮤니티</strong>
				</p>
			</div>
			<!-- 검색 및 필터 영역 -->
			<div class="community-search mt-4">
				<div class="search-input-group">
					<input type="text" placeholder="관심있는 내용을 검색해 보세요">
					<button>
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
				<div class="filter-tags">
					<div class="tag-item active">전체</div>
					<div class="tag-item">자소서 팁</div>
					<div class="tag-item">면접 팁</div>
					<div class="tag-item">면접 후기</div>
					<div class="tag-item">합격 후기</div>
				</div>
			</div>
			
			<!-- 정렬 및 글쓰기 버튼 -->
			<div class="board-actions">
				<div class="sort-options">
					<ul>
						<li class="active"><a>인기순</a></li>
						<li><a>최신순</a></li>
					</ul>
				</div>
				<a href="communityWrite" class="btn btn-yellow"><i
					class="fa-regular fa-pen-to-square"></i> 글쓰기</a>
			</div>
			<hr class="hr-11">

			<!-- 게시글 목록 -->
			<div class="post-list">
				<div class="post-item">
					<div class="post-author">
						<img src="${pageContext.request.contextPath}/resources/image/logop.png" />
						<span class="author-name">admin</span>
					</div>
					<div class="post-content">
						<div class="post-title-wrapper">
							<p class="post-title">
								<a href="communityDetail">자기소개서 처음 쓰는데 어떤 방식으로 쓰면 좋을까요?</a>
							</p>
						</div>
						<div class="post-meta">
							<span class="meta-item"><i
								class="fa-regular fa-comment-dots"></i> 3</span> <span
								class="meta-item"><i class="fa-regular fa-eye"></i> 조회수 17</span>
						</div>
					</div>
				</div>

				<div class="post-item">
					<div class="post-author">
						<img src="${pageContext.request.contextPath}/resources/image/logop.png" />
						<span class="author-name">admin</span>
					</div>
					<div class="post-content">
						<div class="post-title-wrapper">
							<p class="post-title">
								<a href="communityDetail">면접 보러 가는데 주의사항 있을까요?</a>
							</p>
						</div>
						<div class="post-meta">
							<span class="meta-item"><i
								class="fa-regular fa-comment-dots"></i> 3</span> <span
								class="meta-item"><i class="fa-regular fa-eye"></i> 조회수 17</span>
						</div>
					</div>
				</div>

				<div class="post-item">
					<div class="post-author">
						<img src="${pageContext.request.contextPath}/resources/image/logop.png" />
						<span class="author-name">admin</span>
					</div>
					<div class="post-content">
						<div class="post-title-wrapper">
							<p class="post-title">
								<a href="communityDetail">아이티윌 합격 하신 분 계신가요?</a>
							</p>
						</div>
						<div class="post-meta">
							<span class="meta-item">
							<i class="fa-regular fa-comment-dots"></i> 3</span> 
							<span class="meta-item"><i class="fa-regular fa-eye"></i> 조회수 17</span>
						</div>
					</div>
				</div>
			</div>

			<!-- 페이지네이션 -->
			<nav class="pagination">
				<a href="#" class="page-arrow">&laquo;</a> <a href="#"
					class="active">1</a> <a href="#">2</a> <a href="#">3</a> <a
					href="#">4</a> <a href="#">5</a> <a href="#" class="page-arrow">&raquo;</a>
			</nav>
		</main>
	</div>

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/community/communityMain.js"></script>
</body>
</html>
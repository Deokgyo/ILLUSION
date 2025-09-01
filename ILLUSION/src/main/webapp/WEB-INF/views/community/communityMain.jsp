<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
					<input type="text" id="searchKeyword" name="searchKeyword" value="${searchKeyword}" placeholder="제목과 내용에서 검색해 보세요">
					<button type="button" id="searchBtn">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</div>
				<div class="filter-tags">
					<c:forEach var="category" items="${categoryList}">
					    <c:url var="filterUrl" value="communityMain">
					        <c:param name="categoryCode" value="${category.code}" />
					        <c:if test="${not empty sort}">
					            <c:param name="sort" value="${sort}" />
					        </c:if>
					        <c:if test="${not empty searchKeyword}">
					            <c:param name="searchKeyword" value="${searchKeyword}" />
					        </c:if>
					    </c:url>
					    <a href="${filterUrl}"
					       class="tag-item ${empty param.categoryCode && category.code eq 'BRD001' 
					                       || param.categoryCode eq category.code ? 'active' : ''}">
					        ${category.code_name}
					    </a>
					</c:forEach>
				</div>
			</div>
			
			
			<!-- 정렬 및 글쓰기 버튼 -->
			<div class="board-actions">
			    <div class="sort-options">
			        <ul>
			            <c:url var="latestSortUrl" value="communityMain">
			                <c:if test="${not empty selectedCategoryCode}">
			                    <c:param name="categoryCode" value="${selectedCategoryCode}" />
			                </c:if>
			                <c:param name="sort" value="latest" />
			                <c:if test="${not empty searchKeyword}">
			                    <c:param name="searchKeyword" value="${searchKeyword}" />
			                </c:if>
			            </c:url>
			
			            <li class="${empty sort or sort == 'latest' ? 'active' : ''}">
			                <a href="${latestSortUrl}">최신순</a>
			            </li>
			            
			            <c:url var="viewsSortUrl" value="communityMain">
			                <c:if test="${not empty selectedCategoryCode}">
			                    <c:param name="categoryCode" value="${selectedCategoryCode}" />
			                </c:if>
			                <c:param name="sort" value="views" />
			                <c:if test="${not empty searchKeyword}">
			                    <c:param name="searchKeyword" value="${searchKeyword}" />
			                </c:if>
			            </c:url>
			            
			            <li class="${sort == 'views' ? 'active' : ''}">
			                <a href="${viewsSortUrl}">조회순</a>
			            </li>
			        </ul>
			    </div>
			    <sec:authorize access="isAuthenticated()">
				    <a href="communityWrite" class="btn btn-yellow">
				        <i class="fa-regular fa-pen-to-square"></i> 글쓰기
				    </a>
			    </sec:authorize>
			    <sec:authorize access="isAnonymous()">
				    <a href="${pageContext.request.contextPath}/login" class="btn btn-yellow">
				        <i class="fa-regular fa-pen-to-square"></i> 로그인하고 게시글 작성하기
				    </a>
			    </sec:authorize>
			</div>
			<hr class="hr-11">

			<!-- 게시글 목록 -->
			<div class="post-list">
				<c:forEach var="board" items="${boardList}">
					<div class="post-item">
						<div class="post-author">
							<c:choose>
						        <c:when test="${not empty board.profile_picture_url}">
						            <img src="${pageContext.request.contextPath}/resources/upload/${board.profile_picture_url}" alt="프로필 이미지" id="profilePreview">
						        </c:when>
						        <c:otherwise>
          							<img src="${pageContext.request.contextPath}/resources/image/logop.png" />
						        </c:otherwise>
						    </c:choose>
											<!-- * 회원테이블과 조인 -->
							<span class="author-name">${board.member_id }</span> 
						</div>
						<div class="post-content">
							<div class="post-title-wrapper">
								<p class="post-title">
									<a href="communityDetail?board_idx=${board.board_idx }">${board.board_title }</a>
								</p>
							</div>
							<div class="post-meta">
								<span class="meta-item"><i class="fa-regular fa-comment-dots"></i>댓글 ${board.cmt_count }&nbsp; |</span> 
								<span class="meta-item"><i class="fa-regular fa-eye"></i>조회수 ${board.board_viewcnt }&nbsp; |</span>
								<span class="meta-item">작성일 ${board.board_create_at }</span>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>

			<!-- 페이지네이션 -->
			<nav class="pagination">
			    <!-- 이전 페이지 버튼 -->
			    <c:if test="${pageInfo.pageNum > 1}">
			    	<c:url var="pageUrl" value="communityMain">
			    		<c:param name="pageNum" value="1"></c:param>
			    		    <c:if test='${not empty selectedCategoryCode}'>
			    		    	<c:param name="categoryCode" value="${selectedCategoryCode}"></c:param>
			    		    </c:if>
			    		    <c:if test='${not empty sort}'>
			    		    	<c:param name="sort" value="${sort}"></c:param>
			    		    </c:if>
			    		    <c:if test='${not empty searchKeyword}'>
			    		    	<c:param name="searchKeyword" value="${searchKeyword}"></c:param>
			    		    </c:if>
			    	</c:url>
			    	<a href="${pageUrl}">&laquo;</a>
			    </c:if>
			
			    <!-- 페이지 번호 -->
			    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
				    <c:url var="pageUrl" value="communityMain">
				        <c:param name="pageNum" value="${i}" />
				        <c:if test="${not empty selectedCategoryCode}">
				            <c:param name="categoryCode" value="${selectedCategoryCode}" />
				        </c:if>
				        <c:if test="${not empty sort}">
				            <c:param name="sort" value="${sort}" />
				        </c:if>
				        <c:if test="${not empty searchKeyword}">
				            <c:param name="searchKeyword" value="${searchKeyword}" />
				        </c:if>
				    </c:url>
				    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
				</c:forEach>
			
			    <!-- 다음 페이지 버튼 -->
			    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}">
			    	<c:url var="pageUrl" value="communityMain">
			    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
			    		    <c:if test='${not empty selectedCategoryCode}'>
			    		    	<c:param name="categoryCode" value="${selectedCategoryCode}"></c:param>
			    		    </c:if>
			    		    <c:if test='${not empty sort}'>
			    		    	<c:param name="sort" value="${sort}"></c:param>
			    		    </c:if>
			    		    <c:if test='${not empty searchKeyword}'>
			    		    	<c:param name="searchKeyword" value="${searchKeyword}"></c:param>
			    		    </c:if>
			    	</c:url>
	    		    <a href="${pageUrl}">&raquo;</a>
			    </c:if>
			</nav>
			</main>
		</div>

	<footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script	src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/community/communityMain.js"></script>
</body>
</html>
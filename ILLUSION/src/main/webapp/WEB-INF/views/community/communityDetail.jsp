<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용의 모든 솔루션, 일루션에서 시작됩니다</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">	
	

   	<%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityDetail.css">
    
    <style type="text/css">
    	.post-author-profile img{
    		width: 50px;
    	}
    </style>
</head>
<body>
	<c:set var="loginUser" value="${sessionScope.loginUser}" />
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>
    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            
            <div class="page-title-header">
                <p class="header-text"><strong>커뮤니티</strong></p>
            </div>

            <div class="post-detail-container">
                <!-- 게시글 영역 -->
                <div class="post-header">
                    <div class="post-author-profile">
                    	<c:choose>
					        <c:when test="${not empty board.profile_picture_url}">
						            <img src="${pageContext.request.contextPath}/resources/upload/${board.profile_picture_url}" alt="프로필 이미지" id="profilePreview">
					        </c:when>
					        <c:otherwise>
         							<img src="${pageContext.request.contextPath}/resources/image/logop.png" />
					        </c:otherwise>
					    </c:choose>
                   </div>

                    <div class="post-title-area">
                        <div class="author-name">${board.member_id }</div>
                        <h2 class="post-title">${board.board_title }</h2>
                    </div>
                    <div class="post-date">작성일&nbsp;|  ${board.board_create_at }</div>
                </div>
                
                <div class="divider"></div>

                <div class="post-body">${board.board_content }</div>
                
				<div class="post-btn">
				    <div class="post-btn">
					    <div class="post-actions">
					        <!-- 작성자 또는 관리자만 수정/삭제 가능 -->
					        <c:if test="${loginUser.member_id eq board.member_id}">
					            <a href="communityModify?board_idx=${board.board_idx}" class="btn btn-yellow">수정</a>
					            <button id="delete_btn" class="btn btn-yellow">삭제</button>
					        </c:if>
					        <!-- 관리자는 삭제만 가능 (수정은 불가) -->
					        <c:if test="${loginUser.member_id ne board.member_id and loginUser.member_type eq 'MEM001'}">
					            <button id="admin_delete_btn" class="btn btn-yellow">관리자 삭제</button>
					        </c:if>
					    </div>
					</div>
				</div>
                <div class="post-footer">
                    <div class="post-meta-info">
                        <span><i class="fa-regular fa-eye"></i> ${board.board_viewcnt }</span>
                    </div>
                </div>

                <!-- 댓글 영역 -->
				<div class="comment-section">	
				    <div class="comment-header" id="cmt_count"></div>
				    
				    <!-- 로그인 사용자만 댓글 작성 가능 -->
				    
				    <c:choose>
				    	<c:when test="${not empty loginUser}">
				    		<form action="cmtWrite" method="POST" id="cmt_form">
					            <div class="comment-form">
					            	<input type="hidden" id="board_idx" name="board_idx" value="${param.board_idx }">
					                <textarea id="cmt_textarea" name="comment" class="form-control" placeholder="댓글을 입력해 주세요"></textarea>
					                <button type="submit" id="cmt_regist" class="btn btn-yellow">등록</button>
					            </div>
					        </form>	
				    	</c:when>
				    	<c:otherwise>
				    		<form action="cmtWrite" method="POST" id="cmt_form">
				            <div class="comment-form">
				            	<input type="hidden" id="board_idx" name="board_idx" value="${param.board_idx }">
				                <textarea id="cmt_textarea" name="comment" class="form-control" placeholder="로그인 후 댓글 작성 가능"></textarea>
				            </div>
				        </form>
				    	</c:otherwise>
				    </c:choose>
				    
				    
				    <!-- 댓글 리스트 -->
				    <div class="comment-list"></div>
				</div>

                <!-- 페이지네이션 -->
                <nav class="pagination"></nav>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/community/communityDetail.js"></script>
    <script>
    	const board_idx = "${param.board_idx}";
	    const loginId = "${not empty loginUser ? loginUser.member_id : ''}";
	    const isAdmin = "${not empty loginUser ? (loginUser.member_type eq 'MEM001' ? 'true' : 'false') : 'false'}";
	    const contextPath = "${pageContext.request.contextPath}";
	    window.addEventListener('pageshow', function (e) {
		    // bfcache에서 복원된 경우 또는 back/forward 내비게이션이면 새로고침
		    if (e.persisted || (performance.getEntriesByType && performance.getEntriesByType('navigation')[0]?.type === 'back_forward')) {
		      location.reload();
		    }
		  });
	</script>
</body>
</html>
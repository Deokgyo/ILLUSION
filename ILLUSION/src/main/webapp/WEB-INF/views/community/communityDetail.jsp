<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 게시글</title>

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
<!--                     <div class="post-author-profile"><i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i></div> -->
                    <div class="post-author-profile"><img src="${pageContext.request.contextPath}/resources/image/logop.png"/></div>

                    <div class="post-title-area">
                        <div class="author-name">admin</div>
                        <h2 class="post-title">아이티윌 합격 하신 분 계신가요?</h2>
                    </div>
                    <div class="post-date">2025년 7월 23일</div>
                </div>
                
                <div class="divider"></div>

                <div class="post-body">
                    안녕하세요. 아이티윌 면접보고 온 사람입니다.<br>
                    면접 후 일주일 이내 연락을 준다고 했는데 아직 연락을 못 받아서요 합격 연락 오신 분 있으신가요?
                </div>
                
				<div class="post-btn">
					    <div class="post-actions">
                        <!-- 작성자 본인일 경우 노출 -->
                        <a href="communityModify" class="btn btn-yellow">수정</a>
                        <a href="#" class="btn btn-yellow">삭제</a>
                    </div>
				</div>
                <div class="post-footer">
                    <div class="post-meta-info">
                        <span><i class="fa-regular fa-comment-dots"></i> 3</span>
                        <span><i class="fa-regular fa-eye"></i> 조회수 17</span>
                    </div>
                </div>
                <!--// 게시글 영역 -->

                <!-- 댓글 영역 -->
                <div class="comment-section">
                    <div class="comment-header">댓글 1</div>
                    <div class="comment-form">
                        <textarea id="cmt_textarea" class="form-control" placeholder="댓글을 입력해 주세요"></textarea>
                        <button id="cmt_regist" class="btn btn-yellow">등록</button>
                    </div>
                    
                    <div class="comment-list">
                        <div class="comment-item">
                            <div class="comment-author-profile"><i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i></div>
                            <div class="comment-content">
                                <div class="author-name">ioi</div>
                                <p class="comment-text">저도 아직 못 받았어요ㅠ</p>
                            </div>
                        </div>
                    </div>
                    
                </div>

                <!-- 페이지네이션 -->
                <nav class="pagination">
		            <a href="#" class="page-arrow">&laquo;</a>
		            <a href="#" class="active">1</a>
		            <a href="#">2</a>
		            <a href="#">3</a>
		            <a href="#">4</a>
		            <a href="#">5</a>
		            <a href="#" class="page-arrow">&raquo;</a>
	       		</nav>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/community/communityDetail.js"></script> 
</body>
</html>
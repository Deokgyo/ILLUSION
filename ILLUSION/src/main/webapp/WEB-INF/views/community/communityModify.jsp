
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>커뮤니티 글 수정</title>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community/communityWrite.css">
    

</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            
            <div class="page-title-header">
                <p class="header-text"><strong>커뮤니티</strong></p>
            </div>

          <div class="form-box write-form-box">
		    <form action="/community/write.do" method="post">
		    
		        <!-- 제목 섹션 -->
		        <div class="write-form-section">
		            <div class="section-header">
		                <i class="icon fa-regular fa-pen-to-square"></i>
		                <h3 class="title">제목</h3>
		            </div>
		            <input type="text" name="title" class="form-control title-input" placeholder="제목을 입력해주세요" required />
		        </div>
		
		        <!-- 카테고리 섹션 -->
		        <div class="write-form-section">
		            <div class="section-header">
		                <i class="icon fa-regular fa-square-check"></i>
		                <h3 class="title">카테고리</h3>
		            </div>
		            <select name="category" class="form-select category-select" required>
		                <option value="" disabled selected>카테고리 선택</option>
		                <option value="자소서 팁">자소서 팁</option>
		                <option value="면접 후기">면접 후기</option>
		                <option value="합격 후기">합격 후기</option>
		                <option value="면접 팁">면접 팁</option>
		                <option value="공지사항">공지사항</option>
		            </select>
		        </div>
		
		        <!-- 내용 작성 섹션 -->
		        <div class="write-form-section">
		            <div class="section-header">
		                <i class="icon fa-solid fa-list"></i> 
		                <h3 class="title">내용 작성</h3>
		            </div>
		            <textarea name="content" class="form-control content-textarea" placeholder="내용을 입력해 주세요" required></textarea>
		        </div>
		
		        <!-- 하단 버튼 영역 -->
		        <div class="form-actions">
		            <button type="button" class="btn btn-yellow" onclick="history.back()">취소</button>
		            <button type="submit" class="btn btn-yellow">수정하기</button>
		        </div>
		
		    </form>
		</div>

        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
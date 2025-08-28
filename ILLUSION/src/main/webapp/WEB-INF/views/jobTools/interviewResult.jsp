<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI 면접 예상질문 결과</title>

	<%-- 외부 라이브러리 CSS --%>
 	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/interviewResult.css">
    <style type="text/css">
    	.feedback-header img {
			width: 30px;
		}
    </style> 
</head>
<body>
    <jsp:include page="/WEB-INF/views/inc/top.jsp" />

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            
            <!-- 1. 공통 페이지 헤더 사용 -->
            <div class="page-title-header">
                <p class="header-text"><strong>AI 면접 예상질문 결과</strong></p>
            </div>

	            <div class="question-list-container">
            	<c:forEach var="result" items="${interviewResultList}" varStatus="st">
	                <div class="question-card">
	                    <div class="card-header">
	                        <div class="question-title">
	                            <span class="q-icon">Q</span>
	                            <span class="q-text">${result.question_text}</span>
	                            <span class="question_idx" style="display:none;">${result.question_idx}</span>
	                        </div>
	                        <div class="card-actions">
	                            <button class="btn btn-yellow save">저장</button>
	                            <button class="btn btn-yellow">복사</button>
	                        </div>
	                    </div>
	                    <div class="card-body">
	                        <textarea placeholder="이 질문에 대한 답변을 작성해 주세요"></textarea>
	                    </div>
	                    <div class="card-footer">
	                        <button class="btn btn-yellow submit">답변 제출하기</button>
	                    </div>
	                    <div class="feedback-box">
	                        <div class="feedback-header">
	                        	<img alt="" src="${pageContext.request.contextPath}/resources/image/home/Chat.jpg">
<!-- 	                            <span class="icon">🤖</span> -->
	                            <span>AI 피드백</span>
	                        </div>
	                        <p class="feedback-text">답변을 제출하고 피드백을 받아보세요!</p>
	                    </div>
	              	</div>
					        <!-- 질문 카드 2, 3 -->
	                <%-- ... 카드 1번대로 for문 돌릴 예정 ... --%>
           		</c:forEach>
	            </div>

        </main>
    </div>

    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/interviewResult.js"></script>
</body>
</html>
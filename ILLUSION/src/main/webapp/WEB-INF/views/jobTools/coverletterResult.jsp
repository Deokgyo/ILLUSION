<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>생성된 자기소개서</title>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/coverletterResult.css">
</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
          	<div class="page-title-header">
              	<p class="header-text"><strong>생성된 자기소개서</strong></p>
          	</div>
            <div class="result-box">
                

                <div class="result-meta">
                    <div class="char-count">
                        <i class="fa-solid fa-star"></i> 
                        <span>${coverletter.generated_char_count}자 (공백 미포함 ${coverletter.generated_char_count_no_space }자)</span>
                    </div>
                    <div class="action-buttons">
                        <button class="btn btn-outline-secondary">저장</button>
                        <button id="copyBtn" class="btn btn-yellow">복사</button>
                    </div>
                </div>

                <textarea id="generated-text" readonly>${coverletter.generated_cl_content }</textarea>
                
                <div class="text-center mt-4">
                    <button id="backBtn" class="btn btn-lg btn-outline-secondary" onclick="history.back()">이전</button>
                </div>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/coverletterResult.js"></script>
</body>
</html>
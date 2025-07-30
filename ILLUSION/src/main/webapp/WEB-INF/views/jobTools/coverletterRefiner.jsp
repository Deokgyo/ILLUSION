<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자기소개서 다듬기</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/coverletterRefiner.css">
    
     <style type="text/css">
	     .gradient-btn{
	     	width: 18em;
	     	height: 60px
	     }
     </style> 
</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="refiner-box">
                <div class="page-title-header">
                    <p class="header-text"><strong>자기소개서 다듬기</strong></p>
                </div>
                
                <nav class="refiner-tabs-nav">
                    <a href="#" class="tab-link active" data-tab="panel-new-resume">새 자소서 다듬기</a>
                    <a href="#" class="tab-link" data-tab="panel-saved-resume">저장된 자소서</a>
                </nav>

                <div class="tabs-content">
                    <!-- 패널 1: 새 자소서 다듬기 -->
                    <div id="panel-new-resume" class="tab-panel active">
                        
                        <div id="section-file-upload" class="input-method-section">
                            <label for="check-file-upload" class="section-header">
                                <input class="form-check-input" type="checkbox" id="check-file-upload" checked>
                                <span>파일 업로드</span>
                            </label>
                            <div class="content-area">
                                <div class="drop-zone">
                                    <input type="file" id="file-input-hidden" style="display:none;"/>
                                    <div class="drop-zone-icon"><i class="fa-regular fa-folder-open"></i></div>
                                    <p class="drop-zone-text">파일을 끌어 놓거나 클릭하여 선택 하세요</p>
                                </div>
                                <div class="upload-button-wrapper"><button class="btn btn-yellow">업로드</button></div>
                            </div>
                        </div>

                        <div id="section-direct-input" class="input-method-section">
                            <label for="check-direct-input" class="section-header">
                                <input class="form-check-input" type="checkbox" id="check-direct-input">
                                <span>자기소개서 내용</span>
                            </label>
                            <div class="content-area">
                                <div class="textarea-wrapper">
                                    <textarea id="direct-input-textarea" placeholder="자기소개서 내용을 입력하세요"></textarea>
                                    <div class="char-counter">0 단어 | 0 글자</div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- 패널 2: 저장된 자소서 -->
                    <div id="panel-saved-resume" class="tab-panel">
                        <div class="resume-list">
                            <div class="resume-item"><span class="icon">📄</span> <span class="title">세심한 개발자</span></div>
                            <div class="resume-item"><span class="icon">📄</span> <span class="title">능력있는 개발자</span></div>
                            <div class="resume-item"><span class="icon">📄</span> <span class="title">프로 개발자</span></div>
                            <div class="resume-item"><span class="icon">📄</span> <span class="title">계획형 개발자</span></div>
                        </div>
                    </div>
                </div>

                <div class="submit-button-wrapper">
                    <button id="refine-submit-btn" class="gradient-btn" disabled>
                        자기소개서 다듬기 (🪙 30토큰 차감)
                    </button>
                </div>

            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

<!--     <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script> -->
<%--     <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script> --%>
<%--     <script src="${pageContext.request.contextPath}/resources/js/jobTools/coverletterRefiner.js"></script> --%>
</html>
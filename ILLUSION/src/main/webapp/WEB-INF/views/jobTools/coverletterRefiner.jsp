<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자기소개서 다듬기</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/coverletterRefiner.css">
</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="page-title-header">
                <p class="header-text"><strong>자기소개서 다듬기</strong></p>
            </div>
            <div class="refiner-box">
                <nav class="refiner-tabs-nav">
                    <a href="#" class="tab-link active" data-tab="panel-new-resume">새 자소서 다듬기</a>
                    <a href="#" class="tab-link" data-tab="panel-saved-resume">저장된 자소서</a>
                </nav>

                <div class="tabs-content">
                    <!-- 패널 1: 새 자소서 다듬기 -->
                    <div id="panel-new-resume" class="tab-panel active">
                        
                        <%-- [수정] 초기 상태를 위해 'disabled' 클래스 추가 --%>
                        <div id="section-file-upload" class="input-method-section disabled">
                            <label for="check-file-upload" class="section-header">
                                <%-- [수정] id 추가 --%>
                                <input type="radio" class="radiobox" name="cl_input_method" id="check-file-upload"/>
                                <span>파일 업로드</span>
                            </label>
                            <div class="content-area">
                                <div class="drop-zone">
                                    <input type="file" id="file-input-hidden" style="display:none;"/>
                                    <div class="drop-zone-icon"><i class="fa-regular fa-folder-open" style="color: var(--main-color)"></i></div>
                                    <p class="drop-zone-text">파일을 끌어 놓거나 클릭하여 선택 하세요</p>
                                </div>
                                <div class="upload-button-wrapper"><button class="gradient-btn">업로드</button></div>
                            </div>
                        </div>

                        <%-- [수정] 초기 상태를 위해 'disabled' 클래스 추가 --%>
                        <div id="section-direct-input" class="input-method-section disabled">
                            <label for="check-direct-input" class="section-header">
                                <%-- [수정] id 추가 --%>
                                <input type="radio" class="radiobox" name="cl_input_method" id="check-direct-input"/>
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

                    <!-- 패널 2: 저장된 자소서 (기존과 동일) -->
                    <div id="panel-saved-resume" class="tab-panel">
                        <div class="resume-list">
                            <c:forEach var="cl" items="${clList}">
                                <a href="coverLetterResult?cl_idx=${cl.cl_idx}" class="resume-item-link">
                                    <div class="resume-item">
                                        <span class="icon">📄</span>
                                        <span class="title">${cl.cl_title}</span>
                                    </div>
                                a>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <div class="submit-button-wrapper">
                    <%-- [수정] 초기 상태를 위해 'disabled' 속성 추가 --%>
                    <button id="refine-submit-btn" class="gradient-btn">
                        자기소개서 다듬기
                    </button>
                </div>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/coverletterRefiner.js"></script>
</body>
</html>
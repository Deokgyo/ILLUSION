
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI 면접 예상질문 생성</title>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/interviewCreate.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/inc/top.jsp" />

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="page-title-header">
            	<p class="header-text"><strong>AI 면접 예상질문</strong> AI가 이력서에 맞춰 면접 예상질문을 만들어 드립니다</p>
        	</div>
            <div class="interview-generator-box">
                
                <!-- 탭 네비게이션 -->
                <nav class="tabs-nav">
                    <a href="#" class="tab-link active" data-tab="panel-direct-input">
                        <h3 class="tab-title">직접 입력</h3>
                        <p class="tab-desc">자기소개서를 직접 입력합니다</p>
                    </a>
                    <a href="#" class="tab-link" data-tab="panel-file-upload">
                        <h3 class="tab-title">파일 업로드</h3>
                        <p class="tab-desc">자기소개서를 파일로 업로드합니다</p>
                    </a>
                    <a href="#" class="tab-link" data-tab="panel-saved-resumes">
                        <h3 class="tab-title">저장된 자기소개서</h3>
                        <p class="tab-desc">저장된 자기소개서를 불러옵니다</p>
                    </a>
                </nav>

                <!-- 탭 콘텐츠 영역 -->
                <div class="tabs-content">
                    <!-- 패널 1: 직접 입력 -->
                    <div id="panel-direct-input" class="tab-panel active">
                        <div class="textarea-wrapper">
                            <textarea placeholder="자기소개서 내용을 입력하세요"></textarea>
                            <div class="char-counter">
	                            <span class="textCnt">0</span>단어 | <span class="wordCnt">0</span> 글자
                            </div>
                        </div>
                    </div>

                    <!-- 패널 2: 파일 업로드 -->
                    <div id="panel-file-upload" class="tab-panel">
                        <div class="drop-zone">
                            <div class="drop-zone-icon"><i class="fa-regular fa-folder-open" style="color: var(--main-color)"></i></div>
                            <p class="drop-zone-text">파일을 끌어 놓거나 클릭하여 선택 하세요</p>
                        </div>
                        <input type="file" id="file-input-hidden" name="uploadedFile" style="display:none;"/>
                        <div class="upload-button-wrapper">
                            <button class="btn btn-yellow">업로드</button>
                        </div>
                    </div>

                    <!-- 패널 3: 저장된 자기소개서 -->
                    <div id="panel-saved-resumes" class="tab-panel">
                        <div class="resume-list">
                            <div class="resume-item">
                                <span class="icon">📄</span>
                                <span class="title">세심한 개발자</span>
                            </div>
                            <div class="resume-item active">
                                <span class="icon">📄</span>
                                <span class="title">능력있는 개발자</span>
                            </div>
                            <!-- ... 저장된 자소서 목록이 동적으로 추가될 영역 ... -->
                        </div>
                    </div>
                </div>

                <!-- 하단 생성 버튼 -->
                <div class="submit-button-wrapper">
                    <button class="gradient-btn">
                        예상질문 생성
                    </button>
                </div>

            </div>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/interviewCreate.js"></script>
</body>
</html>
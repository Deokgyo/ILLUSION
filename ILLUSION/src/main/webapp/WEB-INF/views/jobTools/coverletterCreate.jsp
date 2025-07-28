<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자기소개서 생성기</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/test.css"> 
    
   <style type="text/css">
   		.btn.disabled, .btn:disabled, fieldset:disabled .btn {
		opacity:.65;
}
   
   
   </style>
    
    
</head>
<body>
     <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="form-box">
                <form action="createSelfIntro.do" method="post">
                
                    <div class="form-header">
                        <h2>자기소개서 생성기</h2>
                        <p class="sub-title">AI가 당신의 경험을 참고하여 매력적인 이력서를 만들어 드립니다.</p>
                    </div>

                    <!-- 제목 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-pen-to-square"></i>
                            <h3 class="title">제목</h3>
                        </div>
                        <input type="text" name="title" class="form-control" placeholder="예: 삼성전자 마케팅 직무 자기소개서" required />
                    </div>

                    <!-- 기업명 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-building"></i>
                            <h3 class="title">기업명</h3>
                        </div>
                        <input type="text" name="company" class="form-control" placeholder="예: 삼성전자" required />
                    </div>

                    <!-- 직무 선택 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-square-check"></i>
                            <h3 class="title">직무 선택</h3>
                        </div>
                        <div class="category-grid">
                            <div class="category-column">
                                <h4 class="col-title">직무 카테고리</h4>
                                <div class="category-options">
                                    <div class="option-btn">디자인</div>
                                    <div class="option-btn active">개발자</div>
                                    <div class="option-btn">마케팅</div>
                                </div>
                            </div>
                            <div class="category-column">
                                <h4 class="col-title">세부 직무</h4>
                                <div class="category-options">
                                    <div class="option-btn">마케팅 기획</div>
                                    <div class="option-btn active">백엔드</div>
                                    <div class="option-btn">컨설턴트</div>
                                </div>
                            </div>
                        </div>
                        <div class="selected-tags-area">
                            <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div>
                            <div class="tag"><span>선택한 키워드</span><span class="close-btn">x</span></div>
                        </div>
                        <!-- 💡 참고: 위 버튼들과 아래 태그의 연동은 JavaScript가 필요합니다. -->
                    </div>

                    <!-- 경력사항 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-comments"></i>
                            <h3 class="title">경력사항</h3>
                        </div>
                        <div class="segmented-control">
                            <div class="option">신입</div>
                            <div class="option active">경력</div>
                        </div>
                        <div class="mt-3">
                            <input type="text" name="prevCompany" class="form-control mb-2" placeholder="이전 회사명" />
                            <input type="text" name="prevJob" class="form-control" placeholder="직책/직무" />
                        </div>
                    </div>

                    <!-- AI 생성 요구사항 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-solid fa-list-ul"></i>
                            <h3 class="title">AI 생성 요구사항</h3>
                        </div>
                        <input type="number" name="maxLength" class="form-control mb-2" placeholder="글자 수 (예: 1000)" />
                        <input type="text" name="keywords" class="form-control mb-2" placeholder="핵심 단어 (예: 문제해결능력, 리더십, 꼼꼼함)" />
                        <textarea name="question" class="form-control" rows="3" placeholder="문항 제목 (예: 지원 동기를 작성해주세요)"></textarea>
                    </div>

                    <div class="text-center mt-5">
                        <button type="submit" class="btn btn-yellow btn-lg" disabled="disabled">자기소개서 생성</button>
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
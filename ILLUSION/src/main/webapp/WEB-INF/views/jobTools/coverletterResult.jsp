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
            <div class="result-box">
            	<div class="page-title-header">
                	<p class="header-text"><strong>생성된 자기소개서</strong></p>
            	</div>
                

                <div class="result-meta">
                    <div class="char-count">
                        <i class="fa-solid fa-star"></i>
                        <span>700자 (공백 미포함 544자)</span>
                    </div>
                    <div class="action-buttons">
                        <button class="btn btn-outline-secondary">저장</button>
                        <button id="copyBtn" class="btn btn-yellow">복사</button>
                    </div>
                </div>

                <textarea id="generated-text" readonly>
저는 창의적인 디자인에 관심이 많은 소프트웨어 개발자입니다. 현재는 AI를 활용한 이력서 첨삭 플랫폼 'Illusion' 프로젝트를 개발하며, 영어와 한국어 콘텐츠 모두에 대응할 다양한 AI 시각 자료와 로고를 직접 디자인한 경험이 있습니다. 웹 개발 분야에서 Java Spring과 MyBatis를 사용하여 학생 등록과 HTTP 오류 문제 등 실질적인 현장 이슈를 해결한 경험이 있으며, 서비스 계층 아키텍처와 디자인 패턴 적용에도 역량을 키우고 있습니다.

객체지향 프로그래밍에 대한 높은 이해와 더불어, 상속·다형성·추상화 등 핵심 개념에 대해 끊임없이 탐구하고 있으며, Eclipse 등 다양한 개발 환경에서 실제 프로젝트를 진행해왔습니다. 생산성과 효율성을 중시하여, 키보드 단축키 및 노션을 통한 위키스페이스 관리 능력을 실무에 적극적으로 접목하고 있습니다.

앞으로도 창의성과 효율성을 바탕으로, 실질적인 사회적 가치를 창출하는 디지털 서비스 개발에 집중하고자 합니다. 새로운 기술 습득과 프로젝트 경험을 통해 빠르게 성장하며, 동료들과 협력하여 더 나은 결과물을 만들어 내는 개발자가 되고자 합니다.
                </textarea>
                
                <div class="text-center mt-4">
                    <button id="backBtn" class="btn btn-lg btn-outline-secondary">이전</button>
                </div>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/result-page.js"></script> 
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI 취업 상담 챗봇</title>
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/chatbot.css">
    <style type="text/css">
    	.gradient-btn{
    		position: absolute;
		    bottom: 100px;
		    right: 30px;
		    width: 150px;
    	}
    </style>
</head>
<body>
    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="chat-page-container">
                
                <!-- 스크롤되는 메인 대화 영역 -->
                <div class="chat-messages-area">
                    <!-- 초기 화면 -->
                    <div class="chat-initial-view">
                        <div class="intro-icon"><i class="fa-regular fa-comments"></i></div>
                        <div class="suggested-questions">
                            <h3>어떤 도움이 필요하신가요?</h3>
                            <ul>
                                <li><a href="#"><span>이력서 작성 팁을 알려주세요</span><i class="fa-solid fa-arrow-right"></i></a></li>
                                <li><a href="#"><span>개발자가 되기 위해 필요한 자격증은 무엇이 있나요?</span><i class="fa-solid fa-arrow-right"></i></a></li>
                                <li><a href="#"><span>개발자 포트폴리오는 어떻게 만드나요</span><i class="fa-solid fa-arrow-right"></i></a></li>
                                <li><a href="#"><span>디자이너가 되기 위해 필요한 역량이 있나요</span><i class="fa-solid fa-arrow-right"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- 대화 화면 -->
                    <div class="chat-conversation-view">
                        <div class="chat-messages">
                            <!-- 말풍선이 동적으로 추가될 영역 -->
                        </div>
                    </div>
                </div>

                <!-- 하단 입력 폼 (Floating) -->
                <div class="chat-input-form-wrapper">
                    <form class="chat-input-form">
                        <input type="text" id="message-input" class="form-control" placeholder="메시지를 입력하세요">
                        <button type="submit" class="btn btn-send"><i class="fa-solid fa-arrow-up"></i></button>
                    </form>
                </div>

                <!-- 토큰 충전 버튼 (Floating) -->
                <button type="button" class="gradient-btn">
                    토큰 충전 
                </button>
                
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>

    <!-- 토큰 부족 시 나타날 모달 -->
    <div id="token-modal" class="modal-overlay">
        <div class="modal-content">
            <div class="icon"><i class="fa-solid fa-circle-info"></i></div>
            <h4>토큰이 부족합니다</h4>
            <p>결제페이지로 이동하시겠습니까?</p>
            <div class="btn-group mt-3">
                <button class="btn btn-outline-secondary btn-no">아니요</button>
                <button class="btn btn-yellow btn-yes">네</button>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/chatbot.js"></script>
</body>
</html>
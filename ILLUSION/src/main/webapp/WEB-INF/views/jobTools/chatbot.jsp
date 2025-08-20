<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AI 취업 상담 챗봇</title>
   	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
 	
 	<%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/chatbot.css"> 
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
                        <div class="intro-icon"><i class="fa-regular fa-comments" style="color: #d3d3d3"></i></div>
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
                    
                    <!-- 대화 화면 (JS로 .chat-initial-view를 숨기고 이걸 보여줌) -->
                    <div class="chat-conversation-view">
                        <div class="chat-messages">
                            <!-- 말풍선이 동적으로 추가될 영역 -->
                        </div>
                    </div>
                </div>

				<div class="bottom-action-container">
				    <div class="action-wrapper">
				
				        <!-- 1. 메시지 입력창 -->
				        <form class="message-input-form" onsubmit="return false;">
				            <input type="text" id="message-input" placeholder="메시지를 입력하세요 (전송 시 5토큰 차감)">
<!-- 				            <button type="submit" class="btn-send"><i class="fa-solid fa-arrow-up"></i></button> -->
				            <button type="submit" class="gradient-btn"><i class="fa-solid fa-arrow-up"></i></button>
				        </form>
				
				        <!-- 2. 토큰 충전 버튼 -->
				        <button type="button" class="gradient-btn btn-token-charge">
				            <i class='far fa-gem' style= "color : var(--main-color)"></i> 토큰 충전
				        </button>
				    </div>
				</div>
                
            </div>
        </main>
    </div>

     <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer> 

     <!-- '토큰 부족' 모달 (이미 표준 구조) -->
     <div id="token-modal" class="modal-overlay">
        <div class="modal-content">
            <button class="close-modal-btn btn-no">×</button>
            <div class="modal-header">
                <div class="icon"><i class="fa-solid fa-circle-info"></i></div>
                <h4>토큰을 충전합니다 (현재 토큰 수 : ${userToken })</h4>
            </div>
            <p>결제페이지로 이동하시겠습니까?</p>
            <div class="modal-buttons">
                <button class="btn btn-secondary btn-no">아니요</button>
                <a href="${pageContext.request.contextPath}/tokenpay" class="btn btn-yellow">네</a>
            </div>
        </div>
    </div>
	
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/chatbot.js"></script>
</body>
</html>
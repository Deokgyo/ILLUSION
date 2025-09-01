	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>비밀번호 변경</title>
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
	<link rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	
	
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/top.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/layout.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/header.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/sidebar.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bottom.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/components.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/mypage/changePasswd.css">
	<style type="text/css">
	.page-title-header {
	    width: 1000px;
	    margin: auto;
	    margin-bottom: 30px;
	}
	.form-box {
	    margin: auto;
	    width: 960px;
	    margin-bottom: 30px;
	  	padding:0px;
	}
	
	
	.form-box {padding:0px;}
	
	</style>
	</head>
	<body>
		<header>
			<jsp:include page="/WEB-INF/views/inc/top.jsp" />
		</header>
		
		<div class="page-container">
	
		
		<main class="main-content">
	
	        <div class="page-title-header">
				<p class="header-text"><strong>비밀번호 변경 </strong></p>
	        </div>
		<div class="form-box">
	    <!-- 비밀번호 변경 폼 전체를 감싸는 컨테이너 -->
	    <div class="password-change-container">
	       
	        <!-- '회원 정보' 타이틀 바 -->
	
	        <!-- 실제 입력 폼 -->
	        <form action="changePasswd" class="password-form" method="post">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input type="hidden" name="member_idx" value="${selectuserInfoEdit.member_idx}" />
	
	            <!-- 새 비밀번호 입력 행 -->
	               <div class="form-row">
				        <div class="form-label">새 비밀번호</div>
				        <div class="form-input-group">
				            <input type="password" id="userpw" name="member_pw" placeholder="8~16 자리 / 영문 대소문자, 숫자, 특수문자 조합"><span
						id="userPwSuccess"></span>
				        </div>
	    			</div>
	           <div class="form-row"> 
	                 <div class="form-label">새 비밀번호 확인</div>
	                <div class="form-input-group">
	                    <input type="password" name="member_pw2" id="userpw2" placeholder="8~16 자리 / 영문 대소문자, 숫자, 특수문자 조합">
						<span id="userPwSuccess2"></span>
	              </div>
	            </div>
	           
	            <!-- '비밀번호 변경' 버튼 영역 -->
	            <div class="submit-area">
	                <button type="submit" class="submit-btn" onclick="return confirmSubmit();">비밀번호 변경</button>
	            </div>
		
	        </form>
	
	    </div>
		</div>
		
		</main>
		</div>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>	
	    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	    	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/myPage/changePasswd.js"></script>
	</body>
	</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/deleteMember.css">
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

</style>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	
	<main class="main-content">
	<div class="page-title-header">
			<p class="header-text"><strong>회원탈퇴 </strong></p>
        </div>
			<div class="form-box">
		   <section class="withdrawal-box">
      <div class="notice">
        <p><strong>회원탈퇴 안내문</strong></p>
        <ol>
          <li>ILLUSION을 이용해주셔서 감사합니다.</li>
          <li>회원 탈퇴 시 주의사항
            <ol type="a">
              <li>1. 탈퇴 즉시 모든 개인정보가 삭제되며, 복구가 불가능합니다.</li>
              <li>2. 탈퇴 후에도 일정 기간 서비스 기록은 보관될 수 있습니다.</li>
              <li>3. 기타 법령에 따라 보관이 필요한 정보는 예외로 합니다.</li>
            </ol>
          </li>
          <li>회원 탈퇴 처리는 즉시 진행되며 복구가 불가능합니다.</li>
          <li>문의: illusion.com@naver.com / 02-0000-0000</li>
        </ol>
      </div>
		<form action="deleteMember" id="withdrawForm" class="form" method="post">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		    <input type="hidden" name="member_idx" value="${selectuserInfoEdit.member_idx}">
		
		    <label>아이디 입력</label>
		    <input type="text" name="member_id" placeholder="아이디 입력하세요">
		
		    <label>비밀번호 입력</label>
		    <input type="password" name="member_pw" placeholder="비밀번호 입력하세요">
		
		    <div class="checkbox">
		        <label for="agree">
		            <input type="checkbox" id="agree" class="checkboxcss"> 상기 탈퇴 정책을 모두 확인하였으며, 이에 동의합니다.
		        </label>
		    </div>
		
		    <button type="submit" class="withdraw-btn">회원탈퇴</button>
		</form>
    </section>
	</div>
	
	</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/myPage/deleteMember.js"></script>
</body>
</html>
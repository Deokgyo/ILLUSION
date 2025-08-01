<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <%-- 외부 라이브러리 CSS --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="./resources/css/global.css">
    <link rel="stylesheet" href="./resources/css/top.css">
    <link rel="stylesheet" href="./resources/css/bottom.css">
    <link rel="stylesheet" href="./resources/css/recruiter/recruiterRegistForm.css">
    <link rel="stylesheet" href="./resources/css/components.css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
		
	</script>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
	<title>Home</title> <%-- 문구 수정 --%>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"> <%-- 사진추가 --%>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<main class="registration-form-container">
		<section class="form-header">
			<h1>공고 등록</h1>
		</section>
		
		<!-- 2. 실제 폼 내용이 들어갈 하얀색 바디 섹션 -->
        <section class="form-body">
        	<form action="" method="post">
            
            <i class="icon fa-regular fa-pen-to-square"></i>
            <h3 class="title">제목</h3>
            <input type="text" name="recruit_subject" class="form-control" placeholder="제목을 입력해주세요 (50자 이내)">
<!--             <p class="placeholder-text">폼 필드를 여기에 추가하세요.</p> -->
			<i class="fas fa-business-time icon"></i>
        	<select name="category" class="form-select category-select" required>
        		<option disabled selected>채용 유형 선택</option>
        		<option value="">정규직</option>
        		<option value="">계약직</option>
        		<option value="">파트타임</option>
        		<option value="">프리랜서</option>
        		<option value="">파견직</option>
        		<option value="">인턴</option>
        	</select>
        	</form>
        </section>
	</main>
	
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

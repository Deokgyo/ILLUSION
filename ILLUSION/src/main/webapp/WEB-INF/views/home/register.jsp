<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>

<%-- js 파일 --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/js/home/register.js"></script>

<%-- 외부 라이브러리 CSS --%>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%-- 우리가 만든 CSS 파일들 --%>
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/global.css">
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
   href="${pageContext.request.contextPath}/resources/css/home/login.css">
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/home/register.css">
<title>register</title>
</head>
<body>

   <%--    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header> --%>

   <div class="main-brand-section">
      <div class="brand-logo-wrap">
         <img src="./resources/image/logo2.png" alt="메인로고" class="main-logo-img">
         <div class="brand-title-group">
            </div>
         </div>
      </div>
      <div class="brand-slogan-wrap">
         <span class="slogan-bg-text"> 채용의 모든 솔루션, <span
            class="slogan-emph">일루션</span>에서 시작됩니다.
         </span>
      </div>
      <div class="member-tabs">
         <button class="tab-btn active">개인 회원</button>
         <button class="tab-btn">기업 회원</button>
      </div>
   </div>

   <div class="signup-form-box">
      <form class="signup-form" autocomplete="off">
         <div class="form-row">
            <label for="userid">아이디</label> <input type="text" id="userid"
               maxlength="20" placeholder="4~20 자리 / 영문, 숫자, 특수문자(_)·(.) 입력 가능"
               required>
         </div>
         <div class="form-row">
            <label for="userpw">비밀번호</label> <input type="password" id="userpw"
               maxlength="16" placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합" required>
         </div>
         <div class="form-row flex-row">
            <div class="flex-half">
               <label for="userpw2">비밀번호 확인</label> <input type="password"
                  id="userpw2" maxlength="16"
                  placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합" required>
            </div>
         </div>
         <div class="form-row flex-row">
            <div class="flex-half">
               <label for="username">이름</label> <input type="text" id="username"
                  placeholder="이름을 입력해주세요" required>
            </div>
            <div class="flex-half">
               <label for="gender">성별</label> <select id="gender" required>
                  <option value="">선택</option>
                  <option value="male">남성</option>
                  <option value="female">여성</option>
               </select>
            </div>
         </div>
         <div class="form-row">
            <label for="birth">생년월일</label> <input type="date" id="birth"
               required>
         </div>
         <div class="form-row address-row">
            <label for="zipcode">주소</label>
            <div class="address-flex">
               <input type="text" id="zipcode" placeholder="우편 번호" required>
               <button type="button" class="btn-yellow" id="zipcode-btn">주소
                  찾기</button>
            </div>
            <input type="text" id="addr-1" placeholder="주소를 입력해주세요" required>
            <input type="text" id="addr-2" placeholder="나머지 주소" required>
         </div>
         <div class="form-row flex-row">
            <div class="flex-half">
               <label for="email">이메일 주소</label>
               <div class="email-flex">
                  <input type="email" id="email" placeholder="이메일 입력" required>
                  <button type="button" class="btn-yellow" id="email-btn">인증
                     메일 발송</button>
               </div>
            </div>
            <div class="flex-half">
               <label for="emailcode">인증번호 확인</label>
               <div class="email-flex">
                  <input type="text" id="emailcode" maxlength="6"
                     placeholder="인증번호를 입력하세요">
                  <button type="button" class="btn-yellow" id="emailcode-btn">인증
                     번호 확인</button>
               </div>
            </div>
         </div>

         <div class="form-terms">
            <div class="terms-title">이용 약관</div>
            <div class="terms-row">
               <label><input type="checkbox" id="agree-all"> 전체 동의</label>
            </div>
            <div class="terms-row">
               <label><input type="checkbox" required> 이용 약관 동의
                  (필수)</label> <a href="#" class="terms-link">내용 보기</a>
            </div>
            <div class="terms-row">
               <label><input type="checkbox" required> 개인정보 처리 동의
                  (필수)</label> <a href="#" class="terms-link">내용 보기</a>
            </div>
            <div class="terms-row">
               <label><input type="checkbox"> 마케팅 동의 (선택)</label> <a
                  href="#" class="terms-link">내용 보기</a>
            </div>
         </div>
         <button class="signup-btn" type="submit">회원가입</button>
      </form>
   </div>


   <%--    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer> --%>
</body>
</html>

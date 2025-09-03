<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<%-- js 파일 --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/home/register.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/commonJs.js"></script>
<script>
	// JSP에서 서버 contextPath를 자바스크립트 변수에 담아 클라이언트가 사용할 수 있도록 함
	var contextPath = '${pageContext.request.contextPath}';
</script>

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
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/home/login.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/home/register.css">
<title>회원가입</title>
</head>
<body>

	<%--    <header><jsp:include page="/WEB-INF/views/inc/top.jsp" /></header> --%>

	<div class="main-brand-section">
		<div class="brand-logo-wrap">
			<a href="./"> <img src="./resources/image/logo2.png" alt="메인로고"
				class="main-logo-img">
			</a>
			<div class="brand-title-group"></div>
		</div>
	</div>
	<div class="brand-slogan-wrap">
		<span class="slogan-bg-text"> 채용의 모든 솔루션, <span
			class="slogan-emph">일루션</span>에서 시작됩니다.
		</span>
	</div>
	<div class="member-tabs">
		<button class="tab-btn active" id="personalTab">개인 회원</button>
		<button class="tab-btn" id="companyTab">기업 회원</button>
	</div>
	<div class="signup-form-box">

		<form action="${pageContext.request.contextPath}/register"
			method="post" id="registerForm" class="signup-form"
			autocomplete="off" >

			<div class="input-box" id="companyBox">
				<label for="Number">사업자등록번호</label> <input type="text"
					id="companyNumber" name="recruiter_number" maxlength="10"
					placeholder="사업자등록번호 10자리 '-' 제거 후 입력">
				<button type="button" class="btn-company" id="btncompany"
					value="등록번호검색" name="btncompanyNumber">사업자 인증</button>
			</div>
			<div class="form-row">
				<label for="userid">아이디</label> <input type="text" id="userid"
					name="member_id" maxlength="20"
					placeholder="4~20 자리 / 영문, 숫자, 특수문자 _ 입력 가능"> &nbsp;<span
					id="UserIdSuccess"></span>
			</div>
			<div class="form-row">
				<label for="userpw">비밀번호</label> <input type="password" id="userpw"
					name="member_pw" maxlength="16"
					placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합"> <span
					id="userPwSuccess"></span>
			</div>
			<div class="form-row flex-row">
				<div class="flex-half">
					<label for="userpw2">비밀번호 확인</label> <input type="password"
						id="userpw2" maxlength="16"
						placeholder="8~16자리 / 영문 대소문자, 숫자, 특수문자 조합"> <span
						id="userPwSuccess2"></span>
				</div>
			</div>
			<div class="form-row flex-row">
				<div class="flex-half" id="username_container">
					<label for="username">이름</label> <input type="text" id="username"
						name="member_name" placeholder="이름을 입력해주세요" required>
				</div>
				<div class="flex-half" id="company">
					<label for="compname">대표자명</label> 
					<input type="text" id="companyname" name="ceo_name" placeholder="대표자명을 입력해주세요" required>
				</div>
				<div class="flex-half gender-row" id="genderHide">
					<label for="gender">성별</label> <select id="gender" name="gender" required>
						<option value="">선택</option>
						<option value="GEN001">남성</option>
						<option value="GEN002">여성</option>
					</select>
				</div>
			</div>

			<div class="form-row birth_user" id=birthHide>
				<label for="birth">생년월일</label> <input type="date" id="birth" name="resume_birth" max="오늘날짜" required>
			</div>

			<div class="horizontal-wrapper">
				<div class="form-row" id="compdate">
					<label for="comdate" id="comdates">설립일</label> <input type="date"
						id="company_date" name="company_estab_date" required>
				</div>

				<div class="company-row" id="companytypes">
					<label for="comtype" id="companytype">기업형태</label> <select
						id="cotypes" name="company_type" class="comtype" required>
						<option value="">선택</option>
						<option value="CPT001">대기업</option>
						<option value="CPT002">중견기업</option>
						<option value="CPT003">중소기업</option>
						<option value="CPT004">스타트업</option>
						<option value="CPT005">공기업</option>
					</select>
				</div>
			</div>
			<div class="form-row address-row">
				<label for="zipcode">주소</label> <input type="text" id="zipcode"
					name="address_num" placeholder="우편번호" class="zip-input" >
				<button type="button" class="btn-yellow" id="btnaddress" value="주소검색">주소찾기</button>
			</div>
			<div class="form-row addr">
				<input type="text" id="address1" name="address_name1"
					placeholder="주소를 입력해 주세요" required>
			</div>
			<div class="form-row addr">
				<input type="text" id="address2" name="address_name2"
					placeholder="나머지 주소" required>
			</div>
			<div class="form-row flex-row">
				<div class="flex-half">
					<label for="email">이메일 주소</label>
					<div class="email-flex">
						<input type="text" id="email" placeholder="이메일 입력"
							name="member_email">
						<button type="button" class="btn-yellow1" id="email-btn">인증
							메일 발송</button>
					</div>
				</div>
			</div>
			<div class="flex-half">
				<label for="emailcode">인증번호 확인</label>
				<div class="email-flex2">
					<input type="text" id="emailcode" maxlength="6"
						placeholder="인증번호를 입력하세요">
					<button type="button" class="btn-yellow1" id="checkAuthBtn">인증번호 확인</button>
				</div>
			</div>

			<hr class="terms-divider">
			<div class="form-terms">
				<div class="terms-title">이용 약관</div>
					<div class="terms-row">
						<label><input type="checkbox" id="agree-all"> 
							<span class="agree-label2">전체 동의</span> 
						</label>
					</div>
				<div class="terms-row">
					<label><input type="checkbox" class="agree-each" name="agreeTerms" required>
						<span class="agree-label">이용 약관 동의 (필수)</span> 
					</label> 
						<a href="#" class="agreeCheck">내용 보기</a>
				</div>
				<div class="terms-row">
					<label><input type="checkbox" class="agree-each" name="agreePrivacy" required>
						<span class="agree-label">개인정보 처리 동의 (필수)</span> 
					</label> 
						<a href="#" class="agreeCheck">내용 보기</a>
				</div>
				<div class="terms-row">
					<label> <input type="checkbox" class="agree-each" name="member_marketing_agreed" value="BOL001"> 
					<span class="agree-label">마케팅 동의 (선택)</span>
					</label> <a href="#" class="agreeCheck">내용 보기</a> 
						<input type="hidden" name="member_marketing_agreed" value="BOL002" />
				</div>
			</div>

			<!-- 참조 -->
			<input type="hidden" name="member_type" id="member_type" value="MEM002">
			<input type="hidden" name="member_status" id="member_status"> 
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			<button type="submit" class="signup-btn" id="register-btn">회원가입</button>
		</form>
	</div>


	<%--    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer> --%>

	<!-- ==================================================== -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		let btnaddress = document.querySelector("#btnaddress");
		btnaddress.onclick = function() {
			new daum.Postcode({
				oncomplete : function(data) {

					document.querySelector("#zipcode").value = data.zonecode;

					let addr = data.address;
					if (data.buildingName != "") {
						addr += " (" + data.buildingName + ")";
					}

					document.querySelector("#address1").value = addr;
					document.querySelector("#address2").focus();

				}
			}).open();
		}
	</script>
</body>
</html>

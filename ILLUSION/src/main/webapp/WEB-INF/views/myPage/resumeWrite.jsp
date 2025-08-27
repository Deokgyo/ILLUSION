<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 등록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<%-- 외부 라이브러리 CSS --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%-- 우리가 만든 CSS 파일들 --%>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/resumeWrite.css">
</head>
<header>
	<jsp:include page="/WEB-INF/views/inc/top.jsp" />
</header>
<body>
<%-- 	${sessionScope.loginUser } --%>
	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>이력서 등록</strong>
				</p>
			</div>

			<div class="container">
				<form action="resumeWrite" name="resumeForm" method="post" onsubmit="return validateForm()" enctype="multipart/form-data">
					<input type="hidden" name="member_idx" value="${member.member_idx }">
					 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<div class="resume-form">
						<div class="section">
							<div class="form-row">
								<div class="form-group">
									<input type="text" name="resume_title" placeholder="제목을 입력하세요" autocomplete="off">
								</div>
							</div>
							<div class="profile-section">
									<div class="avatar-container">
									    <!-- 미리보기 영역 -->
									    <div class="avatar-placeholder" id="avatarPreview">
									        
				        				<img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png">
				       
									    </div>
									
									    <!-- 실제 업로드 input (숨김) -->
									    <input type="file" name="resume_img" id="file1" accept="image/*" style="display: none;">
									
									    <!-- 커스텀 버튼 -->
									    <button type="button" class="upload-btn" onclick="document.getElementById('file1').click();">업로드</button>
									</div>
								<div class="profile-info">
									
									<div class="info-box">
									<div class="name">이름: ${member.member_name }</div>
									<div class="memberData">주소: ${member.address_name }</div>
									<div class="memberData">전화번호: ${member.member_phone }</div>
									<div class="memberData">성별: ${member.gender }</div>
									<div class="memberData">이메일: ${member.member_email }</div>
									
									</div>
								</div>
							</div>
						</div>

						<div class="section">
							<h4 class="form-section-title">학력</h4>
							<div class="form-row">
								<div class="form-group">
									<label>학교 이름</label> <input type="text" name="school_name" placeholder="학교명을 입력하세요" autocomplete="off">
								</div>
								<div class="form-group">
									<label>전공</label>
									 <input type="text" name="major" placeholder="전공을 입력하세요" autocomplete="off">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>학위</label>
									 <select name="degree">
									 		<option value="" selected disabled>-- 선택 --</option>
										    <c:forEach var="d" items="${degreeList}">
										        <option value="${d.code}">${d.code_name}</option>
										    </c:forEach>
										</select>
								</div>
								<div class="form-group">
									<label>상태</label>
									 <select name="degreetype">
										<option value="" selected disabled>-- 선택 --</option>
										<option value="재학">재학</option>
										<option value="중퇴">중퇴</option>
										<option value="졸업">졸업</option>
									</select>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>학점</label>
									<div class="gpa-group">
										<input id="gradeInput" type="text" name="grade" placeholder="학점을 입력하세요 ex) 4.0" style="flex: 1;" autocomplete="off">
											 <span>/</span>
										<select id="gradeSelect" style="flex-basis: 100px;">
									        <option value="4.5">4.5</option>
									        <option value="4.3">4.3</option>
									        <option value="4.0">4.0</option>
									    </select>
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>입학일</label>
									<div class="date-input-container">
   										<input type="text" name="enroll_date" id="enroll_date" placeholder="연도-월-일">
									</div>
								</div>
								<div class="form-group">
									<label>졸업일</label>
									<div class="date-input-container">
   										<input type="text" name="graduation_date" id="graduation_date" placeholder="연도-월-일">
									</div>
									
								</div>
							</div>
							<div class="form-group">
								<label>추가정보 (선택)</label>
								<textarea name="additional_information" placeholder="기타 성과, 수상 경력, 관련 프로젝트 등을 입력하세요 ex) 수석 졸업 등" autocomplete="off"></textarea>
							</div>
						</div>

						<div class="section">
							<h4 class="form-section-title">경력사항 (선택)</h4>
							<div class="form-row">
								<div class="form-group">
									<label>회사명</label>
									 <input name="company_name" type="text" placeholder="회사명을 입력하세요" autocomplete="off">
								</div>
								<div class="form-group">
									<label>직책</label>
									<div class="date-input-container">
										<select name="position">
											<option value="" selected disabled>-- 선택 --</option>
										    <c:forEach var="e" items="${positionList}">
										        <option value="${e.code_name}">${e.code_name}</option>
										    </c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>경력</label>
									<div class="date-input-container">
										<select name="experience">
											<option value="" selected disabled>-- 선택 --</option>
										    <c:forEach var="e" items="${experienceList}">
										        <option value="${e.code}">${e.code_name}</option>
										    </c:forEach>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label>직무</label>
									<div class="date-input-container">
										<select name="occupation">
											<option value="" selected disabled>-- 선택 --</option>
										    <c:forEach var="e" items="${occupationList}">
										        <option value="${e.code}">${e.code_name}</option>
										    </c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label>담당 업무 및 성과</label>
								<textarea name="responsibilities" placeholder="주요 담당 업무 및 성과를 입력하세요" autocomplete="off"></textarea>
							</div>
						</div>

						<div class="section">
							<div class="form-group">
								<label>자격증(선택)</label> <input type="text" name="certificate" placeholder="보유중인 자격증을 입력하세요" autocomplete="off">
							</div>
						</div>

					</div>
					<button type="submit" class="btn btn-save"
						onclick="return confirm('저장하시겠습니까?');">저장</button>
				</form>
			</div>
		</main>
	</div>
</body>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
<script type="text/javascript">
// 파일 채인지시 미리보기 구현
$("#file1").on("change", function(e) {
	    const file = e.target.files[0];
	    if (file) {
	        const imageUrl = URL.createObjectURL(file);
	        $("#avatarPreview img").attr("src", imageUrl); // <img> src 변경
	    }
	});
flatpickr("#enroll_date", {
    dateFormat: "Y-m-d",
    locale: "ko",
    clickOpens: true,
    allowInput: true,
    defaultDate: null,
    onChange: function(selectedDates, dateStr, instance) {
        instance.input.value = dateStr; // 선택된 날짜를 input.value에 반영
        console.log("입학일 선택:", dateStr);
    }
});
flatpickr("#graduation_date", {
    dateFormat: "Y-m-d",
    locale: "ko",
    clickOpens: true,
    allowInput: true,
    defaultDate: null,
    onChange: function(selectedDates, dateStr, instance) {
        instance.input.value = dateStr;
        console.log("졸업일 선택:", dateStr);
    }
});
	
	// 학점 입력 제어
	const gradeInput = document.getElementById("gradeInput");
	const gradeSelect = document.getElementById("gradeSelect");

	// 초기 최대값 설정
	let maxGrade = parseFloat(gradeSelect.value) || 4.5;

	// select 변경 시 최대값 업데이트
	gradeSelect.addEventListener("change", function() {
	    maxGrade = parseFloat(this.value) || 4.5;

	    // input 값이 새 maxGrade보다 크면 자동 조정
	    if (gradeInput.value && !isNaN(parseFloat(gradeInput.value)) && parseFloat(gradeInput.value) > maxGrade) {
	        gradeInput.value = maxGrade;
	    }
	});

	// input 입력 제한
	gradeInput.addEventListener("input", function() {
	    // 숫자와 소수점만 허용
	    this.value = this.value.replace(/[^0-9.]/g, '');

	    // 소수점 두 자리까지만 허용
	    const parts = this.value.split('.');
	    if (parts.length > 2) this.value = parts[0] + '.' + parts[1];
	    if (parts[1] && parts[1].length > 2) this.value = parts[0] + '.' + parts[1].substring(0, 2);

	    // maxGrade보다 크면 강제로 maxGrade로 설정
	    if (this.value && !isNaN(parseFloat(this.value)) && parseFloat(this.value) > maxGrade) {
	        this.value = maxGrade;
	    }
	});

	// 초기값 동기화 (input에 값이 이미 있을 경우)
	if (gradeInput.value && !isNaN(parseFloat(gradeInput.value)) && parseFloat(gradeInput.value) > maxGrade) {
	    gradeInput.value = maxGrade;
	}
	
	
	//submit하기전 폼안에서의 유효성검사
	function validateForm() {
		const form = document.forms["resumeForm"];

		// 제목 검사
		if (form["resume_title"].value.trim() === "") {
			alert("제목을 입력해주세요!");
			form["resume_title"].focus();
			return false;
		}

		// 학교 이름 검사
		if (form["school_name"].value.trim() === "") {
			alert("학교 이름을 입력해주세요!");
			form["school_name"].focus();
			return false;
		}

		// 전공 검사
		if (form["major"].value.trim() === "") {
			alert("전공을 입력해주세요!");
			form["major"].focus();
			return false;
		}

		// 학위 선택 검사 (첫 번째 select는 name 없음 -> name 추가 필요)
		if (!form["degree"].value) {
		    alert("학위를 선택해주세요!");
		    form["degree"].focus();
		    return false;
		}
		
		// 상태 검사
		if (!form["degreetype"].value) {
		    alert("상태를 선택해주세요!");
		    form["degreetype"].focus();
		    return false;
		}
		// 학점 검사
		if (!form["grade"].value) {
			alert("학점을 입력해주세요!");
			form["grade"].focus();
			return false;
		}
		// 입학날짜 검사
		if (!form["enroll_date"].value) {
			alert("입학 날짜를 선택해주세요!");
			form["enroll_date"].focus();
			return false;
		}
		// 졸업날짜 검사
		if (!form["graduation_date"].value) {
			alert("졸업 날짜를 선택해주세요!");
			form["graduation_date"].focus();
			return false;
		}
	    // 날짜 비교
	    const enrollDate = new Date(form["enroll_date"].value);
	    const graduationDate = new Date(form["graduation_date"].value);
	    if (graduationDate < enrollDate) {
	        alert("졸업 날짜는 입학 날짜보다 이전일 수 없습니다!");
	        form["graduation_date"].focus();
	        return false;
	    }
	    
		return true; // 모든 체크 통과하면 제출
	}


</script>
</html>
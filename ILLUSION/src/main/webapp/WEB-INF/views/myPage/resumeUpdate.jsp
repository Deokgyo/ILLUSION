<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이력서 수정</title>

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
	<div class="page-container">
		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>이력서 수정</strong>
				</p>
			</div>

			<div class="container">
				<form action="resumeUpdate" name="resumeForm" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="resume_idx" value="${resume.resume_idx}">
					<input type="hidden" name="member_idx" value="1">
					<div class="resume-form">
						<div class="section">
							<div class="form-row">
								<div class="form-group">
									<input value="${resume.resume_title}" type="text"
										name="resume_title" placeholder="제목을 입력하세요">
								</div>
							</div>
							<div class="profile-section">
								<div class="avatar-container">
									<div class="avatar-placeholder"></div>
									<button class="upload-tag">업로드</button>
								</div>
								<div class="profile-info">
									<h3>일루션</h3>
									<div class="info-box">가져 올 정보</div>
								</div>
							</div>
						</div>

						<div class="section">
							<h4 class="form-section-title">학력</h4>
							<div class="form-row">
								<div class="form-group">
									<label>학교 이름</label> <input type="text"
										value="${resume.school_name}" name="school_name"
										placeholder="학교명을 입력하세요">
								</div>
								<div class="form-group">
									<label>전공</label> <input type="text" name="major"
										value="${resume.major}" placeholder="전공을 입력하세요">
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>학위</label> <select>
										<option value="" selected disabled>-- 선택 --</option>
										<option value="고등학교 졸업"
											<c:if test="${resume.degree == '고등학교 졸업'}">selected</c:if>>고등학교
											졸업</option>
										<option value="전문대 졸업"
											<c:if test="${resume.degree == '전문대 졸업'}">selected</c:if>>전문대
											졸업</option>
										<option value="대학교 졸업"
											<c:if test="${resume.degree == '대학교 졸업'}">selected</c:if>>대학교
											졸업</option>
										<option value="석사 학위"
											<c:if test="${resume.degree == '석사 학위'}">selected</c:if>>석사
											학위</option>
										<option value="박사 학위"
											<c:if test="${resume.degree == '박사 학위'}">selected</c:if>>박사
											학위</option>
									</select>
								</div>
								<div class="form-group">
									<label>상태</label> <select name="degree">
										<option value="" disabled
											<c:if test="${empty resume.degree}">selected</c:if>>--
											선택 --</option>
										<option value="재학"
											<c:if test="${resume.degree == '재학'}">selected</c:if>>재학</option>
										<option value="중퇴"
											<c:if test="${resume.degree == '중퇴'}">selected</c:if>>중퇴</option>
										<option value="졸업"
											<c:if test="${resume.degree == '졸업'}">selected</c:if>>졸업</option>
									</select>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>학점</label>
									<div class="gpa-group">
										<input type="text" value="${resume.grade}" name="grade"
											placeholder="학점을 입력하세요 ex) 4.5" style="flex: 1;"> <span>/</span>
										<select style="flex-basis: 100px;">
											<option>4.5</option>
											<option>4.3</option>
											<option>4.0</option>
										</select>
									</div>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>입학일</label>
									<div class="date-input-container">
										<input type="text" value="${resume.enroll_date}"
											name="enroll_date" onfocus="(this.type='date')"
											onblur="(this.type='text')" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label>졸업일</label>
									<div class="date-input-container">
										<input type="text" value="${resume.graduation_date}"
											name="graduation_date" onfocus="(this.type='date')"
											onblur="(this.type='text')" placeholder="">
									</div>
								</div>
							</div>
							<div class="form-group">
								<label>추가정보 (선택)</label>
								<textarea
									placeholder="기타 성과, 수상 경력, 관련 프로젝트 등을 입력하세요
ex) 수석 졸업 등"></textarea>
							</div>
						</div>

						<div class="section">
							<h4 class="form-section-title">경력사항</h4>
							<c:forEach var="exp" items="${resume_exp_info_list}">
								<div class="form-row">
									<div class="form-group">
										<label>회사명</label> <input type="text"
											value="${exp.company_name}" name="company_name"
											placeholder="회사명을 입력하세요">
									</div>
									<div class="form-group">
										<label>직책</label> <input type="text" value="${exp.position}"
											name="position" placeholder="직책을 입력하세요">
									</div>
								</div>
								<div class="form-row">
									<div class="form-group">

										<label>경력</label>
										<div class="date-input-container">
											<select name="experience">
												<option value="" disabled
													<c:if test="${empty exp.experience}">selected</c:if>>--
													선택 --</option>
												<option value="신입"
													<c:if test="${exp.experience == '신입'}">selected</c:if>>신입</option>
												<option value="1~3년차"
													<c:if test="${exp.experience == '1~3년차'}">selected</c:if>>1~3년차</option>
												<option value="4~7년차"
													<c:if test="${exp.experience == '4~7년차'}">selected</c:if>>4~7년차</option>
												<option value="8+년차"
													<c:if test="${exp.experience == '8+년차'}">selected</c:if>>8+년차</option>
												<option value="경력무관"
													<c:if test="${exp.experience == '경력무관'}">selected</c:if>>경력무관</option>
												<option value="인턴"
													<c:if test="${exp.experience == '인턴'}">selected</c:if>>인턴</option>
												<option value="계약직"
													<c:if test="${exp.experience == '계약직'}">selected</c:if>>계약직</option>
											</select>
										</div>

									</div>
									<div class="form-group">
										<label>직종</label>
										<div class="date-input-container">
											<input value="${exp.occupation}" name="occupation"
												type="text" placeholder="직종을 입력하세요">
										</div>
									</div>
								</div>
								<div class="form-group">
									<label>담당 업무 및 성과</label>
									<textarea placeholder="주요 담당 업무를 입력하세요"></textarea>
								</div>
							</c:forEach>
							<button class="btn btn-add">+ 경력 추가하기</button>
						</div>

						<div class="section">
							<div class="form-group">
								<label>자격증(선택)</label> <input type="text"
									placeholder="보유중인 자격증을 입력하세요">
							</div>
						</div>

					</div>
					<button type="submit" class="btn btn-save"
						onclick="if(confirm('수정하시겠습니까?')) location.href='savedResumeDetail?resume_idx=${resume_idx}&member_idx=${member_idx}';">수정</button>
			</div>
			</form>
		</main>
	</div>
</body>
<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>

</html>
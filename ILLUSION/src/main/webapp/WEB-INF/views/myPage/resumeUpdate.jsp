<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이력서 수정</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
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
                <p class="header-text"><strong>이력서 등록</strong></p>
            </div>
            
	<div class="container">
       <form action="resumeWrite" name="resumeForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_idx" value="1">
        <div class="resume-form">
            <div class="section">
            <div class="form-row">
                <div class="form-group">
                <input type="text" name="resume_title" placeholder="제목을 입력하세요"></div>
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
                        <label>학교 이름</label>
                        <input type="text" name="school_name" placeholder="학교명을 입력하세요">
                    </div>
                    <div class="form-group">
                        <label>전공</label>
                        <input type="text" name="major" placeholder="전공을 입력하세요">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>학위</label>
                        <select >
                                <option value="" selected disabled>-- 선택 --</option>
                                <option>전문학사</option>
                                <option>학사</option>
                                <option>석사</option>
                                <option>박사</option>       
                        </select>
                    </div>
                    <div class="form-group">
                        <label>상태</label>
                       <select name="degree">
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
                             <input type="text" name ="grade" placeholder="학점을 입력하세요 ex) 4.5" style="flex:1;">
                             <span>/</span>
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
                            <input type="text" name="enroll_date" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label>졸업일</label>
                         <div class="date-input-container">
                            <input type="text" name="graduation_date" onfocus="(this.type='date')" onblur="(this.type='text')" placeholder="">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>추가정보 (선택)</label>
                    <textarea placeholder="기타 성과, 수상 경력, 관련 프로젝트 등을 입력하세요
ex) 수석 졸업 등"></textarea>
                </div>
            </div>
            
            <div class="section">
                <h4 class="form-section-title">경력사항</h4>
                <div class="form-row">
                    <div class="form-group">
                        <label>회사명</label>
                        <input name="company_name" type="text" placeholder="회사명을 입력하세요">
                    </div>
                    <div class="form-group">
                        <label>직책</label>
                        <input name="position" type="text" placeholder="직책을 입력하세요">
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>경력</label>
                        <div class="date-input-container">
                            <select name="experience">
						    <option value="" selected disabled>-- 선택 --</option>
						    <option value="신입">신입</option>
						    <option value="1~3년차">1~3년차</option>
						    <option value="4~7년차">4~7년차</option>
						    <option value="4~7년차">4~7년차</option>
						    <option value="8+년차">8+년차</option>
						    <option value="경력무관">경력무관</option>
						    <option value="인턴">인턴</option>
						    <option value="인턴">계약직</option>
						</select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>직종</label>
                        <div class="date-input-container">
                         <input name="occupation" type="text" placeholder="직종을 입력하세요">    
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label>담당 업무 및 성과</label>
                    <textarea placeholder="주요 담당 업무를 입력하세요"></textarea>
                </div>
                <button class="btn btn-add">+ 경력 추가하기</button>
            </div>
            
            <div class="section">
                 <div class="form-group">
                    <label>자격증(선택)</label>
                    <input type="text" placeholder="보유중인 자격증을 입력하세요">
                </div>
            </div>

        </div>
        
        <button type="submit" class="btn btn-save" 
        onclick="if(confirm('저장하시겠습니까?')) location.href='savedResumeDetail?resume_idx=${resume_idx}&member_idx=${member_idx}';">저장</button>
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
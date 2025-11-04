<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 상세정보</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    	 

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMember.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMemberDetail.css">
    
</head>
<body>
	<div class="main-container">
	    <div class="admin-wrapper">
	        <!-- =======================
	             왼쪽 사이드바 (Aside)
	            ======================== -->
	        <aside class="admin-sidebar">
	            <div class="sidebar-header">
	                <a href="./adminMain" class="logo">
	                    <!-- 로고 이미지를 나중에 추가하세요 -->
	                    <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="이미지 설명" />
	                </a>
	            </div>
	            
	            <nav class="sidebar-nav">
	                <ul>
	                    <li><a href="./adminMember" class="nav-item">회원 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminRecruitment" class="nav-item">공고 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminCommunity" class="nav-item">게시글 관리<!-- <span>▼</span> --></a></li>
<!-- 	                    <li><a href="./adminSupport" class="nav-item">고객 문의<span>▼</span></a></li> -->
<!-- 	                    <li><a href="./adminPayment" class="nav-item">결제 이력<span>▼</span></a></li> -->
	                    <li><a href="./comcodeRegist" class="nav-item">공통 코드 관리<!-- <span>▼</span> --></a></li>
	                </ul>
	            </nav>
	        </aside>
	
	        <!-- =======================
	             메인 영역 (오른쪽)
	            ======================== -->
	        <div class="main-content-area">
	            <!-- 메인 헤더 -->
	            <header class="admin-header">
	                <div class="user-actions">
	                    <a href="./">로그아웃</a>
	                    <a href="./">사용자 화면</a>
	                </div>
	            </header>
	
	            <!-- 메인 콘텐츠가 표시될 영역 -->
	            <main class="admin-content">
	            
	            <!-- 1. 페이지 헤더 -->
		         <div class="page-title-header">
	         	    <p class="header-text"><strong>구직자/기업 회원목록</strong></p>
	             </div>
        
			        <div class="detail-layout">
			            <!-- =======================
			                 왼쪽 정보 컬럼
			                ======================== -->
			            <div class="form-column left">
			                <div class="form-group">
			                    <label>아이디</label>
			                    <div class="form-value">${member.member_id}</div>
			                </div>
<!-- 			                <div class="form-group"> -->
<!-- 			                    <label>비밀번호</label> -->
<%-- 			                    <div class="form-value">${member.member_pw}</div> --%>
<!-- 			                </div> -->
			                <div class="form-group">
			                    <label>이름</label>
			                    <div class="form-value">${member.member_name}</div>
			                </div>
			                <div class="form-group">
			                    <label>이메일</label>
			                    <div class="form-value"><a href="mailto:${member.member_email}">${member.member_email}</a></div>
			                </div>
        			        <div class="form-group">
			                    <label>생년월일</label>
			                    <div class="form-value">${member.resume_birth}</div>
			                </div>
			                <div class="form-group">
			                    <label>우편번호</label>
			                    <div class="form-value">${member.address_num}</div>
			                </div>
			                <div class="form-group">
			                    <label>주소</label>
			                    <div class="form-value">${member.address_name}</div>
			                </div>
			                 <div class="form-group">
			                    <label>회원 유형</label>
			                    <div class="form-value">${member.member_type_name}</div>
			                </div>
			                 <div class="form-group">
			                    <label>가입일자</label>
			                   
			                    <div class="form-value">ㅇㅇ${member.member_signup_date}</div>
			                </div>
			            </div>
			
			            <!-- =======================
			                 오른쪽 정보 컬럼
			                ======================== -->
			            <div class="form-column right">
					        <c:choose>
					            <c:when test="${not empty member.profile_picture_url}">
					                <img src="${pageContext.request.contextPath}/resources/upload/${member.profile_picture_url}" alt="프로필 이미지">
					            </c:when>
					            <c:otherwise>
					                <img src="${pageContext.request.contextPath}/resources/mypage_image/profile.png" alt="기본 이미지" id="profilePreview">
					            </c:otherwise>
					        </c:choose>
			                <div class="form-group">
			                    <label>성별</label>
			                    <div class="form-value">${member.gender_name}</div>
			                </div>
			                <div class="form-group">
			                    <label>마케팅 동의</label>
			                    <div class="form-value">${member.member_marketing_agreed == true ? '동의' : '비동의'}</div>
			                </div>
			                <div class="form-group">
			                    <label>토큰</label>
			                    <div class="form-value">${member.token}</div>
			                </div>
			                <div class="form-group">
			                    <label>메일 인증 상태</label>
			                    <div class="form-value">${member.mail_auth_status == true ? '인증됨' : '미인증'}</div>
			                </div>
			                <c:if test="${member.member_type_code eq 'MEM003'}">
				                <div class="form-group">
				                    <label>채용 담당자 이메일</label>
				                    <div class="form-value">${member.member_email}</div>
				                </div>
				                 <div class="form-group">
				                    <label>회사 인덱스</label>
				                    <div class="form-value">${member.company_idx}</div>
				                </div>
				                 <div class="form-group">
				                    <label>채용 담당자 번호</label>
				                    <div class="form-value">${member.recruiter_number}</div>
				                </div>
			                </c:if>
			                 <div class="form-group">
			                    <label>회원 상태</label>
			                    <div class="form-value">${member.member_status_name}</div>
			                </div>
			                <div class="form-group">
			                    <label>탈퇴일자</label>
			                    <div class="form-value">
			                    	<c:choose>
			                    		<c:when test="${member.member_withdrawal_date eq null}">
			                    			미탈퇴
			                    		</c:when>
			                    		<c:otherwise>
			                    			${member.member_withdrawal_date}
			                    		</c:otherwise>
			                    	</c:choose>
			                    </div>
			                </div>
			            </div>
			        </div>
		      
	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>
</body>
</html>
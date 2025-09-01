<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <title>관리자 공고 관리</title>

    <%-- 외부 라이브러리 CSS --%>
	<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMember.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminRecruitment.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/recruiterList.css">
    
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
	                    <li><a href="./adminMember" class="btn-yellow">회원 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminRecruitment" class="btn-yellow">공고 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminCommunity" class="btn-yellow">게시글 관리<!-- <span>▼</span> --></a></li>
<!-- 	                    <li><a href="./adminSupport" class="btn-yellow">고객 문의<span>▼</span></a></li> -->
<!-- 	                    <li><a href="./adminPayment" class="btn-yellow">결제 이력<span>▼</span></a></li> -->
	                    <li><a href="./comcodeRegist" class="btn-yellow">공통 코드 관리<!-- <span>▼</span> --></a></li>
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
	         	    <p class="header-text"><strong>공고 목록</strong></p>
	             </div>
		
		        <!-- 2. 필터 및 검색 바 -->
		        <div class="control-bar">
          			<div class="tab-container">
					  <div class="tab active">전체</div>
					  <div class="tab" data-value="RECS01">채용중인 공고</div>
					  <div class="tab" data-value="RECS02">마감된 공고</div>
					</div>
		        </div>
		
		        <!-- 3. 회원 목록 테이블 -->
		        <div id="grid" class="custom-grid"></div>
<!-- 		        <div class="table-wrapper"> -->
<!-- 		            <table> -->
<!-- 		                <thead> -->
<!-- 		                    <tr> -->
<!-- 		                        <th>No.</th> -->
<!-- 		                        <th>기업명</th> -->
<!-- 		                        <th>공고제목</th> -->
<!-- 		                        <th>등록일</th> -->
<!-- 		                        <th>마감일</th> -->
<!-- 		                        <th>등록자</th> -->
<!-- 		                        <th>조회수</th> -->
<!-- 		                        <th>관리</th> -->
<!-- 		                    </tr> -->
<!-- 		                </thead> -->
<!-- 		                <tbody> -->
<!-- 		                    반복될 데이터 행 (예시) -->
<!-- 		                    <tr> -->
<!-- 		                        <td>1</td> -->
<!-- 		                        <td>Samsung</td> -->
<!-- 		                        <td>경력, 신입 개발자 채용</td> -->
<!-- 		                        <td>2025-07-31</td> -->
<!-- 		                        <td>2025-08-30</td> -->
<!-- 		                        <td>이재용</td> -->
<!-- 		                        <td>30</td> -->
<!-- 		                        <td> -->
<!-- 		                            <a href="recruitmentDetail" class="btn btn-yellow">공고 상세보기</a> -->
<!-- 		                            <button class="btn btn-yellow">삭제</button> -->
<!-- 		                        </td> -->
<!-- 		                    </tr> -->
<!-- 		                    <tr> -->
<!-- 		                        <td>2</td> -->
<!-- 		                        <td>Hyundai</td> -->
<!-- 		                        <td>경력, 신입 개발자 채용</td> -->
<!-- 		                        <td>2025-07-31</td> -->
<!-- 		                        <td>2025-08-30</td> -->
<!-- 		                        <td>정주영</td> -->
<!-- 		                        <td>15</td> -->
<!-- 		                        <td> -->
<!-- 	                                <a href="recruitmentDetail" class="btn btn-yellow">공고 상세보기</a> -->
<!-- 	                                <button class="btn btn-yellow">삭제</button> -->
<!-- 		                        </td> -->
<!-- 		                    </tr> -->
<!-- 		                    ... 추가 데이터 행 ... -->
<!-- 		                </tbody> -->
<!-- 		            </table> -->
<!-- 		        </div> -->
	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>
	<%-- js 파일  --%>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script src="https://unpkg.com/gridjs/dist/gridjs.umd.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/commonJs.js"></script>    
	<script src="${pageContext.request.contextPath}/resources/js/admin/adminRecruitment.js"></script>    
</body>
</html>
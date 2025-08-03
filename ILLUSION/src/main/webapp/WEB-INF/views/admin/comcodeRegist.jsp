<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 메인페이지</title>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/dashboard.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
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
	                    <li><a href="./adminRecuritment" class="nav-item">공고 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminCommunity" class="nav-item">게시글 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminSupport" class="nav-item">고객 문의<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminPayment" class="nav-item">결제 이력<!-- <span>▼</span> --></a></li>
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
	                    <a href="#">로그아웃</a>
	                    <a href="#">사용자 화면</a>
	                </div>
	            </header>
	
	            <!-- 메인 콘텐츠가 표시될 영역 -->
	            <main class="admin-content">
	            
		        <!-- 1. 페이지 헤더 -->
		         <div class="page-title-header">
	         	    <p class="header-text"><strong>공통코드 목록</strong></p>
	             </div>
			
			        <!-- 2. 컨트롤 바 (검색, 추가/삭제 버튼) -->
			        <div class="control-bar">
			            <div class="search-box">
			                <input type="text" placeholder="코드ID, 코드명, 설명 검색">
			                <button type="button">🔍</button>
			            </div>
			            <div class="action-buttons-top">
			            	<a href="comcodeCommit" class="btn btn-add">공통코드 추가 ❐</a>
			                <button class="btn btn-delete-selected">공통코드 삭제 🗑️</button>
			            </div>
			        </div>
			        
			        <!-- 3. 공통코드 목록 테이블 -->
			        <div class="table-wrapper">
			            <table>
			                <thead>
			                    <tr>
			                        <th><input type="checkbox" id="check-all"></th>
			                        <th>No.</th>
			                        <th>코드타입ID</th>
			                        <th>코드타입명</th>
			                        <th>코드타입 설명</th>
			                        <th>공통코드ID</th>
			                        <th>공통코드명</th>
			                        <th>공통코드 설명</th>
			                        <th>사용여부</th>
			                        <th>순서</th>
			                        <th>관리</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <!-- 반복될 데이터 행 (예시) -->
			                    <tr>
			                        <td><input type="checkbox" class="row-check"></td>
			                        <td>1</td>
			                        <td>MEMBER_TYPE</td>
			                        <td>회원등급</td>
			                        <td>회원 등급 타입</td>
			                        <td>MEM001</td>
			                        <td>관리자</td>
			                        <td>관리자 회원 등급입니다.</td>
			                        <td>
			                            <label class="toggle-switch">
			                                <input type="checkbox" checked>
			                                <span class="slider"></span>
			                            </label>
			                        </td>
			                        <td>1</td>
			                        <td>
			                            <div class="action-buttons">
			                                <button class="btn btn-edit">수정</button>
			                                <button class="btn btn-delete">삭제</button>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <td><input type="checkbox" class="row-check"></td>
			                        <td>2</td>
			                        <td>MEMBER_TYPE</td>
			                        <td>회원등급</td>
			                        <td>회원 등급 타입</td>
			                        <td>MEM002</td>
			                        <td>일반회원</td>
			                        <td>일반 회원 등급입니다.</td>
			                        <td>
			                             <label class="toggle-switch">
			                                <input type="checkbox">
			                                <span class="slider"></span>
			                            </label>
			                        </td>
			                        <td>2</td>
			                        <td>
			                            <div class="action-buttons">
			                                <button class="btn btn-edit">수정</button>
			                                <button class="btn btn-delete">삭제</button>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <td><input type="checkbox" class="row-check"></td>
			                        <td>3</td>
			                        <td>GENDER</td>
			                        <td>성별</td>
			                        <td>성별 타입</td>
			                        <td>GEN001</td>
			                        <td>남</td>
			                        <td>남자</td>
			                        <td>
			                             <label class="toggle-switch">
			                                <input type="checkbox">
			                                <span class="slider"></span>
			                            </label>
			                        </td>
			                        <td>2</td>
			                        <td>
			                            <div class="action-buttons">
			                                <button class="btn btn-edit">수정</button>
			                                <button class="btn btn-delete">삭제</button>
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <td><input type="checkbox" class="row-check"></td>
			                        <td>4</td>
			                        <td>GENDER</td>
			                        <td>성별</td>
			                        <td>성별 타입</td>
			                        <td>GEN002</td>
			                        <td>여</td>
			                        <td>여자</td>
			                        <td>
			                             <label class="toggle-switch">
			                                <input type="checkbox">
			                                <span class="slider"></span>
			                            </label>
			                        </td>
			                        <td>2</td>
			                        <td>
			                            <div class="action-buttons">
			                                <button class="btn btn-edit">수정</button>
			                                <button class="btn btn-delete">삭제</button>
			                            </div>
			                        </td>
			                    </tr>
			                    <!-- ... 추가 데이터 행 ... -->
			                </tbody>
			            </table>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 회원 관리</title>

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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/comcodeCommit.css">
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
	                    <a href="./">로그아웃</a>
	                    <a href="./">사용자 화면</a>
	                </div>
	            </header>
	
	            <!-- 메인 콘텐츠가 표시될 영역 -->
	            <main class="admin-content">
	            
			        <form id="common-code-form">
			            
				        <!-- 1. 페이지 헤더 -->
				         <div class="page-title-header">
			         	    <p class="header-text"><strong>공통코드 목록</strong></p>
			             </div>
			
			            <!-- 2. 코드 타입 입력 섹션 -->
			            <div class="form-section">
			                <div class="form-group">
			                    <label for="code-type-id">코드 타입 ID</label>
			                    <input type="text" id="code-type-id" placeholder="코드타입 입력">
			                </div>
			                <div class="form-group">
			                    <label for="code-type-name">코드 타입 명</label>
			                    <input type="text" id="code-type-name" placeholder="코드 타입 명 입력">
			                </div>
			                <div class="form-group">
			                    <label for="code-type-desc">설명 입력</label>
			                    <input type="text" id="code-type-desc" placeholder="설명 입력">
			                </div>
			            </div>
			
			            <hr class="divider">
			
			            <!-- 3. 공통 코드 입력 섹션 (동적 테이블) -->
			            <div class="form-section">
			                <div class="table-header">
			                    <h3>공통 코드 입력</h3>
			                    <div class="table-controls">
			                        <button type="button" class="btn btn-add-row">행추가</button>
			                        <button type="button" class="btn btn-delete-row">삭제</button>
			                    </div>
			                </div>
			                
			                <div class="table-wrapper">
			                    <table>
			                        <thead>
			                            <tr>
			                                <th><input type="checkbox" id="check-all-rows"></th>
			                                <th>No.</th>
			                                <th>공통코드 ID 입력</th>
			                                <th>공통코드 명</th>
			                                <th>설명</th>
			                            </tr>
			                        </thead>
			                        <tbody id="common-code-tbody">
			                            <!-- JavaScript로 동적으로 추가될 행의 시작점 -->
			                            <tr>
			                                <td><input type="checkbox" class="row-check"></td>
			                                <td class="row-num">1</td>
			                                <td><input type="text" placeholder="공통 코드 ID 입력"></td>
			                                <td><input type="text" placeholder="공통 코드 명 입력"></td>
			                                <td><input type="text" placeholder="설명 입력"></td>
			                            </tr>
			                        </tbody>
			                    </table>
			                </div>
			            </div>
			
			            <!-- 4. 최종 등록 버튼 -->
			            <div class="form-actions">
			                <button type="submit" class="btn btn-submit">등록하기</button>
			            </div>
			
			        </form>

	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>
	
	<script src="common-code-form.js"></script>
</body>
</html>
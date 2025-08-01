<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 게시글 관리</title>

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
	         	    <p class="header-text"><strong>게시판 관리목록</strong></p>
	             </div>
		
		        <!-- 2. 필터 및 검색 바 -->
		        <div class="control-bar">
		            <div class="filters">
		                <div class="filter-group view-options">
		                    <select name="view-count" id="view-count">
		                        <option value="10">10</option>
		                        <option value="30">30</option>
		                        <option value="50">50</option>
		                    </select>
		                    <span>건씩 보기</span>
		                </div>
		                <div class="filter-group">
		                    <span class="filter-title">게시글 성격</span>
		                    <label><input type="radio" name="user-type" value="all" checked> 전체</label>
		                    <label><input type="radio" name="user-type" value="personal"> 면접후기</label>
		                    <label><input type="radio" name="user-type" value="corporate"> 직무QnA</label>
		                    <label><input type="radio" name="user-type" value="admin"> 자유</label>
		                </div>
		            </div>
		            <div class="search-box">
		                <input type="text" placeholder="제목, 작성자 기준으로 검색">
		                <button type="button">🔍</button>
		            </div>
		        </div>
		
		        <!-- 3. 회원 목록 테이블 -->
		        <div class="table-wrapper">
		            <table>
		                <thead>
		                    <tr>
		                        <th>No.</th>
		                        <th>게시글 성격</th>
		                        <th>제목</th>
		                        <th>작성자</th>
		                        <th>작성일</th>
		                        <th>관리</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <!-- 반복될 데이터 행 (예시) -->
		                    <tr>
		                        <td>1</td>
		                        <td>전체</td>
		                        <td>안녕하세요</td>
		                        <td>김교촌</a></td>
		                        <td>2025-07-31</td>
		                        <td>
		                            <div class="action-buttons">
		                                <button class="btn btn-view">작성글 보기</button>
		                                <button class="btn btn-delete">삭제</button>
		                            </div>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td>2</td>
		                        <td>면접 후기</td>
		                        <td>네이버 면접 후기입니다.</td>
		                        <td>김교촌</a></td>
		                        <td>2025-08-31</td>
		                        <td>
		                            <div class="action-buttons">
		                                <button class="btn btn-view">작성글 보기</button>
		                                <button class="btn btn-delete">삭제</button>
		                            </div>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td>3</td>
		                        <td>직무 QnA</td>
		                        <td>백엔드 관련 질문입니다</td>
		                        <td>박집에가고싶</a></td>
		                        <td>2025-08-01</td>
		                        <td>
		                            <div class="action-buttons">
		                                <button class="btn btn-view">작성글 보기</button>
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
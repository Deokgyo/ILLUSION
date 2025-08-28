<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공통 코드 추가</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminMain.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/comcodeCommit.css">
</head>
<body>
	<div class="main-container">
	    <div class="admin-wrapper">
	        <aside class="admin-sidebar">
	            <div class="sidebar-header">
	                <a href="./adminMain" class="logo">
	                    <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="ILLUSION Logo" />
	                </a>
	            </div>
	            <nav class="sidebar-nav">
	                <ul>
	                    <li><a href="./adminMember">회원 관리</a></li>
	                    <li><a href="./adminRecruitment">공고 관리</a></li>
	                    <li><a href="./adminCommunity">게시글 관리</a></li>
	                    <li><a href="./adminSupport">고객 문의</a></li>
	                    <li><a href="./adminPayment">결제 이력</a></li>
	                    <li><a href="./comcodeRegist">공통 코드 관리</a></li>
	                </ul>
	            </nav>
	        </aside>
	
	        <div class="main-content-area">
	            <header class="admin-header">
	                <div class="user-actions">
	                    <a href="./">로그아웃</a>
	                    <a href="./">사용자 화면</a>
	                </div>
	            </header>
	
	            <main class="admin-content">

				    <!-- 1. 페이지 헤더 -->
				    <div class="page-title-header">
				        <p class="header-text"><strong>공통코드 추가</strong></p>
				    </div>
				
				    <!-- 2. 공통코드 그룹 추가 섹션 -->
				    <div class="form-section-wrapper">
				        <h3>공통코드 그룹 추가</h3>
				        <form id="group-form" action="addCommonCodeGroup" method="post">
				            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				            <div class="form-group-wrapper">
				                <div class="form-group">
				                    <label for="code_group_id">그룹 ID</label>
				                    <input type="text" id="code_group_id" name="code_group_id" placeholder="예: member_type" required>
				                </div>
				                <div class="form-group">
				                    <label for="group_name">그룹명</label>
				                    <input type="text" id="group_name" name="group_name" placeholder="예: 회원 유형" required>
				                </div>
				                <div class="form-group flex-grow-2">
				                    <label for="description">설명</label>
				                    <input type="text" id="description" name="description" placeholder="그룹에 대한 설명" required>
				                </div>
				                <div class="form-actions-inline">
				                    <button type="submit" class="btn btn-yellow">그룹 저장</button>
				                </div>
				            </div>
				        </form>
				    </div>
				
				    <hr class="divider">
				
				    <!-- 3. 공통 코드 추가 섹션 -->
				    <div class="form-section-wrapper">
				        <h3>공통 코드 추가</h3>
				        <form id="code-form" action="addCommonCodes" method="post">
				            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				            <div class="table-wrapper">
				                <table id="code-table">
				                    <thead>
				                        <tr>
				                            <th>그룹 ID</th>
				                            <th>코드 ID</th>
				                            <th>코드명</th>
				                            <th>부모 코드 ID</th>
				                            <th>삭제</th>
				                        </tr>
				                    </thead>
				                    <tbody id="code-table-body">
				                        <!-- jQuery로 행이 추가될 영역 -->
				                    </tbody>
				                </table>
				            </div>
				            <div class="table-controls">
				                <button type="button" id="btn-add-row" class="btn btn-yellow">행 추가</button>
				                <button type="submit" class="btn btn-submit">선택된 코드 저장</button>
				            </div>
				        </form>
				    </div>
				
				</main>
				
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>

	<!-- 행 추가를 위한 템플릿 -->
	<template id="code-row-template">
	    <tr>
	        <td>
	            <select class="form-control code-group-id" required>
	                <option value="">그룹 선택</option>
	                <c:forEach var="group" items="${codeGroups}">
	                    <option value="${group.code_group_id}">${group.group_name} (${group.code_group_id})</option>
	                </c:forEach>
	            </select>
	        </td>
	        <td><input type="text" class="form-control code" placeholder="예: mem001" required></td>
	        <td><input type="text" class="form-control code-name" placeholder="예: 관리자" required></td>
	        <td><input type="text" class="form-control parent-code-id" placeholder="(선택 사항)"></td>
	        <td><button type="button" class="btn btn-danger btn-sm btn-remove-row">삭제</button></td>
	    </tr>
	</template>

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/admin/comcodeCommit.js"></script>
</body>
</html>
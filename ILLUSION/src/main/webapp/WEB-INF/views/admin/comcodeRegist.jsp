<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공통 코드 관리</title>

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
	                    <li><a href="./adminRecuritment" class="btn-yellow">공고 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminCommunity" class="btn-yellow">게시글 관리<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminSupport" class="btn-yellow">고객 문의<!-- <span>▼</span> --></a></li>
	                    <li><a href="./adminPayment" class="btn-yellow">결제 이력<!-- <span>▼</span> --></a></li>
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
	         	    <p class="header-text"><strong>공통코드 목록</strong></p>
	             </div>
			
			        <!-- 2. 컨트롤 바 (검색, 추가/삭제 버튼) -->
			        <div class="control-bar">
			            <form action="comcodeRegist" method="get" class="search-box">
			                <input type="text" name="keyword" placeholder="코드ID, 코드명, 설명 검색" value="${param.keyword}">
			                <button type="submit">🔍</button>
			            </form>
			            <div class="action-buttons-top">
			            	<a href="comcodeCommit" class="btn btn-yellow">공통코드 추가 ❐</a>
			            </div>
			        </div>
			        
			        <!-- 3. 공통코드 목록 테이블 -->
			        <div class="table-wrapper">
			            <table>
			                <thead>
			                    <tr>
			                        <th>No.</th>
			                        <th>코드타입ID</th>
			                        <th>코드타입명</th>
			                        <th>공통코드ID</th>
			                        <th>공통코드명</th>
			                        <th>공통코드 설명</th>
			                        <th>관리</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <!-- 반복될 데이터 행 (예시) -->
			                    <c:forEach var="com" items="${commonCodeList }" varStatus="status">
			                    	<tr>
				                        <td>${status.index + 1 }</td>
				                        <td>${com.code_group_id }</td>
				                        <td>${com.group_name }</td>
				                        <td>${com.code }</td>
				                        <td>${com.code_name }</td>
				                        <td>${com.description }</td>
				                        <td>
				                            <div class="action-buttons">
				                            	<a href="comcodeModify?code=${com.code}" class="btn btn-yellow">수정</a>
           										<a href="javascript:void(0);" onclick="confirmDelete('${com.code}')" class="btn btn-yellow">삭제</a>
				                            </div>
				                        </td>
				                    </tr>
			                    </c:forEach>
			                </tbody>
			            </table>
			        </div>
			        
				<!-- 페이지네이션 -->
				<nav class="pagination">
				    <!-- 첫 페이지 버튼, 10페이지 감소 버튼 -->
				    <c:if test="${pageInfo.pageNum > 1}">
				    	<c:url var="pageUrl" value="comcodeRegist">
				    		<c:param name="pageNum" value="1"></c:param>
				    		<c:if test="${not empty param.keyword }">
								<c:param name="keyword" value="${param.keyword }" />
							</c:if>
				    	</c:url>
				    	<a href="${pageUrl}">&laquo;</a>
				    	
				    	<c:url var="pageUrl" value="comcodeRegist">
							<c:param name="pageNum" value="${pageInfo.pageNum - 10}"></c:param>
							<c:if test="${not empty param.keyword }">
								<c:param name="keyword" value="${param.keyword }" />
							</c:if>
						</c:url>
						<a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">&lsaquo;</a>
				    </c:if>
					
					<!-- 이전페이지 버튼 10씩 감소 -->				    
<%-- 				    <c:if test="${pageInfo.startPage > 1 }"> --%>
<%-- 				    	<c:url var="pageUrl" value="comcodeRegist"> --%>
<%-- 							<c:param name="pageNum" value="${pageInfo.pageNum - 10}"></c:param> --%>
<%-- 							<c:if test="${not empty param.keyword }"> --%>
<%-- 								<c:param name="keyword" value="${param.keyword }" /> --%>
<%-- 							</c:if> --%>
<%-- 						</c:url> --%>
<%-- 						<a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">&lsaquo;</a> --%>
<%-- 				    </c:if> --%>
				    
				    <!-- 페이지 번호 -->
				    <c:forEach var="i" begin="${pageInfo.startPage}" end="${pageInfo.endPage}">
					    <c:url var="pageUrl" value="comcodeRegist">
					        <c:param name="pageNum" value="${i}" />

							<c:if test="${not empty param.keyword }">
								<c:param name="keyword" value="${param.keyword }" />
							</c:if>
					    </c:url>
					    <a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">${i}</a>
					</c:forEach>
					
					<!-- 다음 페이지 버튼 10씩 증가 , 마지막 페이지 버튼 -->
					<c:if test="${pageInfo.endPage < pageInfo.maxPage}">
				    	<c:url var="pageUrl" value="comcodeRegist">
							<c:param name="pageNum" value="${pageInfo.pageNum + 10 > pageInfo.maxPage ? pageInfo.maxPage : pageInfo.pageNum + 10}"></c:param>
							<c:if test="${not empty param.keyword }">
								<c:param name="keyword" value="${param.keyword }" />
							</c:if>
						</c:url>
						<a href="${pageUrl}" class="${i == pageInfo.pageNum ? 'active' : ''}">&rsaquo;</a>
						
						<c:url var="pageUrl" value="comcodeRegist">
				    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param>
				    		<c:if test="${not empty param.keyword }">
								<c:param name="keyword" value="${param.keyword }" />
							</c:if>
				    	</c:url>
		    		    <a href="${pageUrl}">&raquo;</a>
					</c:if>
					
<!-- 				    마지막 페이지 버튼 -->
<%-- 				    <c:if test="${pageInfo.pageNum < pageInfo.maxPage}"> --%>
<%-- 				    	<c:url var="pageUrl" value="comcodeRegist"> --%>
<%-- 				    		<c:param name="pageNum" value="${pageInfo.maxPage }"></c:param> --%>
<%-- 				    		<c:if test="${not empty param.keyword }"> --%>
<%-- 								<c:param name="keyword" value="${param.keyword }" /> --%>
<%-- 							</c:if> --%>
<%-- 				    	</c:url> --%>
<%-- 		    		    <a href="${pageUrl}">&raquo;</a> --%>
<%-- 				    </c:if> --%>
				</nav>
	            </main>
	            
	            <!-- 메인 푸터 -->
	            <footer class="admin-footer">
	                <p>※ 이 페이지는 관리자 전용입니다. 무단 접근 시 법적 처벌을 받을 수 있습니다. 접속 기록을 위해 저장됩니다.</p>
	                <p>© 2025 ILLUSION. All rights reserved.</p>
	            </footer>
	        </div>
	    </div>
	</div>

<script>
function confirmDelete(code) {
    if (confirm("정말로 이 공통 코드를 삭제하시겠습니까?")) {
        window.location.href = "comcodeDelete?code=" + code;
    }
}
</script>
</body>
</html>
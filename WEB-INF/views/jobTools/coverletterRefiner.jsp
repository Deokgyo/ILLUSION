<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채용의 모든 솔루션, 일루션에서 시작됩니다</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/coverletterRefiner.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/inc/top.jsp" />
    <c:if test="${not empty sessionScope.loginUser}">
        <input type="hidden" id="currentUserToken" value="${sessionScope.loginUser.token}">
    </c:if>

    <div class="page-container">
        <jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
        <main class="main-content">
            <div class="page-title-header">
                <p class="header-text"><strong>자기소개서 다듬기</strong></p>
            </div>
            <div class="refiner-box">
                <nav class="refiner-tabs-nav">
                    <a href="#" class="tab-link active" data-tab="panel-new-resume">새 자소서 다듬기</a>
                    <a href="#" class="tab-link" data-tab="panel-saved-resume">저장된 자소서</a>
                </nav>

                <div class="tabs-content">
                    <!-- 새 자소서 다듬기 -->
					<div id="panel-new-resume" class="tab-panel active">
					    <form id="new-refine-form" action="coverletterResult" method="post" enctype="multipart/form-data">
					        
					        <div id="section-file-upload" class="input-method-section">
					            <label for="check-file-upload" class="section-header">
					                <input type="radio" class="radiobox" name="cl_input_method" id="check-file-upload" value="file" checked/>
					                <span>파일 업로드</span>
					            </label>
					           	<div class="title_company">
			                    	<div class="input">
			                    		<span><i class="icon fa-regular fa-pen-to-square icon"></i>자소서 제목</span>
			                    		<input name="cl_title" class="title_file" placeholder="자소서 제목을 입력해주세요">
			                    	</div>  
			                    	<hr class="divider">
			                    	<div class="input">
			                    		<span><i class="bi bi-building icon"></i>지원하는 회사</span>
			                    		<input name="company_name" class="company_file" placeholder="지원하는 회사를 입력해주세요">
			                    	</div>
	                    	    </div>
					            <div class="content-area">
					                <div class="drop-zone">
					                    <div class="drop-zone-icon"><i class="fa-regular fa-folder-open" style="color: var(--main-color)"></i></div>
					                    <p class="drop-zone-text">파일을 끌어 놓거나 클릭하여 선택 하세요 <br>(txt, pdf, doc, docx, hwp 파일형식만 업로드 가능)</p>
					                </div>
				                    <input type="file" id="file-input-hidden" name="uploadedFile" style="display:none;"/>
					            </div>
					        </div>
					
					        <div id="section-direct-input" class="input-method-section disabled">
					            <label for="check-direct-input" class="section-header">
					                <input type="radio" class="radiobox" name="cl_input_method" id="check-direct-input" value="text"/>
					                <span>자기소개서 내용</span>
					            </label>
					            <div class="title_company">
			                    	<div class="input">
			                    		<span><i class="icon fa-regular fa-pen-to-square icon"></i>자소서 제목</span>
			                    		<input name="cl_title" class="title_direct" placeholder="자소서 제목을 입력해주세요">
			                    	</div>  
			                    	<hr class="divider">
			                    	<div class="input">
			                    		<span><i class="bi bi-building icon"></i>지원하는 회사</span>
			                    		<input name="company_name" class="company_direct" placeholder="지원하는 회사를 입력해주세요">
			                    	</div>
	                    	    </div>
					            <div class="content-area">
					                <div class="textarea-wrapper">
					                    <textarea id="direct-input-textarea" name="coverletterText" placeholder="자기소개서 내용을 입력하세요"></textarea>
					                    <div class="char-counter">0 단어 | 0 글자</div>
					                </div>
					            </div>
					        </div>
					    </form>
					</div>

                    <!-- 저장된 자소서 -->
					<div id="panel-saved-resume" class="tab-panel">
					    <div class="resume-list">
					        <c:forEach var="cl" items="${clList}" varStatus="status">
					            <div class="resume-item" data-id="${cl.cl_idx}" data-title="${cl.cl_title}">
					                <div class="content-area">
					                    <span class="icon">📄</span>
					                    <!-- -->
					                    <c:choose>
					                        <c:when test="${not empty cl.original_cl_idx && cl.original_cl_idx != 0}">
					                            <a href="coverletterResult?cl_idx=${cl.cl_idx}&original_cl_idx=${cl.original_cl_idx}" class="title-link">
					                                <span class="title">${cl.cl_title} - ${cl.company_name}</span>
					                            </a>
					                        </c:when>
					                        <c:otherwise>
					                            <a href="coverletterResult?cl_idx=${cl.cl_idx}&original_cl_idx=${cl.cl_idx}" class="title-link">
					                                <span class="title">${cl.cl_title} - ${cl.company_name}</span>
					                            </a>
					                        </c:otherwise>
					                    </c:choose>
					                </div>
					            </div>
					        </c:forEach>
					    </div>
					</div>
                </div>

                <div class="submit-button-wrapper">
                    <button id="refine-submit-btn" class="gradient-btn">자기소개서 다듬기</button>
                </div>
            </div>
        </main>
    </div>

    <footer><jsp:include page="/WEB-INF/views/inc/bottom.jsp" /></footer>
    <jsp:include page="/WEB-INF/views/jobTools/aiToolsModal.jsp"></jsp:include>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/coverletterRefiner.js"></script>
</body>
</html>
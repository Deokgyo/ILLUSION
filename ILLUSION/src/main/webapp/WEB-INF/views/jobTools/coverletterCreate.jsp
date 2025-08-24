<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>자기소개서 생성기</title>

    <%-- 외부 라이브러리 CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"> 

    <%-- 우리가 만든 CSS 파일들 --%>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sidebar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bottom.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/components.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/top.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jobTools/coverletterCreate.css"> 


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
                <p class="header-text"><strong>자기소개서 생성기 </strong> AI가 당신의 경험을 참고하여 매력적인 이력서를 만들어 드립니다.</p>
            </div>
            <div class="form-box">
                <form action="coverletterGenerate" method="POST" id="coverletter-form">
                

					<!--제목 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-pen-to-square"></i>
                            <h3 class="title">제목</h3>
                        </div>
                        <input type="text" name="title" class="form-control" placeholder="예: 삼성전자 마케팅 직무 자기소개서" />
                    </div>

					<!-- 기업명 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-regular fa-building"></i>
                            <h3 class="title">기업명</h3>
                        </div>
                        <input type="text" name="company" class="form-control" placeholder="예: 삼성전자"  />
                    </div>

					<section class="occupation-section">
						<div class="section-header">
							<i class="icon fa-regular fa-square-check"></i>
							<h3 class="title">직무 선택</h3>
						</div>
						<div class="category-grid">
							<div class="category-column">
								<h4 class="col-title">직무 카테고리</h4>
								<div class="category-options" id="occupations">
									<c:forEach var="occupation" items="${occupationList}">
										<div class="option-btn occupation"
											data-value="${occupation.code}">${occupation.code_name}</div>
									</c:forEach>
								</div>
							</div>
							<div class="category-column">
								<h4 class="col-title">세부 직무</h4>
								<div class="category-options" id="jobs"></div>
							</div>
						</div>
						<div class="detailed-job-selection">
							<div class="detailed-job-title">선택한 직무</div>
							<div class="selected-tags-area"></div>
						</div>
						<input type="hidden" id="selected-occupation" class="valid" name="occupation">
					</section>

					<!-- 경력사항 섹션 -->
					<div class="form-section">
					    <div class="section-header">
					        <i class="icon fa-regular fa-comments"></i>
					        <h3 class="title">경력사항</h3>
					    </div>
					    
					    <div id="experience-toggle" class="segmented-control">
					        <div class="option" data-value="new">신입</div>
					        <div class="option active" data-value="experienced">경력</div>
					    </div>
					
					    <div id="experience-fields" class="mt-3">
					        
						    <div class="dropdown-wrapper">
						        <div id="experience-level-select" class="form-control dropdown-select">
						            <span>경력 기간 선택</span>
						            <i class="fa-solid fa-chevron-down"></i>
						        </div>
						        <div class="form-dropdown-menu">
						            <c:forEach var="exp" items="${expList}">
						                <div class="form-dropdown-item" data-value="${exp.code}">${exp.code_name}</div>
						            </c:forEach>
						        </div>
						    </div>
						    
						    <input type="hidden" name="experience_period" id="experience-level-value">
						    
						    <input type="text" name="prevCompany" class="form-control mt-2" placeholder="이전 회사명" />
						    <input type="text" name="prevJob" class="form-control mt-2" placeholder="직책/직무" />
						
						    <textarea name="experience" class="form-control mt-2" rows="5"  style="resize: none;"
						              placeholder="수행했던 프로젝트, 성과, 보유 기술 등 AI가 참고할 핵심 경험과 역량을 구체적으로 작성해주세요."></textarea>
						    
						
						</div>
					</div>

					<!-- AI 생성 요구사항 섹션 -->
                    <div class="form-section">
                        <div class="section-header">
                            <i class="icon fa-solid fa-list-ul"></i>
                            <h3 class="title">AI 생성 요구사항</h3>
                        </div>
                        <input type="number" name="maxLength" class="form-control mb-2" placeholder="글자 수 (예: 1000)" />
                        <input type="text" name="keywords" class="form-control mb-2" placeholder="핵심 단어 (예: 문제해결능력, 리더십, 꼼꼼함)" />
                        <textarea name="question" class="form-control" rows="3" placeholder="문항 제목 (예: 지원 동기를 작성해주세요)"></textarea>
                    </div>

                    <div class="text-center mt-5">
	                    <div class="buttons">
	    					<button type="submit" class="gradient-btn" id="generate-btn">자기소개서 생성</button>
						</div>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
    <jsp:include page="/WEB-INF/views/jobTools/aiToolsModal.jsp"></jsp:include>
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jobTools/coverletterCreate.js"></script>
</body>
</html>
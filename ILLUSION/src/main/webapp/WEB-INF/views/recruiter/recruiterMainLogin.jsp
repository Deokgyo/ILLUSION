<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%-- 
	작성자 : 박덕교 
	용도 : 채용 공고 등록 폼 
	작성일 : 25-07-08
	수정일 : 25-07-08

 --%>
<html>
<head>
    <%-- 외부 라이브러리 CSS --%>
    
    <%-- 우리가 만든 CSS 파일들 --%>
    <link rel="stylesheet" href="./resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">
    <link rel="stylesheet" href="./resources/css/top.css">
    <link rel="stylesheet" href="./resources/css/bottom.css">
    <link rel="stylesheet" href="./resources/css/recruiter/recruiterMain2.css">
    <link rel="stylesheet" href="./resources/css/components.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript">
		 $(document).ready(function(){
	         // id가 goList인 버튼에 클릭 이벤트 추가
	         $('#goList').click(function() {
	             // 원하는 URL로 이동
	             location.href = 'recruiterList';
	         });
	     });
	</script>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
	<title>Home</title> <%-- 문구 수정 --%>
	<link rel="icon" href="/favicon.ico" type="image/x-icon"> <%-- 사진추가 --%>
	<%-- --------------- 브라우저 볼때 탭 영역 ----------- --%>
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp" />
	</header>
	
	<main>
		<%-- 메인 상단 공고현황 & 프로필 정보 묶음 --%>
			<%-- 페이지 상단 공고현황 섹션 --%>
			<section class="recruit-info-section section-container">
				<div class="section-name">
				  	<p>현재 상황을 한눈에 보세요!</p>
				</div>
				<div class="dash-container">
					<div class="section-dash01">
					  <%-- 대시보드 안내문구 --%>
					  <div class="section-content">
					  	<h1>공고 현황</h1>
					  	<p>진행중 공고</p>
					  	<h2>${RecruitmentCnt}</h2>
						<hr>				  	
					  	<p>미열람 이력서</p>
					  	<h2>${unViewedCnt}</h2>
					  </div>
					</div>
					<div class="section-dash01">
						<div class="section-content">
							<div class="rec-title">
								<h1>공고목록</h1>
							</div>
							<div class="rec-list">
								<c:forEach var="r" items="${recruitmentSubjectDate}">
									<a href="recruitmentDetail?recruit_idx=${r.recruit_idx}">${r.recruit_subject}${r.end_date} 
										<i class="fa fa-angle-right"></i>
									</a>
								</c:forEach>
							</div>
							<input type="button" value="전체 공고 목록" class="gradient-btn" id="goList">
						</div>
					</div>
					<%-- 페이지 상단 프로필 정보 --%>
					<div class="section-dash02">
						<div class="section-content">
							<p class="company-name">${RecruiterInfo.company_name}</p>
							<h2>
							  <span class="name-highlight">${RecruiterInfo.member_name}</span>님
							</h2>
							
						<%-- 연락처 정보 --%>
						<dl class="contact-info">
						  <%-- 각 정보 행을 div.info-row로 감싸줍니다 --%>
						  <div class="info-row">
						    <dt>e-mail</dt>
						    <dd>${RecruiterInfo.member_email}</dd>
						  </div>
						</dl>
						
						<!-- 구분선 -->
						<hr class="divider">
						
						<%-- 통계 정보 --%>
						<div class="stats-info">
						  <dl class="stats-list">
						    <%-- 각 정보 행을 div.info-row로 감싸줍니다 --%>
						    <div class="info-row">
						      <dt>총 지원자 수</dt>
						      <dd>${totalAppCnt}명</dd>
						    </div>
						    <div class="info-row">
						      <dt>진행중 공고</dt>
						      <dd>${RecruitmentCnt}건</dd>
						    </div>
						    <div class="info-row">
						      <dt>마감임박 공고</dt>
						      <dd>${RecruiterInfo.closing_soon_count}건</dd> 
						    </div>
						  </dl>
						</div>
						  <!-- 3. 액션 버튼 -->
						  <a href="memberModify" class="gradient-btn">회원 정보 수정</a>
							</div>
						</div>
				</div>
			</section>
			
		<%-- 페이지 상단 공고현황 섹션 끝--%>
		
		
	<section class="company-fit-section">
	    <div class="section-name">
	        <p>미열람 이력서</p>
	    </div>
	    
	    <%-- 카드들 담는 컨테이너 --%>
	    <div class="cards-container">
	    
	       		<%-- 카드 1 --%>
			    	<c:forEach var="info" items="${resumeInfo}">
					    <div class="card">
			    		<div class="card-title">
		            		<h1>${info.resume_title }</h1>
		            	</div>
		            	<div class="card-content">
		                    <p>
		                        경력 : ${info.experience_name }<br>
		                        학력 : ${info.degree_name } | ${info.major}<br>
		                        거주지 : ${info.address }
		                    </p>
	                	</div>
	                	<input type="button" class="gradient-btn" onclick="location.href='viewResume?resume_idx=${info.resume_idx}&member_idx=${info.member_idx}&apply_idx=${info.apply_idx}'" value="이력서 보기">
	       				</div>
			    	</c:forEach>
            
<%-- 	       		카드 2 --%>
<!-- 			    <div class="card"> -->
<!-- 		        	<div class="card-title"> -->
<!-- 		            	<h1>문제 해결에 강한 백엔드 개발자</h1> -->
<!-- 		            </div> -->
<!-- 		            <div class="card-content"> -->
<!-- 	                    <p> -->
<!-- 	                        경력 : 2년<br> -->
<!-- 	                        학력 : 대졸 | 컴퓨터공학과<br> -->
<!-- 	                        거주지 : 부산 -->
<!-- 	                    </p> -->
<!-- 	                </div> -->
<!-- 	            	<input type="button" class="gradient-btn" value="이력서보기"> -->
<!-- 	       		</div> -->
	            
<%-- 	       		카드 3 --%>
<!-- 			    <div class="card"> -->
<!-- 		               <div class="card-title"> -->
<!-- 		                    <h1>문제 해결에 강한 백엔드 개발자</h1> -->
<!-- 		                </div> -->
<!-- 		                <div class="card-content"> -->
<!-- 		                    <p> -->
<!-- 		                        경력 : 2년<br> -->
<!-- 		                        학력 : 대졸 | 컴퓨터공학과<br> -->
<!-- 		                        거주지 : 부산 -->
<!-- 		                    </p> -->
<!-- 		                </div> -->
<!-- 	            	<input type="button" class="gradient-btn" value="이력서보기"> -->
<!-- 		        </div> -->
<%-- 	       		카드 4 --%>
<!-- 		        <div class="card"> -->
<!-- 		               <div class="card-title"> -->
<!-- 		                    <h1>문제 해결에 강한 백엔드 개발자</h1> -->
<!-- 		                </div> -->
<!-- 		                <div class="card-content"> -->
<!-- 		                    <p> -->
<!-- 		                        경력 : 2년<br> -->
<!-- 		                        학력 : 대졸 | 컴퓨터공학과<br> -->
<!-- 		                        거주지 : 부산 -->
<!-- 		                    </p> -->
<!-- 		                </div> -->
<!-- 	            	<input type="button" class="gradient-btn" value="이력서보기"> -->
<!-- 		        </div> -->
<%-- 	        	카드 5 --%>
<!-- 		        <div class="card"> -->
<!-- 		               <div class="card-title"> -->
<!-- 		                    <h1>문제 해결에 강한 백엔드 개발자</h1> -->
<!-- 		                </div> -->
<!-- 		                <div class="card-content"> -->
<!-- 		                    <p> -->
<!-- 		                        경력 : 2년<br> -->
<!-- 		                        학력 : 대졸 | 컴퓨터공학과<br> -->
<!-- 		                        거주지 : 부산 -->
<!-- 		                    </p> -->
<!-- 		                </div> -->
<!-- 	            	<input type="button" class="gradient-btn" value="이력서보기"> -->
<!-- 		        </div> -->
<%-- 	        	카드 6 --%>
<!-- 		        <div class="card"> -->
<!-- 		               <div class="card-title"> -->
<!-- 		                    <h1>문제 해결에 강한 백엔드 개발자</h1> -->
<!-- 		                </div> -->
<!-- 		                <div class="card-content"> -->
<!-- 		                    <p> -->
<!-- 		                        경력 : 2년<br> -->
<!-- 		                        학력 : 대졸 | 컴퓨터공학과<br> -->
<!-- 		                        거주지 : 부산 -->
<!-- 		                    </p> -->
<!-- 		                </div> -->
<!-- 	            	<input type="button" class="gradient-btn" value="이력서보기"> -->
<!-- 		        </div> -->
			</div>
		</section>
		
		<%--메인 하단 5가지 팁 --%>
		<section class="tip-section">
			<div class="section-name">
			  	<p>좋은 인재를 고르는 4가지 팁</p>
			</div>
			  	<hr>
				<div class="tips-container">
				    <div class="tip">
				        <h3>1. 핵심 역량에 집중하세요</h3>
				        <p>우리 회사가 필요로 하는 기술과 경험을 갖춘 지원자인지 확인해보세요.</p>
				    </div>			
				    <div class="tip">
				        <h3>2. 직무 이해도가 높은 지원자를 찾으세요</h3>
				        <p>단순히 자격 조건만 보는 것이 아니라, 해당 직무에 대한 열정과 이해도가 있는지를 체크하세요.</p>
				    </div>			
				    <div class="tip">
				        <h3>3. 장기적인 성장 가능성을 고려하세요</h3>
				        <p>지금 당장 잘하는 인재보다, 회사와 함께 성장할 수 있는 가능성 있는 인재를 눈여겨보세요.</p>
				    </div>			
				    <div class="tip">
				        <h3>4. 회사 문화에 어울리는 사람인지 판단하세요</h3>
				        <p>실력도 중요하지만, 조직과 잘 어울릴 수 있는 사람인지도 좋은 인재를 판단하는 중요한 기준입니다.</p>
				    </div>			
				</div>	
		</section>
		<%--메인 하단 5가지 팁 끝--%>
		
	</main>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
</body>
</html>

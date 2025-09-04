<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>채용의 모든 솔루션, 일루션에서 시작됩니다.</title>
	<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="stylesheet" href="./resources/css/layout.css">
	<link rel="stylesheet" href="./resources/css/recruiter/recruiterMain.css">
	<link rel="stylesheet" href="./resources/css/top.css">
    <jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp"></jsp:include>
    <%-- 효과를 위한 aos 라이브러리 --%>
	<link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
	<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
    	<script>
     		 AOS.init({
		        duration: 700, // 애니메이션 지속 시간 (ms)
		        once: false
			 });
		</script>
</head>
<body>
    <div class="wrapper">
        <!-- 메인 컨텐츠 -->
        <main>
            <%--배너 섹션 --%> 
            <section class="hero-section section-container">
            
    			<!-- 배경에 희미하게 보이는 텍스트 -->
			    <div class="background-text">ILLUSION</div>
			
			    <!-- 실제 콘텐츠 영역 -->
			    <div class="hero-content">
			        <h1 class="hero-title">
			            유능한 인재의 발견<br>
			            ILLUSION이 함께합니다
			        </h1>
			        <p class="hero-subtitle">스마트한 채용 일루션, 지금 시작하세요</p>
			        <sec:authorize access="isAnonymous()">
				        <div class="hero-buttons">
				            <a href="login" class="btn btn-login">로그인</a>
				            <a href="register" class="btn btn-signup">회원가입</a>
				        </div>
			        </sec:authorize>
			    </div>
			</section>
            
             <!-- 채용 공고 등록 섹션 -->
             <section class="features-section section-container">
			    <h1 class="section-title" data-aos="fade-up">지금 채용 공고를 등록하고 관리하며 인재를 만나보세요</h1>
			
			    <div class="features-grid" >
			        <!-- 첫 번째 기능: 쉽고 빠른 채용 공고 -->
			        <div class="feature-item" data-aos="fade-up">
			          <div class="icon-background icon-clipboard" data-aos="fade-up"></div>
			            <div class="feature-card">
			                <h2>쉽고 빠른 채용 공고</h2>
			                <p>일루션에서 시작하는 스마트한 채용. 공고 등록부터 인재 매칭까지, 단계별로 쉽고 빠르게 도와드립니다.</p>
			            </div>
			        </div>
			
			        <!-- 두 번째 기능: 간편한 공고 관리 -->
			        <div class="feature-item" data-aos="fade-up" data-aos-delay="100">
			           <div class="icon-background icon-drawer" data-aos="fade-up" data-aos-delay="100"></div>
			            <div class="feature-card">
			                <h2>간편한 공고 관리</h2>
			                <p>일루션에서 시작하는 스마트한 채용. 공고 등록부터 인재 매칭까지, 단계별로 쉽고 빠르게 도와드립니다.</p>
			            </div>
			        </div>
			    </div>
			</section>
			<!-- 채용 공고 등록 섹션  끝-->
			
	
			<section class="reasons-section section-container">
				<h2 class="section-title" data-aos="fade-up">기업들이 일루션을 찾는 이유</h2>
				<div class="card-container">
				
				<!-- 첫 번째 카드 -->
					<div class="reason-card" data-aos="fade-up">
					  	<h3 class="card-title">모든 직군의 인재를 다양하게<br>만날 수 있어서 좋아요</h3>
				  		<p class="card-description">
						    엔지니어뿐만 아니라<br>
						    다양한 직군의 우수한 인재들을<br>
						    만나볼 수 있었어요.
						</p>
					</div>
			
					<!-- 두 번째 카드 (중앙) -->
					<div class="reason-card" data-aos="fade-up" data-aos-delay="100">
					  <h3 class="card-title">채용 담당자가 편해요</h3>
					  <p class="card-description">
					    지원자는 지원이, 채용담당자는<br>
					    지원자 관리가 편해서<br>
					    모두에게 매력적인 플랫폼이에요.<br>
					    앞으로도 쭉 잘 사용할 예정입니다.
					  </p>
					</div>
			
					<!-- 세 번째 카드 -->
				    <div class="reason-card" data-aos="fade-up" data-aos-delay="200">
				      <h3 class="card-title">능력 있는 개발자 많아요</h3>
				      <p class="card-description">
				        IT 인재가 많은 일루션은<br>
				        채용담당자들에게 매우 매력적인<br>
				        플랫폼이에요. 최근 주목받고 있는<br>
				        게임 개발 포지션 채용에서도<br>
				        큰 도움을 받고 있어요.
				      </p>
				    </div>
				  </div>
			</section>


		<section class="partners-section section-container">
		  <div class="partners-container">
		    <!-- 왼쪽 텍스트 영역 -->
		    <div class="partners-text">
		      <h2 class="partners-title" data-aos="fade-up">기업들이 일루션과 함께하는 파트너사</h2>
		      <p class="partners-description" data-aos="fade-up">
		        일루션은 다양한 산업군의 파트너들과 함께<br>
		        신뢰할 수 있는 채용 생태계를 만들어갑니다.<br>
		        스타트업부터 대기업까지, 수많은 기업이<br>
		        일루션의 채용 서비스를 이용하고 있습니다.<br>
		        지금 이 순간에도 새로운 인재와 기업이<br>
		        연결되고 있습니다.
		      </p>
		    </div>
		
		    <!-- 오른쪽 로고 그리드 영역 -->
			<div class="partners-logos" data-aos="fade-up">
				<div class="logo-item"><img src="./resources/image/nexon.jpg" alt="NEXON"></div>
				<div class="logo-item"><img src="./resources/image/29cm.jpg" alt="29CM"></div>
				<div class="logo-item"><img src="./resources/image/coupang.jpg" alt="Coupang"></div>
				<div class="logo-item"><img src="./resources/image/daangn.jpg" alt="당근"></div>
				<div class="logo-item"><img src="./resources/image/yanolja.jpg" alt="여기어때"></div>
				<div class="logo-item"><img src="./resources/image/musinsa.jpg" alt="MUSINSA"></div>
				<div class="logo-item"><img src="./resources/image/goodchoice.jpg" alt="Yanolja"></div>
				<div class="logo-item"><img src="./resources/image/toss.jpg" alt="Toss"></div>
				<div class="logo-item"><img src="./resources/image/ably.jpg" alt="ABLY"></div>
			</div>
		  </div>
		</section>
	</main>
    </div>
    
    <footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"></jsp:include>
    </footer>
    
    
</body>
</html>
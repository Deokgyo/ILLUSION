<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ILLUSION - 유능한 인재의 발견</title>
    <!-- Google Fonts Noto Sans KR 로드 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter/recruiterMain.css">
      <jsp:include page="/WEB-INF/views/inc/topRecruiter.jsp"></jsp:include>
</head>
<body>
    <div class="wrapper">
        <!-- 메인 컨텐츠 -->
        <main>
            <%--배너 섹션 --%> 
            <section class="hero-section">
            
    			<!-- 배경에 희미하게 보이는 텍스트 -->
			    <div class="background-text">ILLUSION</div>
			
			    <!-- 실제 콘텐츠 영역 -->
			    <div class="hero-content">
			        <h1 class="hero-title">
			            유능한 인재의 발견<br>
			            ILLUSION이 함께합니다
			        </h1>
			        <p class="hero-subtitle">스마트한 채용 일루션, 지금 시작하세요</p>
			        
			        <div class="hero-buttons">
			            <a href="#" class="btn btn-login">로그인</a>
			            <a href="#" class="btn btn-signup">회원가입</a>
			        </div>
			    </div>
			</section>
            
             <!-- 채용 공고 등록 섹션 -->
             <section class="features-section">
			    <h1 class="section-title">지금 채용 공고를 등록하고 관리하며 인재를 만나보세요</h1>
			
			    <div class="features-grid">
			        <!-- 첫 번째 기능: 쉽고 빠른 채용 공고 -->
			        <div class="feature-item">
			          <div class="icon-background icon-clipboard"></div>
			            <div class="feature-card">
			                <h2>쉽고 빠른 채용 공고</h2>
			                <p>일루션에서 시작하는 스마트한 채용. 공고 등록부터 인재 매칭까지, 단계별로 쉽고 빠르게 도와드립니다.</p>
			            </div>
			        </div>
			
			        <!-- 두 번째 기능: 간편한 공고 관리 -->
			        <div class="feature-item">
			           <div class="icon-background icon-drawer"></div>
			            <div class="feature-card">
			                <h2>간편한 공고 관리</h2>
			                <p>일루션에서 시작하는 스마트한 채용. 공고 등록부터 인재 매칭까지, 단계별로 쉽고 빠르게 도와드립니다.</p>
			            </div>
			        </div>
			    </div>
			</section>
			<!-- 채용 공고 등록 섹션  끝-->
			
			
            <!-- 일루션을 찾는 이유 섹션 -->
            <section class="testimonial-section">
                <h3 class="text-center">기업들이 일루션을 찾는 이유</h3>
                <div class="testimonial-cards">
                    <div class="card">
                        <h4>모든 직군의 인재를 다양하게<br>만날 수 있어서 좋아요</h4>
                        <p>엔지니어뿐만 아니라<br>다양한 직군의 우수한 인재들을<br>만나볼 수 있었어요.</p>
                    </div>
                    <div class="card">
                        <h4>채용 담당자가 편해요</h4>
                        <p>지원자는 지원이, 채용담당자는<br>지원자 관리가 편해서<br>모두에게 매력적인 플랫폼이에요.<br>앞으로도 쭉 잘 사용할 예정입니다.</p>
                    </div>
                    <div class="card">
                        <h4>능력 있는 개발자 많아요</h4>
                        <p>IT 인재가 많은 일루션은<br>채용담당자들에게 매우 매력적인<br>플랫폼이에요. 최근 주목받고 있는<br>게임 개발 포지션 채용에서도<br>큰 도움을 받고 있어요.</p>
                    </div>
                </div>
            </section>

            <!-- 파트너사 섹션 -->
            <section class="partners-section">
                <div class="partners-content text-center">
                    <h3>기업들이 일루션과 함께하는 파트너사</h3>
                    <p>
                        일루션은 다양한 산업군의 파트너들과 함께<br>
                        신뢰할 수 있는 채용 생태계를 만들어갑니다.<br>
                        스타트업부터 대기업까지, 수많은 기업이<br>
                        일루션의 채용 서비스를 이용하고 있습니다.<br>
                        지금 이 순간에도 새로운 인재와 기업이<br>
                        연결되고 있습니다.
                    </p>
                </div>
                <div class="partner-logos">
                    <div class="logo-item"><span>NEXON</span></div>
                    <div class="logo-item"><span>29CM</span></div>
                    <div class="logo-item"><span>coupang</span></div>
                    <div class="logo-item"><span>당근</span></div>
                    <div class="logo-item"><span>여기어때</span></div>
                    <div class="logo-item"><span>MUSINSA</span></div>
                    <div class="logo-item"><span>yanolja</span></div>
                    <div class="logo-item"><span>toss</span></div>
                    <div class="logo-item"><span>A B L Y</span></div>
                </div>
            </section>
        </main>

        <!-- 푸터 섹션 -->
        <footer class="footer">
            <div class="footer-container">
                <div class="footer-left">
                    <div class="cs-info">
                        <h4>고객센터</h4>
                        <p>운영시간 10:00 ~ 18:00</p>
                        <p>점심시간 12:00 ~ 13:00</p>
                        <p>휴무일 주말, 공휴일</p>
                        <p>이메일 : illusion@naver.com</p>
                    </div>
                    <div class="company-info">
                        <div class="footer-logo">
                            <h2>ILLUSION</h2>
                            <span>FIND YOUR JOB<br>THE SMART WAY</span>
                        </div>
                        <address>
                            주식회사 일루션<br>
                            부산시 부산진구 삼한골든게이트 7층<br>
                            사업자번호 : 123456
                        </address>
                    </div>
                </div>
                <div class="footer-center">
                    <p>제휴 및 채용문의 : illusion@naver.com</p>
                    <p>일반 채용문의 : illusion@naver.com</p>
                    <p>기업 서비스 문의 : illusion@naver.com</p>
                    <p>사업 제휴 문의 : illusion@naver.com</p>
                </div>
                <div class="footer-right">
                    <div class="social-icons">
                        <a href="#" class="social-icon">I</a>
                        <a href="#" class="social-icon">f</a>
                        <a href="#" class="social-icon">Y</a>
                        <a href="#" class="social-icon">T</a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="footer-bottom-container">
                    <a href="#">이용약관</a> | 
                    <a href="#">개인정보 처리방침</a> | 
                    <a href="#">문의하기</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<header class="site-header">
    <div class="header-container">
        <!-- 로고 -->
        <div class="site-logo">
            <a href="./">
           	    <img src="${pageContext.request.contextPath}/resources/image/logo.png" alt="이미지 설명" />
            </a>
        </div>

        <!-- 중앙 메뉴: 메인 네비게이션 + 검색창 -->
        <div class="center-menu">
            <!-- 메인 네비게이션 -->
            <nav class="main-nav">
			    <ul>
			        <li class="dropdown">
			            <sec:authorize access="isAnonymous()">
			                <a href="#" onclick="requireLogin(event, '${pageContext.request.contextPath}/coverletterCreate')">취업도구</a>
			            </sec:authorize>
			            <sec:authorize access="isAuthenticated()">
			                <a href="#">취업도구</a>
			            </sec:authorize>
			
			            <ul class="dropdown-menu">
			                <li>
			                    <sec:authorize access="isAnonymous()">
			                        <a href="#" onclick="requireLogin(event, '${pageContext.request.contextPath}/coverletterCreate')"><span class="icon">📄</span> 자소서 생성기</a>
			                    </sec:authorize>
			                    <sec:authorize access="isAuthenticated()">
			                        <a href="${pageContext.request.contextPath}/coverletterCreate"><span class="icon">📄</span> 자소서 생성기</a>
			                    </sec:authorize>
			                </li>
			                <li>
			                    <sec:authorize access="isAnonymous()">
			                        <a href="#" onclick="requireLogin(event, '${pageContext.request.contextPath}/coverletterRefiner')"><span class="icon">✨</span> 자소서 다듬기</a>
			                    </sec:authorize>
			                    <sec:authorize access="isAuthenticated()">
			                        <a href="${pageContext.request.contextPath}/coverletterRefiner"><span class="icon">✨</span> 자소서 다듬기</a>
			                    </sec:authorize>
			                </li>
			                <li>
			                    <sec:authorize access="isAnonymous()">
			                        <a href="#" onclick="requireLogin(event, '${pageContext.request.contextPath}/interviewCreate')"><span class="icon">🎙️</span> 면접예상 질문 생성기</a>
			                    </sec:authorize>
			                    <sec:authorize access="isAuthenticated()">
			                        <a href="${pageContext.request.contextPath}/interviewCreate"><span class="icon">🎙️</span> 면접예상 질문 생성기</a>
			                    </sec:authorize>
			                </li>
			                <li>
			                    <sec:authorize access="isAnonymous()">
			                        <a href="#" onclick="requireLogin(event, '${pageContext.request.contextPath}/chatbot')"><span class="icon">💬</span> 취업 상담 챗봇</a>
			                    </sec:authorize>
			                    <sec:authorize access="isAuthenticated()">
			                        <a href="${pageContext.request.contextPath}/chatbot"><span class="icon">💬</span> 취업 상담 챗봇</a>
			                    </sec:authorize>
			                </li>
			            </ul>
			        </li>
			        <li>
			            <a href="${pageContext.request.contextPath}/recruitmentInfo">채용정보</a>
			        </li>
			        <li>
					    <a href="${pageContext.request.contextPath}/communityMain">커뮤니티</a>
					</li>
			    </ul>
			</nav>
            
            <!-- 검색창 -->
<!--             <form action="/search" method="get" class="search-form"> -->
<!--                 <input type="text" name="query" class="search-input" placeholder="검색"> -->
<!--                 <button type="submit" class="search-button"> -->
<!--                     <i class="bi bi-search"></i> -->
<!--                 </button> -->
<!--             </form> -->
        </div>

        <!-- 우측 사용자 메뉴 -->
<!--         <nav class="user-menu"> -->
<!--             <ul> -->
<!--                 <li><a href="login">로그인</a></li> -->
<!--                 <li class="separator">|</li> -->
<!--                 <li><a href="register">회원가입</a></li> -->
<!--                 <li class="separator">|</li> -->
<!--                 <li><a href="recruiterMain">기업서비스</a></li> -->
<!--             </ul> -->
<!--         </nav> -->
         <nav class="user-menu">
            <ul>
                <sec:authorize access="isAnonymous()">
                    <li><a href="${pageContext.request.contextPath}/login">로그인</a></li>
                    <li class="separator">|</li>
                    <li><a href="${pageContext.request.contextPath}/register">회원가입</a></li>
                    <li class="separator">|</li>
                </sec:authorize>

                <sec:authorize access="isAuthenticated()">
                    <li>
                        <a href="${pageContext.request.contextPath}/myPage">
                            <sec:authentication property="principal.username" />님
                        </a>
                    </li>
                    <li class="separator">|</li>
                    <li>
                        <form id="logoutForm" action="${pageContext.request.contextPath}/logout" method="post" style="display: inline;">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <a href="#" onclick="document.getElementById('logoutForm').submit(); return false;">로그아웃</a>
                        </form>
                    </li>
                    <li class="separator">|</li>
                </sec:authorize>

                <li><a href="${pageContext.request.contextPath}/recruiterMain">기업서비스</a></li>
            </ul>
        </nav>
    </div>
    <script>
        // 로그인 여부를 체크하고, 비로그인 시 alert를 띄운 후 로그인 페이지로 보내는 함수
        function requireLogin(event, destinationUrl) {
            // 기본 a 태그의 동작(페이지 이동)을 일단 막습니다.
            event.preventDefault(); 
            
            alert("로그인이 필요한 기능입니다.");
            
            // 사용자가 '확인'을 누르면 로그인 페이지로 이동시킵니다.
            // 원래 가려던 주소를 파라미터로 넘겨주면, 로그인 성공 후 그 페이지로 보낼 수 있습니다.
            location.href = "${pageContext.request.contextPath}/login?returnUrl=" + encodeURIComponent(destinationUrl);
        }
    </script>
    
</header>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 처리방침</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/top.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/layout.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/refundPolicy.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	<main class="main-content">
	  <div class="page-title-header">
			<p class="header-text"><strong>개인정보 처리방침 </strong></p>
      </div>
	  
	  <div class="form-box">
	   <div class="refund-container">
	
        <main class="policy-card">
            <h2>웹사이트 개인정보 처리방침</h2>

            <section class="policy-section">
                <h3>1. 수집하는 개인정보 항목</h3>
                <ul>
                    <li>회원가입 시: 이름, 이메일, 비밀번호</li>
                    <li>서비스 이용 시: 접속 로그, 쿠키, IP 정보</li>
                    <li>결제 시: 결제수단 정보(신용카드, 계좌번호 등)</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>2. 개인정보의 수집 및 이용 목적</h3>
                <ul>
                    <li>회원 관리 (본인 확인, 부정 이용 방지)</li>
                    <li>서비스 제공 및 운영 (콘텐츠 제공, 결제 처리 등)</li>
                    <li>고객 상담 및 민원 처리</li>
                    <li>서비스 개선 및 신규 서비스 개발</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>3. 개인정보의 보유 및 이용기간</h3>
                <ul>
                    <li>회원 탈퇴 시 지체 없이 파기</li>
                    <li>단, 관련 법령에 따라 일정 기간 보관이 필요한 경우 해당 법령에 따름</li>
                    <li>- 전자상거래법: 계약 및 청약철회 기록 5년</li>
                    <li>- 전자상거래법: 대금 결제 및 재화 공급 기록 5년</li>
                    <li>- 전자상거래법: 소비자 불만 및 분쟁 처리 기록 3년</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>4. 개인정보 제3자 제공</h3>
                <ul>
                    <li>회사는 원칙적으로 이용자의 개인정보를 외부에 제공하지 않습니다.</li>
                    <li>다만, 법령에 의거하거나 수사기관의 요청이 있는 경우 예외적으로 제공될 수 있습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>5. 개인정보의 위탁</h3>
                <ul>
                    <li>회사는 서비스 향상을 위해 일부 업무를 외부 전문업체에 위탁할 수 있습니다.</li>
                    <li>위탁 시 개인정보 보호 관련 법령을 준수하며, 수탁업체와 계약을 통해 안전하게 관리합니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>6. 이용자 권리와 행사 방법</h3>
                <ul>
                    <li>이용자는 언제든지 본인의 개인정보를 조회하거나 수정할 수 있습니다.</li>
                    <li>회원 탈퇴를 통해 개인정보 삭제를 요청할 수 있습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>7. 개인정보 보호를 위한 노력</h3>
                <ul>
                    <li>회사는 개인정보의 분실, 도난, 누출, 변조, 훼손 등을 방지하기 위해 보안 조치를 시행합니다.</li>
                    <li>개인정보 접근 권한을 최소화하고, 정기적인 보안 점검을 실시합니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>8. 개인정보 보호책임자</h3>
                <ul>
                    <li>회사는 개인정보 보호와 관련한 문의를 처리하기 위해 개인정보 보호책임자를 지정하고 있습니다.</li>
                    <li>고객센터 이메일 또는 1:1 문의를 통해 언제든 문의하실 수 있습니다.</li>
                </ul>
            </section>

            <p class="notice">
                본 개인정보 처리방침은 2025년 7월 27일부터 적용됩니다.<br>
                회사는 법령 및 내부 방침에 따라 본 방침을 변경할 수 있으며, 변경 시 사전 고지합니다.
            </p>

        </main>
    </div>
	
	</div>
	</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</body>
</html>

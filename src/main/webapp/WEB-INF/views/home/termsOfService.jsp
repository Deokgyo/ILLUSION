<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이용약관</title>
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
			<p class="header-text"><strong>이용약관 </strong></p>
      </div>
	  
	  <div class="form-box">
	   <div class="refund-container">
	
        <main class="policy-card">
            <h2>웹사이트 이용약관</h2>

            <section class="policy-section">
                <h3>1. 목적</h3>
                <ul>
                    <li>본 약관은 회사가 제공하는 모든 인터넷 서비스의 이용 조건 및 절차, 이용자와 회사 간의 권리·의무 및 책임사항을 규정함을 목적으로 합니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>2. 이용 계약의 성립</h3>
                <ul>
                    <li>회원가입 신청 시 본 약관에 동의함으로써 이용계약이 성립됩니다.</li>
                    <li>회사는 업무 수행 또는 기술상 불가피한 사유가 있는 경우 가입을 유보하거나 거절할 수 있습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>3. 회원의 의무</h3>
                <ul>
                    <li>회원은 본 약관과 관계 법령을 준수해야 합니다.</li>
                    <li>타인의 정보 도용, 서비스 방해 행위, 불법적인 콘텐츠 등록 등을 금합니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>4. 회사의 의무</h3>
                <ul>
                    <li>회사는 안정적이고 지속적인 서비스를 제공하기 위해 최선을 다합니다.</li>
                    <li>회원의 개인정보는 동의 없이 제3자에게 제공되지 않으며, 관련 법령에 따라 보호됩니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>5. 서비스 이용 제한</h3>
                <ul>
                    <li>회원이 본 약관 또는 관련 법령을 위반할 경우, 서비스 이용이 제한될 수 있습니다.</li>
                    <li>회사는 부득이한 사유가 있을 경우 사전 고지 후 서비스를 중단할 수 있습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>6. 책임의 한계</h3>
                <ul>
                    <li>회사는 천재지변, 불가항력 등으로 인한 서비스 장애에 대해 책임을 지지 않습니다.</li>
                    <li>회원이 서비스 이용 중 게재한 정보, 자료, 사실의 신뢰성·정확성에 대해서는 책임을 지지 않습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>7. 약관의 변경</h3>
                <ul>
                    <li>회사는 필요한 경우 관련 법령을 위반하지 않는 범위에서 본 약관을 개정할 수 있습니다.</li>
                    <li>변경된 약관은 공지사항 등을 통해 사전 공지하며, 회원이 동의하지 않을 경우 서비스 이용을 중단할 수 있습니다.</li>
                </ul>
            </section>

            <p class="notice">
                본 약관은 2025년 7월 27일부터 적용됩니다.<br>
                회사는 관계 법령 및 운영정책에 따라 본 약관을 변경할 수 있으며, 변경 시 사전 고지합니다.
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
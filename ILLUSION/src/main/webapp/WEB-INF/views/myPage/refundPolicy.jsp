<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	href="${pageContext.request.contextPath}/resources/css/mypage/RefundPolicy.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	
	<div class="page-container">

	
	<main class="main-content">
	  <div class="page-title-header">
			<p class="header-text"><strong>환불 정책 </strong></p>
        </div>
	<div class="form-box">
	 <div class="refund-container">
	
        <main class="policy-card">
            <h2>ILLUSION 환불 정책 안내문</h2>

            <section class="policy-section">
                <h3>1. 서비스 특성에 따른 환불 정책</h3>
                <ul>
                    <li>본 사이트에서 제공하는 AI 첨삭 서비스는 비대면 전자상거래법 및 소비자보호법에 따라, 결제 후 토큰이 사용되지 않은 경우에 한하여 전액 환불이 가능합니다.</li>
                    <li>이미 사용된 토큰 또는 첨삭이 진행된 서비스에 대해서는 환불이 불가합니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>2. 환불 신청 기간</h3>
                <ul>
                    <li>결제일로부터 7일 이내에 사용하지 않은 토큰에 대해 환불이 가능합니다.</li>
                    <li>7일이 경과한 후에는 환불이 제한될 수 있습니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>3. 환불 처리 절차</h3>
                <ul>
                    <li>환불을 원하실 경우, [마이페이지 > 결제내역 > 환불 신청] 메뉴를 이용해 주세요.</li>
                    <li>접수 후 영업일 기준 3일 이내에 환불이 처리됩니다.</li>
                    <li>결제 시 사용한 수단(신용카드, 간편결제 등)으로 환불이 진행됩니다.</li>
                </ul>
            </section>

            <section class="policy-section">
                <h3>4. 유의사항</h3>
                <ul>
                    <li>이벤트 등으로 지급된 무료/보너스 토큰은 환불 대상에서 제외됩니다.</li>
                    <li>시스템 오류나 이중 결제 등 당사의 귀책 사유가 명확한 경우 전액 환불이 가능합니다.</li>
                    <li>환불 관련 궁금사항은 고객센터(이메일 또는 1:1문의)를 통해 문의해 주십시오.</li>
                </ul>
            </section>

            <p class="notice">
                본 환불 정책은 2025년 7월 27일부터 적용됩니다.<br>
                회사는 관계 법령 및 내부 방침에 따라 환불 정책을 변경할 수 있으며, 변경 시 사전 고지합니다.
            </p>

            <div class="agreement">
                <input type="checkbox" id="agree-checkbox">
                <label for="agree-checkbox">상기 환불 정책을 모두 확인하였으며, 이에 동의합니다.</label>
            </div>
        </main>

        <div class="button-wrapper">
            <button class="refund-button">환불</button>
        </div>
    </div>
	
	</div>
	</main>
	</div>

<footer>
	<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
</footer>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
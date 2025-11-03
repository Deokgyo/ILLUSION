<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마케팅 정보 수신 동의</title>
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
				<p class="header-text">
					<strong>마케팅 정보 수신 동의</strong>
				</p>
			</div>

			<div class="form-box">
				<div class="refund-container">
					<main class="policy-card">
						<h2>마케팅 활용 및 광고성 정보 수신 동의 약관</h2>
						<section class="policy-section">
							<h3>1. 수집 및 이용 항목</h3>
							<ul>
								<li>이메일, 휴대폰 번호, 앱 푸시 알림 정보</li>
								<li>서비스 이용 이력, 구매 이력, 관심 상품 정보</li>
							</ul>
						</section>
						<section class="policy-section">
							<h3>2. 이용 목적</h3>
							<ul>
								<li>이벤트, 할인 혜택, 신규 서비스 안내</li>
								<li>맞춤형 광고, 개인화된 서비스 제공</li>
								<li>고객 만족도 조사 및 서비스 개선</li>
							</ul>
						</section>
						<section class="policy-section">
							<h3>3. 보유 및 이용 기간</h3>
							<ul>
								<li>회원 탈퇴 시 또는 동의 철회 시 즉시 파기</li>
								<li>단, 법령에 따른 보존이 필요한 경우 해당 기간 동안 보관</li>
							</ul>
						</section>
						<section class="policy-section">
							<h3>4. 동의 거부권 및 불이익</h3>
							<ul>
								<li>이용자는 마케팅/광고성 정보 수신 동의를 거부할 권리가 있습니다.</li>
								<li>동의하지 않더라도 서비스 기본 기능은 이용할 수 있으며, 단지 혜택 안내 등이 제한될 수 있습니다.</li>
							</ul>
						</section>
						<section class="policy-section">
							<h3>5. 철회 및 수신 거부 방법</h3>
							<ul>
								<li>이용자는 언제든지 마케팅 수신 동의를 철회할 수 있습니다.</li>
								<li>회원정보 수정 또는 고객센터를 통해 수신 거부가 가능합니다.</li>
							</ul>
						</section>
						<p class="notice">
							본 마케팅 정보 수신 및 활용 약관은 2025년 7월 27일부터 적용됩니다.<br> 회사는 관련 법령 및 정책
							변경에 따라 본 약관을 수정할 수 있으며, 사전 고지를 통해 안내합니다.
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

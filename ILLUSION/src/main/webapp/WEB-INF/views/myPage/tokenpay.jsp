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
	href="${pageContext.request.contextPath}/resources/css/mypage/tokenpay.css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp" />
	</header>
	<div class="page-container">

		<jsp:include page="/WEB-INF/views/inc/sidebar.jsp" />
		<main class="main-content">
			<div class="page-title-header">
				<p class="header-text">
					<strong>토큰 충전 </strong>
				</p>
			</div>

			<div class="charge-container">


				<div class="token-options">
					<div class="token-option" onclick="selectToken(this)">
						<span class="token-amount">🟡 100 토큰</span> <span
							class="token-price">1000원</span>
					</div>
					<div class="token-option" onclick="selectToken(this)">
						<span class="token-amount">🟡 500 토큰</span> <span
							class="token-price">5000원</span>
					</div>
					<div class="token-option selected" onclick="selectToken(this)">
						<span class="token-amount">🟡 1000 토큰</span> <span
							class="token-price">10,000원</span>
					</div>
				</div>

				<div class="section-title">결제수단</div>

				<div class="payment-method-box">신용 . 체크카드</div>

				<div class="payment-options">
					<div class="payment-option">
						<img
							src="${pageContext.request.contextPath}/resources/mypage_image/kakao.png"
							alt="kakaopay">
					</div>
					<div class="payment-option">
						<img
							src="${pageContext.request.contextPath}/resources/mypage_image/naver.png"
							alt="naver">
					</div>
					<div class="payment-option">
						<img
							src="${pageContext.request.contextPath}/resources/mypage_image/toss.png"
							alt="toss">
					</div>
				</div>

				
					
					 <select id="job" name="job" class="custom-select">
						<option value="lottecard">카드선택</option>
						<option value="lottecard">롯데카드</option>
						<option value="samsungcard">삼성카드</option>
						<option value="bccard">bc카드</option>
						
					</select>
				<div class="policyCSS1">
				<input type="checkbox" class="checkbox"> <a href="refund_policy" class="policyCSS">결제 및 환불 정책에 동의합니다.</a>
				
				</div>

				<button class="submit-btn" onclick="confirm('걸제하시겠습니까?')">결제</button>
				
			</div>

			<script>
        function selectToken(element) {
            // 모든 'selected' 클래스 제거
            const options = document.querySelectorAll('.token-option');
            options.forEach(option => {
                option.classList.remove('selected');
            });
            // 클릭된 요소에만 'selected' 클래스 추가
            element.classList.add('selected');
        }
    </script>


		</main>
	</div>

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
</body>
</html>
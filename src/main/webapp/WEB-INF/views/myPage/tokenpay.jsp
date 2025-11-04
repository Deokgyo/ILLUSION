<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채용의 모든 솔루션, 일루션에서 시작됩니다</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/image/logop.png" type="image/x-icon">	
	
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
	href="${pageContext.request.contextPath}/resources/css/sidebar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bottom.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/components.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/tokenpay.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
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
			<div class="community-search mt-4">
				<div class="token-options">
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_100">
						<span class="token-amount">🟡100토큰 충전 (1,000원)</span>
					</button>
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_300">
						<span class="token-amount">🟡300토큰 충전 (3,000원)</span>
					</button>
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_500">
						<span class="token-amount">🟡500토큰 충전 (5,000원)</span>
					</button>
				</div>
				<div class="token-options">
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_1000">
						<span class="token-amount">🟡1000토큰 충전 (10,000원)</span>
					</button>
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_3000">
						<span class="token-amount">🟡3000토큰 충전 (30,000원)</span>
					</button>
					<button class="token-option" onclick="selectToken(this)"
						data-product-id="token_5000">
						<span class="token-amount">🟡5000토큰 충전 (50,000원)</span>
					</button>
				</div>
			</div>

<!-- 			<div class="section-title">결제수단</div> -->

<!-- 			<div class="payment-method-box"> -->
<!-- 				<button class="btn-charge">신용 . 체크카드</button> -->
<!-- 			</div> -->

			<jsp:include page="/WEB-INF/views/myPage/tokenpayList.jsp" />
			<!-- 				<div class="payment-options"> -->
			<!-- 					<div class="payment-option"> -->
			<!-- 						<img -->
			<%-- 							src="${pageContext.request.contextPath}/resources/mypage_image/kakao.png" --%>
			<!-- 							alt="kakaopay"> -->
			<!-- 					</div> -->
			<!-- 					<div class="payment-option"> -->
			<!-- 						<img -->
			<%-- 							src="${pageContext.request.contextPath}/resources/mypage_image/naver.png" --%>
			<!-- 							alt="naver"> -->
			<!-- 					</div> -->
			<!-- 					<div class="payment-option"> -->
			<!-- 						<img -->
			<%-- 							src="${pageContext.request.contextPath}/resources/mypage_image/toss.png" --%>
			<!-- 							alt="toss"> -->
			<!-- 					</div> -->
			<!-- 				</div> -->
			<!-- 				<select id="job" name="job" class="custom-select"> -->
			<!-- 					<option value="lottecard">카드사 선택</option> -->
			<!-- 					<option value="lottecard">롯데카드</option> -->
			<!-- 					<option value="samsungcard">삼성카드</option> -->
			<!-- 					<option value="bccard">bc카드</option> -->
			<!-- 				</select> -->
			<div class="policyCSS1">
				<input type="checkbox" class="checkbox" id="checkbox">
				<label for="payment-agreement-check" class="span-title">결제 및 환불 정책에 동의합니다.</label>
			</div>
			<button class="submit-btn" id="submit-btn">결제</button>
		</main>
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

	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp" />
	</footer>
	<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>
	<script>window.contextPath = "${pageContext.request.contextPath}";</script>
	<script src="${pageContext.request.contextPath}/resources/js/myPage/tokenPayment.js"></script>
</body>
</html>
$(function() {

	const contextPath = window.contextPath || "";

	// 아임포트 가맹점 식별코드
	const iamportCode = 'imp63658187'; // 실제 발급받은 코드S

	// 판매할 토큰 상품 목록 (상품 카탈로그)
	const productInfo = {
		"token_100": { name: "100 토큰 충전", tokens: 100, amount: 1000 },
		"token_300": { name: "300 토큰 충전", tokens: 300, amount: 3000 },
		"token_500": { name: "500 토큰 충전", tokens: 500, amount: 5000 },
		"token_1000": { name: "1000 토큰 충전", tokens: 1000, amount: 10000 },
		"token_3000": { name: "3000 토큰 충전", tokens: 3000, amount: 30000 },
		"token_5000": { name: "5000 토큰 충전", tokens: 5000, amount: 50000 },
	};

	let selectedProductId = null;

	$('.token-option').on('click', function() {
		// 모든 버튼에서 selected 클래스 제거
		$('.token-option').removeClass('selected');

		// 내가 클릭한 버튼에만 selected 클래스 추가
		$(this).addClass('selected');

		// 선택된 상품의 ID를 전역 변수에 저장
		selectedProductId = $(this).data('product-id');

		console.log("선택된 상품 ID:", selectedProductId);
	});


	// 아임포트 초기화
	var IMP = window.IMP;
	IMP.init(iamportCode);

	$('.token-option').on('click', function() {
		const productId = $(this).data('product-id');
		const selectedProduct = productInfo[productId];
		const isAgreed = $('#checkbox').is(':checked');

		if (!isAgreed) {
			alert("결제 및 환불 정책에 동의하셔야 결제를 진행할 수 있습니다.");
			return;
		}

		var IMP = window.IMP;
		IMP.init(iamportCode);

		// --- 백엔드 연동 없이 바로 아임포트 결제창 호출 ---
		IMP.request_pay({
			pg: "kcp", // KCP 테스트 모드
			pay_method: "card",
			// 주문번호는 테스트를 위해 항상 고유하게 생성
			merchant_uid: "test_order_" + new Date().getTime(),
			name: selectedProduct.name,
			amount: selectedProduct.amount,
			buyer_name: "테스트유저"
		}, handlePaymentResponse); // 단순화된 콜백 함수를 호출
	});


	function handlePaymentResponse(rsp) {
		if (rsp.success) {
			// --- 결제 성공 시 ---

			// 서버 검증 없이, 그냥 아임포트가 "성공"이라고 알려준 내용을 믿고 그대로 표시
			console.log("결제 성공 응답 (프론트엔드):", rsp);

			// 사용자에게 보여줄 메시지 조합
			let msg = "결제가 성공적으로 완료되었습니다. (테스트 모드)\n";
			msg += "아임포트 거래 ID: " + rsp.imp_uid + "\n";
			msg += "주문 번호: " + rsp.merchant_uid + "\n";
			msg += "결제 금액: " + rsp.paid_amount;

			alert(msg);

		} else {
			// --- 결제 실패 시 ---
			console.log("결제 실패 응답:", rsp);
			alert("결제에 실패했습니다. 에러 메시지: " + rsp.error_msg);
		}

	}
	
	// [이벤트 2] 최종 결제 버튼(#submit-payment-btn)을 클릭했을 때
	$('#submit-btn').on('click', function() {

		// 1. 사용자가 상품을 선택했는지 확인
		if (selectedProductId === null) {
			alert("충전할 토큰을 먼저 선택해주세요.");
			return; // 아무것도 선택 안 했으면 함수 종료
		}

		// 2. 저장해 둔 ID로 상품 정보를 가져옴
		const selectedProduct = productInfo[selectedProductId];

		if (confirm(`${selectedProduct.tokens} 토큰을 충전(결제)하시겠습니까?`)) {

			// 3. 서버에 토큰 충전을 요청하는 AJAX 호출
			$.ajax({
				url: window.contextPath + "/api/tokens/charge",
				method: "POST",
				data: {
					productId: selectedProductId,
					tokenAmount: selectedProduct.tokens
				},
				dataType: "json",
				success: function(response) {
					if (response.status === 'success') {
						alert(response.message);
						// 충전 성공 후, 선택 상태 초기화
						selectedProductId = null;
						$('.token-option').removeClass('selected');
					} else {
						alert("오류: " + response.message);
					}
				},
				error: function(xhr) {
					if (xhr.status === 401) {
						alert("로그인이 필요합니다.");
						location.href = window.contextPath + '/login';
					} else {
						alert("서버와 통신 중 오류가 발생했습니다.");
					}
				}
			});
		}
	});
});
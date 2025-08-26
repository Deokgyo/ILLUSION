$(function() {
    
    //================================================
    // 1. 설정 및 정보
    //================================================

    // JSP 파일에서 <script> window.contextPath = "..."; </script> 로 선언되어야 합니다.
    const contextPath = window.contextPath || "";

    // 아임포트 가맹점 식별코드
    const iamportCode = 'imp63658187'; // TODO: 실제 발급받은 코드로 변경해야 합니다.

    // 판매할 토큰 상품 목록 (상품 카탈로그)
    const productInfo = {
        "token_100": { name: "100 토큰 충전", tokens: 100, amount: 1000 },
        "token_500": { name: "500 토큰 충전", tokens: 500, amount: 5000 },
        "token_1000": { name: "1000 토큰 충전", tokens: 1000, amount: 10000 }
    };


    //================================================
    // 2. 아임포트 초기화
    //================================================
    var IMP = window.IMP;
    IMP.init(iamportCode);
    
        $('.token-option').on('click', function() {
        const productId = $(this).data('product-id');
        const selectedProduct = productInfo[productId];

        if (!selectedProduct) {
            alert("잘못된 상품입니다.");
            return;
        }

        // --- 백엔드 연동 없이 바로 아임포트 결제창 호출 ---
        IMP.request_pay({
            pg: "kcp", // KCP 테스트 모드
            pay_method: "card",
            // 주문번호는 테스트를 위해 항상 고유하게 생성
            merchant_uid: "test_order_" + new Date().getTime(), 
            name: selectedProduct.name,
            amount: selectedProduct.amount,
            buyer_name: "테스트유저"
        }, handlePaymentResponse); // ✨ 단순화된 콜백 함수를 호출
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
            
            // 결제 성공 후, 원하는 페이지로 이동 (선택사항)
            // location.href = "/main";

        } else {
            // --- 결제 실패 시 ---
            console.log("결제 실패 응답:", rsp);
            alert("결제에 실패했습니다. 에러 메시지: " + rsp.error_msg);
        }
    }

});
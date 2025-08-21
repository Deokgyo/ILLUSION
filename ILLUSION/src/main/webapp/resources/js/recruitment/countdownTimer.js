$(function() {

    // 타이머를 표시할 DOM 요소를 찾습니다.
    const $countdownTimer = $('#countdown-timer');
    
    // 만약 타이머 요소가 페이지에 존재하지 않으면, 아무것도 하지 않고 종료합니다.
    if ($countdownTimer.length === 0) {
        return;
    }

    // data-deadline 속성에서 목표 마감 시간을 가져옵니다.
    const deadlineString = $countdownTimer.data('deadline');
    
    // 마감 시간을 JavaScript의 Date 객체로 변환합니다.
    const deadline = new Date(deadlineString).getTime();

    // 1초마다 시간을 업데이트하는 타이머를 설정합니다.
    const timerInterval = setInterval(function() {
        
        // 1. 현재 시간을 가져옵니다.
        const now = new Date().getTime();
        
        // 2. 마감 시간과 현재 시간의 차이(밀리초 단위)를 계산합니다.
        const distance = deadline - now;

        // 3. 남은 시간을 일, 시, 분, 초로 계산합니다.
        // Math.floor()는 소수점 이하를 버리는 함수입니다.
        const days = Math.floor(distance / (1000 * 60 * 60 * 24));
        const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((distance % (1000 * 60)) / 1000);
        
        // 4. 계산된 값을 HTML 요소에 업데이트합니다.
        $('#days').text(String(days).padStart(2, '0'));
        $('#hours').text(String(hours).padStart(2, '0'));
        $('#minutes').text(String(minutes).padStart(2, '0'));
        $('#seconds').text(String(seconds).padStart(2, '0'));

        // 5. 만약 남은 시간이 0보다 작아지면 (마감 시간이 지나면)
        if (distance < 0) {
            // 타이머를 멈춥니다.
            clearInterval(timerInterval);
            // 마감 메시지를 표시합니다.
            $countdownTimer.html("<h5>채용이 마감되었습니다.</h5>");
        }
    }, 1000); // 1000밀리초 = 1초
});
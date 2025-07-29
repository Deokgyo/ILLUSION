$(function() {
    console.log(3);
    // 탭 링크를 클릭했을 때의 이벤트 처리
    $('.tabs-nav .tab-link').on('click', function(e) {
        e.preventDefault();

        // 1. 모든 탭 링크에서 'active' 클래스 제거
        $('.tabs-nav .tab-link').removeClass('active');
        // 2. 클릭된 탭에만 'active' 클래스 추가
        $(this).addClass('active');

        // 3. 모든 탭 패널을 숨김
        $('.tab-panel').removeClass('active');

        // 4. 클릭된 탭이 가리키는 패널의 ID를 가져와서 해당 패널만 보여줌
        const targetPanelId = $(this).data('tab'); // data-tab 속성 값 읽기
        $('#' + targetPanelId).addClass('active');
    });

});
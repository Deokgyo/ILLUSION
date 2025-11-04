$(function() {
	
    // 게시물 주제 탭 활성화 및 비활성화
    $('.filter-tags .tag-item').on('click', function() {
        const $clickedTab = $(this);
        $clickedTab.siblings().removeClass('active');
        $clickedTab.addClass('active');
    });

    // 검색 기능
    $('#searchBtn').on('click', function() {
        performSearch();
    });

    // Enter 키로 검색
    $('#searchKeyword').on('keypress', function(e) {
        if (e.which === 13) { // Enter key
            e.preventDefault();
            performSearch();
        }
    });

    // 검색 실행 함수
    function performSearch() {
        const searchKeyword = $('#searchKeyword').val().trim();
        
        // 현재 URL의 파라미터들을 유지하면서 검색 파라미터 추가
        const urlParams = new URLSearchParams(window.location.search);
        
        // 기존 검색 파라미터 제거
        urlParams.delete('searchKeyword');
        urlParams.delete('pageNum'); // 검색 시 페이지는 1로 초기화
        
        // 새로운 검색 파라미터 추가
        if (searchKeyword) {
            urlParams.set('searchKeyword', searchKeyword);
        }
        
        // 페이지 번호를 1로 설정
        urlParams.set('pageNum', '1');
        
        // 새로운 URL로 이동
        window.location.href = 'communityMain?' + urlParams.toString();
    }



});
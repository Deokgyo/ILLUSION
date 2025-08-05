$(function() {
	
    // 게시물 주제 탭 활성화 및 비활성화
    
    $('.filter-tags .tag-item').on('click', function() {
        
        const $clickedTab = $(this);

        $clickedTab.siblings().removeClass('active');
        
        $clickedTab.addClass('active');

    });

});
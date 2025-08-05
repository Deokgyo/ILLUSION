$(function() {
    console.log(3);
    $('.tabs-nav .tab-link').on('click', function(e) {
        e.preventDefault();

        $('.tabs-nav .tab-link').removeClass('active');
        $(this).addClass('active');

        $('.tab-panel').removeClass('active');

        const targetPanelId = $(this).data('tab');
        $('#' + targetPanelId).addClass('active');
    });
	
	$('.resume-list .resume-item').on('click', function(){
		const $clickedTab = $(this);
        $clickedTab.siblings().removeClass('active');
        $clickedTab.addClass('active');
		
	});
});
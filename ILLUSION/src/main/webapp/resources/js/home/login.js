
/*===========================================================
			상단 탭 클릭시 효과 주기 
============================================================*/
$(function() {
$('.type').on('click', addActive);
	

});
	function addActive() {
		$('li').removeClass('active');
		$(this).addClass('active');
	}
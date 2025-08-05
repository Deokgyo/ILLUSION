console.log('탭 스크립트 실행됨');


$(document).ready(function() {
	

$('.tab-btn').on('click', function() {
    $('.tab-btn').removeClass('active');  // 모든 탭에서 active 제거
    $(this).addClass('active');          // 클릭한 탭에 active 추가
  });
	

  
  
  
  
});
//
//const tabs = document.querySelectorAll('.tab-btn');
//

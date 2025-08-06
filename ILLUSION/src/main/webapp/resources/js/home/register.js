console.log('탭 스크립트 실행됨');


$(document).ready(function() {


	$('.tab-btn').on('click', function() {
		$('.tab-btn').removeClass('active');  // 모든 탭에서 active 제거
		$(this).addClass('active');          // 클릭한 탭에 active 추가
	});

	// DOM이 준비된 후 실행
	$(function() {
		var $agreeAll = $('#agree-all');
		var $checkboxes = $('.agree-each');

		// 전체 동의 클릭 시, 하위 약관 모두 체크/해제
		$agreeAll.on('change', function() {
			$checkboxes.prop('checked', this.checked);
		});

		// 개별 약관 체크 시, 모두 체크됐으면 전체 동의도 체크
		$checkboxes.on('change', function() {
			$agreeAll.prop('checked', $checkboxes.length === $checkboxes.filter(':checked').length);
		});
	});

	$(function() {
		$('#companyTab').on('click', function() {
			$('#personalTab').removeClass('selected');
			$(this).addClass('selected');
			$('#companyBox').fadeIn(120);
		});

		$('#personalTab').on('click', function() {
			$('#companyTab').removeClass('selected');
			$(this).addClass('selected');
			$('#companyBox').fadeOut(120);
		});
	});



});


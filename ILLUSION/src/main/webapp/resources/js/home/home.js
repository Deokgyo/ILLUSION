// FAQ 열고 닫기 기능
$(function() {

	// FAQ 열고 닫기 기능
	document.querySelectorAll('.clean-faq-question').forEach(button => {
		button.addEventListener('click', () => {
			const answer = button.nextElementSibling;
			const isActive = answer.classList.contains('active');

			// 모든 답변 닫기
			document.querySelectorAll('.clean-faq-answer.active').forEach(activeAnswer => {
				activeAnswer.classList.remove('active');
				activeAnswer.previousElementSibling.classList.remove('active');
			});

			// 클릭한 답변만 열기(토글)
			if (!isActive) {
				answer.classList.add('active');
				button.classList.add('active');
			}
		});
	});

	// illusion-feature-box 스크롤 애니메이션
	$(function() {
		$(window).on('scroll', function() {
			var scrollTop = $(window).scrollTop();
			var windowHeight = $(window).height();

			$('.illusion-feature-box').each(function() {
				var elemTop = $(this).offset().top;
				var triggerPoint = elemTop - windowHeight + 50;

				if (scrollTop > triggerPoint) {
					$(this).addClass('visible');      // 화면에 보이면 클래스 추가해서 떠오르게
				} else {
					$(this).removeClass('visible');   // 화면 밖으로 나가면 다시 숨기기
				}
			});
		});

		// 페이지 로드 시 바로 확인해서 화면에 보이면 보이게 처리 (필요시)
		$(window).trigger('scroll');
	});




});

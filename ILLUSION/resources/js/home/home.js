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

			$('.illusion-feature-box').each(function(idx) {
				var elemTop = $(this).offset().top;

				if (scrollTop > 0 && scrollTop + windowHeight > elemTop + 50) {
					var delay = idx * 150; // 150ms 간격으로 딜레이
					$(this).css('transition-delay', delay + 'ms');
					$(this).addClass('visible');
				} else {
					$(this).css('transition-delay', '0ms');
					$(this).removeClass('visible');
				}
			});
		});

		$(window).trigger('scroll');
	});







});

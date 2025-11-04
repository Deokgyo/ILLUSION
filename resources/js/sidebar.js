/*
  jQuery를 사용하여 사이드바 메뉴의 아코디언 기능을 구현합니다.
  $(function() { ... }); 는 document.addEventListener('DOMContentLoaded', ...)와
  동일한 의미로, 페이지의 모든 HTML이 로드된 후 코드를 실행하라는 뜻입니다.
*/

$(function() {

	// 1. 클릭 이벤트를 적용할 대상(서브메뉴가 있는 링크)을 선택합니다.
	const menuLinks = $('.sidebar-nav .has-submenu > a');

	// 2. 선택된 모든 링크에 클릭 이벤트를 한 번에 적용합니다.
	menuLinks.on('click', function(e) {

		// 3. a 태그의 기본 동작(페이지 이동 등)을 막습니다.
		e.preventDefault();

		// 4. 클릭된 링크의 부모 <li> 요소를 찾습니다.
		const $parentLi = $(this).parent('li');

		// 5. ✨개선된 기능✨:
		//    클릭된 메뉴의 형제(siblings) 메뉴들 중에서 'active' 클래스를 가진 것을 찾아 제거합니다.
		//    => 즉, 내가 클릭한 메뉴 외에 다른 열려있는 메뉴가 있다면 먼저 닫아줍니다.
		$parentLi.siblings('.active').removeClass('active');

		// 6. 클릭된 메뉴에 'active' 클래스를 토글(toggle)합니다.
		//    => 닫혀있으면 열고(add), 열려있으면 닫습니다(remove).
		$parentLi.toggleClass('active');

	});


	//  csrf 토큰 보내기 (임시로 사이드바에서 구현) TODO
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");

	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(header, token);
	});
	
	// 현재 페이지에 해당하는 사이드바 메뉴 활성화 로직

	function activateCurrentSidebarMenu() {

		// 1. 현재 페이지의 전체 URL 경로를 가져옵니다.
		const currentPath = window.location.pathname + window.location.search;

		// 2. 사이드바의 모든 메뉴 링크(a 태그)를 선택합니다.
		const $allLinks = $('.sidebar-nav a');

		let bestMatch = null;
		let longestMatchLength = 0;

		// 3. 모든 링크를 하나씩 순회하면서 현재 URL과 비교합니다.
		$allLinks.each(function() {
			const $link = $(this);
			const linkHref = $link.attr('href');

			const currentPageName = window.location.pathname.split('/').pop(); // 예: "recruitmentInfo"

			if (linkHref && currentPageName.includes(linkHref)) {

				// 4. "가장 길게" 일치하는 링크를 찾습니다. (더 구체적인 링크 우선)
				if (linkHref.length > longestMatchLength) {
					longestMatchLength = linkHref.length;
					bestMatch = $link;
				}
			}
		});

		// 5. 가장 잘 맞는 링크를 찾았다면, 해당 메뉴를 활성화합니다.
		if (bestMatch) {
			// 모든 메뉴에서 활성화 클래스를 일단 모두 제거
			$('.sidebar-nav li').removeClass('current-category');

			// 찾은 링크의 가장 가까운 부모 <li>에 활성화 클래스 추가
			const $parentLi = bestMatch.closest('li');
			$parentLi.addClass('current-category');

			// 만약 활성화된 메뉴가 서브메뉴 안에 있다면, 그 부모 메뉴도 함께 열어줍니다.
			if ($parentLi.hasClass('submenu')) {
				$parentLi.closest('.has-submenu').addClass('active current-category');
			}
		}
	}

	// --- 실행 ---
	// 페이지가 로드되면 현재 메뉴 활성화 함수를 실행합니다.
	activateCurrentSidebarMenu();

});
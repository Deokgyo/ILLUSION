$(function() {

    // 1. 클릭 이벤트를 적용할 대상을 선택합니다.
    const menuLinks = $('.sidebar-nav .has-submenu > a');

    // 2. 선택된 모든 링크에 클릭 이벤트를 한 번에 적용합니다.
    menuLinks.on('click', function(e) {
        
        // 3. a 태그의 기본 동작(페이지 이동)을 막습니다.
        e.preventDefault();

        // 4. 클릭된 링크의 부모 <li> 요소를 찾습니다.
        const $parentLi = $(this).parent('li');

        // 5. 클릭된 메뉴의 형제(siblings) 메뉴들 중에서 'active' 클래스를 가진 것을 찾아 제거합니다.
        //    => 즉, 다른 열려있는 메뉴를 닫습니다.
        $parentLi.siblings('.active').removeClass('active');

        // 6. 클릭된 메뉴의 'active' 클래스를 토글(toggle)합니다.
        //    => 닫혀있으면 열고(add), 열려있으면 닫습니다(remove).
        $parentLi.toggleClass('active');

    });
});  


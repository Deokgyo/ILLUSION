$(document).ready(function () {
  // 1. 드롭다운 열고 닫기
  $(document).on('click', '.toggle-salary-btn', function (e) {
    e.stopPropagation(); // 바깥 클릭 이벤트와 충돌 방지
    const $dropdown = $(this).closest('.salary-dropdown').find('.salary-dropdown-menu');
    $('.salary-dropdown-menu').not($dropdown).addClass('hidden'); // 다른 드롭다운 닫기
    $dropdown.toggleClass('hidden');
  });

  // 2. 바깥 클릭 시 드롭다운 닫기
  $(document).on('click', function (e) {
    if (!$(e.target).closest('.salary-dropdown').length) {
      $('.salary-dropdown-menu').addClass('hidden');
    }
  });

  // 3. 초기화 버튼 클릭 시 체크박스 해제
  $(document).on('click', '.salary-reset-btn', function () {
    $(this).closest('.salary-dropdown-menu').find("input[type='checkbox']").prop('checked', false);
  });
});

// 탭 클릭 기능
document.querySelectorAll('.form-tab').forEach(tab => {
  tab.addEventListener('click', function() {
    document.querySelectorAll('.form-tab').forEach(t => t.classList.remove('active'));
    tab.classList.add('active');
    // 탭에 따른 내용 전환 로직(필요시) 추가
  });
});

// 체크박스 상세 보기 토글
document.querySelectorAll('.more-view').forEach((btn,i) => {
  btn.addEventListener('click', function(e) {
    e.preventDefault();
    const details = btn.nextElementSibling;
    if(details.style.display === 'block') details.style.display = 'none';
    else details.style.display = 'block';
  });
});

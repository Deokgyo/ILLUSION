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

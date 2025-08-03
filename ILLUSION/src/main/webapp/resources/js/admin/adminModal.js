// DOM이 모두 로드된 후 스크립트가 실행되도록 합니다.
document.addEventListener('DOMContentLoaded', () => {

    // 필요한 요소들을 모두 선택합니다.
    const editButtons = document.querySelectorAll('.btn-edit'); // 모든 '변경' 버튼
    const modalBackdrop = document.getElementById('edit-modal-backdrop'); // 모달 배경
    const closeButton = modalBackdrop.querySelector('.close-btn'); // 모달의 닫기(X) 버튼
    const cancelButton = modalBackdrop.querySelector('.btn-cancel'); // 모달의 취소 버튼

    // --- 모달 열기 함수 ---
    const openModal = () => {
        modalBackdrop.classList.remove('hidden');
    };
    
    // --- 모달 닫기 함수 ---
    const closeModal = () => {
        modalBackdrop.classList.add('hidden');
    };

    // 모든 '변경' 버튼에 클릭 이벤트 리스너를 추가합니다.
    editButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            // (심화) 클릭된 행의 데이터를 가져와 모달에 채우는 로직
            // 1. 클릭된 버튼에서 가장 가까운 테이블 행(tr)을 찾습니다.
            const row = e.target.closest('tr');
            // 2. 해당 행에서 아이디, 유형 등의 데이터를 가져옵니다. (가정)
            const userId = row.querySelector('td:nth-child(2)').innerText;
            
            // 3. 모달의 input에 가져온 아이디 값을 설정합니다.
            document.getElementById('modal-user-id').value = userId;

            // 모달을 엽니다.
            openModal();
        });
    });

    // 닫기(X) 버튼 클릭 시 모달 닫기
    closeButton.addEventListener('click', closeModal);
    
    // 취소 버튼 클릭 시 모달 닫기
    cancelButton.addEventListener('click', closeModal);

    // 모달 배경 클릭 시 모달 닫기
    modalBackdrop.addEventListener('click', (e) => {
        // 만약 클릭된 곳이 모달 창 자체가 아니라 배경이라면
        if (e.target === modalBackdrop) {
            closeModal();
        }
    });
});
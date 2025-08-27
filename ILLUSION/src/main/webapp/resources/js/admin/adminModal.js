$(function() {

    // 필요한 DOM 요소들 선택 
    const $modalBackdrop = $('#edit-modal-backdrop');
    const $closeBtn = $modalBackdrop.find('.close-btn');
    const $cancelBtn = $modalBackdrop.find('.btn-cancel');
    const $modalForm = $modalBackdrop.find('form');
    
    // 모달에 표시될 입력 필드들
    const $modalUserId = $('#modal-user-id');
    const $modalUserType = $('#modal-user-type');
    const $modalUserStatus = $('#modal-user-status');
    
    // 폼에 숨겨져 있는 member_idx 입력 필드
    const $modalMemberIdxInput = $('#modal-member-idx');

    // "변경" 버튼 클릭 이벤트 (이벤트 위임 방식으로 변경하여 더 효율적)
    // 문서(document) 전체에서 .btn-edit 클래스를 가진 요소가 클릭되면 함수를 실행
    $(document).on('click', '.btn-edit', function() {
        // 클릭된 버튼(this)의 data-* 속성에서 회원 정보를 가져옴
        const memberIdx = $(this).data('member-idx');
        const memberId = $(this).data('member-id');
        const typeCode = $(this).data('member-type-code');
        const statusCode = $(this).data('member-status-code');

        // 가져온 정보로 모달 내부 필드 값을 설정 (.val() 사용)
        $modalMemberIdxInput.val(memberIdx); // [핵심] 숨겨진 input에 idx 설정
        $modalUserId.val(memberId);
        $modalUserType.val(typeCode); // Set the value for member type select
        $modalUserStatus.val(statusCode); // Set the value for member status select

        // 모달을 보여줌 (.removeClass() 또는 .show() 사용)
        $modalBackdrop.removeClass('hidden');
    });

    // 모달 닫기 기능 함수
    function closeModal() {
        $modalBackdrop.addClass('hidden');
    }

    // 닫기/취소 버튼 클릭 시 모달 닫기
    $closeBtn.on('click', closeModal);
    $cancelBtn.on('click', closeModal);
    
    // 모달 배경 클릭 시 닫기
    $modalBackdrop.on('click', function(event) {
        // 클릭된 요소가 모달 배경(자기 자신)일 경우에만 닫힘
        if (event.target === this) {
            closeModal();
        }
    });

    // (선택사항) ESC 키를 눌렀을 때 모달 닫기
    $(document).on('keydown', function(event) {
        if (event.key === "Escape" && !$modalBackdrop.hasClass('hidden')) {
            closeModal();
        }
    });

    // 폼 제출 이벤트
    $modalForm.on('submit', function(e) {
        e.preventDefault();

        const member_idx = $modalMemberIdxInput.val();
        const member_type_code = $modalUserType.val();
        const member_status_code = $modalUserStatus.val();
        const csrfToken = $("input[name='_csrf']").val();

        $.ajax({
            url: 'updateMemberStatusAndType',
            type: 'POST',
            data: {
                member_idx: member_idx,
                member_type_code: member_type_code,
                member_status_code: member_status_code,
                _csrf: csrfToken
            },
            success: function(res) {
                alert('회원 정보가 성공적으로 변경되었습니다.');
                closeModal();
                location.reload();
            },
            error: function(xhr, status, error) {
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
});
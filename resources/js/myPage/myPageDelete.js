function initializeMultipleDelete(options) {
    const { deleteButtonId, checkAllId, itemCheckboxClass, deleteApiUrl, paramName, itemName } = options;

    $(deleteButtonId).on('click', function() {
        const $checkedItems = $(itemCheckboxClass).filter(':checked');
		
        if ($checkedItems.length === 0) {
            alert(`삭제할 ${itemName}을(를) 선택해주세요.`);
            return;
        }

        if (confirm(`정말로 선택한 ${$checkedItems.length}개의 ${itemName}을(를) 삭제하시겠습니까?`)) {
            const idList = $checkedItems.map(function() {
                return $(this).val();
            }).get();

            $.ajax({
                url: window.contextPath + deleteApiUrl,
                method: 'POST',
                data: { [paramName]: idList }, // 파라미터 이름을 동적으로 설정
                dataType: 'json',
                traditional: true,
                success: function(response) {
                    if (response.status === 'success') {
                        alert(response.message);
                        location.reload();
                    } else {
                        alert(response.message || '삭제 중 오류가 발생했습니다.');
                    }
                },
                error: function(xhr) {
                    if (xhr.status === 401) {
                        alert("로그인이 필요합니다.");
                        location.href = window.contextPath + '/login';
                    } else {
                        alert("오류가 발생했습니다.");
                    }
                }
            });
        }
    });

    $(checkAllId).on('click', function() {
        $(itemCheckboxClass).prop('checked', $(this).is(':checked'));
    });
}
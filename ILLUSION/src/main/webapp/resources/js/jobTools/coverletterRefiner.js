$(function() {

    // 필요한 요소들을 변수에 미리 할당
    const $tabs = $('.refiner-tabs-nav .tab-link');
    const $panels = $('.tab-panel');
    const $submitBtn = $('#refine-submit-btn');

    const $checkFileUpload = $('#check-file-upload');
    const $checkDirectInput = $('#check-direct-input');

    const $sectionFileUpload = $('#section-file-upload');
    const $sectionDirectInput = $('#section-direct-input');

    const $fileInput = $('#file-input-hidden');
    const $textarea = $('#direct-input-textarea');
    const $resumeList = $('#panel-saved-resume .resume-list');

    // 1. 탭 전환 기능 
    $tabs.on('click', function(e) {
        e.preventDefault();
        const targetPanelId = $(this).data('tab');

        $tabs.removeClass('active');
        $(this).addClass('active');

        $panels.removeClass('active');
        $('#' + targetPanelId).addClass('active');

        updateButtonState(); // 탭 전환 시에도 버튼 상태 체크
    });

    // 2. 체크박스 상호 비활성화 기능
    $checkFileUpload.on('change', function() {
        if ($(this).is(':checked')) {
            $checkDirectInput.prop('checked', false);
            $sectionDirectInput.addClass('disabled');
            $sectionFileUpload.removeClass('disabled');
        } else {
            $sectionDirectInput.removeClass('disabled');
        }
        updateButtonState();
    });

    $checkDirectInput.on('change', function() {
        if ($(this).is(':checked')) {
            $checkFileUpload.prop('checked', false);
            $sectionFileUpload.addClass('disabled');
            $sectionDirectInput.removeClass('disabled');
        } else {
            $sectionFileUpload.removeClass('disabled');
        }
        updateButtonState();
    });

    // 3. 저장된 자소서 선택 기능 
    $resumeList.on('click', '.resume-item', function() {
        // 이미 active 상태인 것을 또 누르면 선택 해제 (토글)
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
        } else {
            $resumeList.find('.resume-item').removeClass('active');
            $(this).addClass('active');
        }
        updateButtonState();
    });

//     --- 4. 버튼 활성화/비활성화 로직 ---
    function updateButtonState() {
        let isButtonEnabled = false;
        
        // "새 자소서 다듬기" 탭이 활성화된 경우
        if ($('#panel-new-resume').hasClass('active')) {
            const isFileCheckedAndHasValue = $checkFileUpload.is(':checked') && $fileInput[0].files.length > 0;
            const isDirectCheckedAndHasValue = $checkDirectInput.is(':checked') && $textarea.val().trim() !== '';
            
            if (isFileCheckedAndHasValue || isDirectCheckedAndHasValue) {
                isButtonEnabled = true;
            }
        }
        // "저장된 자소서" 탭이 활성화된 경우
        else if ($('#panel-saved-resume').hasClass('active')) {
            if ($resumeList.find('.resume-item.active').length > 0) {
                isButtonEnabled = true;
            }
        }
        
        $submitBtn.prop('disabled', !isButtonEnabled);
    }

    // 파일이나 텍스트 입력 시 버튼 상태 업데이트
    $fileInput.on('change', updateButtonState);
    $textarea.on('input', updateButtonState);

    // 초기 상태 설정
    $checkFileUpload.trigger('change');
    updateButtonState(); // 페이지 로드 시 버튼 상태 초기화

});
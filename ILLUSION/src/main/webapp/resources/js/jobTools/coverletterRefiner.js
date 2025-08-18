$(function() {

    // 필요한 요소들을 변수에 미리 할당
    const $tabs = $('.refiner-tabs-nav .tab-link');
    const $panels = $('.tab-panel');
    const $submitBtn = $('#refine-submit-btn');

    // 새 자소서 다듬기 탭 관련 요소
    const $radioInputs = $('input[name="cl_input_method"]');
    const $sectionFileUpload = $('#section-file-upload');
    const $sectionDirectInput = $('#section-direct-input');
    const $fileInput = $('#file-input-hidden');
    const $textarea = $('#direct-input-textarea');

    // 저장된 자소서 탭 관련 요소
    const $resumeList = $('#panel-saved-resume .resume-list');

    //  탭 전환 기능
    $tabs.on('click', function(e) {
        e.preventDefault();
        const targetPanelId = $(this).data('tab');

        $tabs.removeClass('active');
        $(this).addClass('active');

        $panels.removeClass('active');
        $('#' + targetPanelId).addClass('active');

        updateButtonState(); // 탭 전환 시에도 버튼 상태 체크
    });

    // 라디오 버튼 선택 시 상호 비활성화 기능
    $radioInputs.on('change', function() {
        // "파일 업로드" 라디오 버튼이 선택되었는지 확인
        if ($('#check-file-upload').is(':checked')) {
            $sectionFileUpload.removeClass('disabled');
            $sectionDirectInput.addClass('disabled');
        } 
        // "자기소개서 내용" 라디오 버튼이 선택되었는지 확인
        else if ($('#check-direct-input').is(':checked')) {
            $sectionDirectInput.removeClass('disabled');
            $sectionFileUpload.addClass('disabled');
        }
        
        updateButtonState();
    });

    // 저장된 자소서 탭에서 항목 선택 기능
    $resumeList.on('click', '.resume-item-link', function() {
        // 클릭 시 active 클래스를 토글하지 않고, 링크 이동만 하도록 단순화
        // 선택 기능이 필요하다면 이전 라디오 버튼 로직을 여기에 적용
    });

    //   최종 버튼 활성화/비활성화 로직
    function updateButtonState() {
        let isButtonEnabled = false;
        
        // "새 자소서 다듬기" 탭이 활성화된 경우에만 검사
        if ($('#panel-new-resume').hasClass('active')) {
            const isFileReady = $('#check-file-upload').is(':checked') && $fileInput[0].files.length > 0;
            
            const isTextReady = $('#check-direct-input').is(':checked') && $textarea.val().trim() !== '';
            
            if (isFileReady || isTextReady) {
                isButtonEnabled = true;
            }
        }
        
        $submitBtn.prop('disabled', !isButtonEnabled);
    }

    // 파일 선택하거나 텍스트를 입력할 때마다 실시간으로 버튼 상태 업데이트
    $fileInput.on('change', updateButtonState);
    $textarea.on('input', updateButtonState);

});
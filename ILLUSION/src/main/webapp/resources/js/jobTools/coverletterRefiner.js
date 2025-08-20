$(function() {

   	// ======================================================
    //  DOM Element Variables
    // ======================================================
    const $tabs = $('.refiner-tabs-nav .tab-link');
    const $panels = $('.tab-panel');
    const $submitBtn = $('#refine-submit-btn');

    // "새 자소서 다듬기" 탭 관련 요소
    const $newResumeRadioInputs = $('input[name="cl_input_method"]');
    const $sectionFileUpload = $('#section-file-upload');
    const $sectionDirectInput = $('#section-direct-input');
    const $fileInput = $('#file-input-hidden');
    const $textarea = $('#direct-input-textarea');
    const $dropZone = $('.drop-zone'); // [수정] 빠져있던 변수 선언 추가!

    // "저장된 자소서" 탭 관련 요소
    const $resumeItems = $('.resume-item');
    
    // ======================================================
    //  Core Functions
    // ======================================================

    /** "새 자소서 다듬기" 탭의 모든 입력을 초기화하는 함수 */
    function resetNewResumeInputs() {
	
	    $fileInput.val(''); // 파일 입력 초기화
	    $textarea.val('');
	    $dropZone.find('.drop-zone-text').text('파일을 끌어 놓거나 클릭하여 선택 하세요');
	    $dropZone.removeClass('file-selected');
	
	    $sectionFileUpload.removeClass('disabled');
	    $sectionDirectInput.addClass('disabled');
    }

    /** "저장된 자소서" 탭의 선택을 초기화하는 함수 */
    function resetSavedResumeSelection() {
        console.log("저장된 자소서 선택 초기화 실행");
        $resumeItems.removeClass('active');
    }

    // ======================================================
    //  Event Handlers
    // ======================================================
    
    // --- 탭 전환 기능 ---
    $tabs.on('click', function(e) {
        e.preventDefault();
        const targetPanelId = $(this).data('tab');
        if ($(this).hasClass('active')) return;

        $tabs.removeClass('active');
        $(this).addClass('active');

        $panels.removeClass('active');
        $('#' + targetPanelId).addClass('active');

        if (targetPanelId === 'panel-new-resume') {
            resetSavedResumeSelection();
        } else {
            resetNewResumeInputs();
        }
    });

    // --- "새 자소서 다듬기" 탭 기능 ---
    $newResumeRadioInputs.on('change', function() {
        resetSavedResumeSelection();
        if ($('#check-file-upload').is(':checked')) {
            $sectionFileUpload.removeClass('disabled');
            $sectionDirectInput.addClass('disabled');
        } else {
            $sectionDirectInput.removeClass('disabled');
            $sectionFileUpload.addClass('disabled');
        }
    });

    // --- "저장된 자소서" 탭 기능 ---
    $resumeItems.on('click', function() {
        resetNewResumeInputs();
        const isAlreadyActive = $(this).hasClass('active');
        $resumeItems.removeClass('active');
        if (!isAlreadyActive) {
            $(this).addClass('active');
        }
    });

    // --- 파일 업로드 (드롭존) 기능 ---
    $dropZone.on('click', function(e) {
	 	e.stopPropagation();   // 이벤트 버블링 막기
    	e.preventDefault();    // 혹시 모를 기본동작도 막기
        $fileInput.click();
    });

    $fileInput.on('change', function() {
	    // 1. 허용할 파일 확장자 목록을 배열로 정의
	    const allowedExtensions = ['txt', 'pdf', 'doc', 'docx', 'hwp'];
	
	    if (this.files && this.files.length > 0) {
	        const file = this.files[0];
	        const fileName = file.name;
	        // 파일 이름에서 마지막 '.' 뒤의 문자열을 소문자로 추출 (이것이 확장자)
	        const fileExtension = fileName.split('.').pop().toLowerCase();
	
	        // 2. 추출한 확장자가 허용 목록에 포함되어 있는지 확인
	        if (allowedExtensions.includes(fileExtension)) {
	            // 허용된 파일인 경우: 파일 이름을 드롭존에 표시
	            $dropZone.find('.drop-zone-text').text(fileName);
	            $dropZone.addClass('file-selected');
	        } else {
	            // 허용되지 않은 파일인 경우:
	            alert('지원하지 않는 파일 형식입니다.\n(.txt, .pdf, .doc, .docx, .hwp 파일만 업로드 가능)');
	            // [중요] 파일 입력을 초기화하여 잘못된 파일이 전송되지 않도록 함
	            $(this).val(''); 
	            // 드롭존 UI도 초기 상태로 되돌림
	            $dropZone.find('.drop-zone-text').text('파일을 끌어 놓거나 클릭하여 선택 하세요');
	            $dropZone.removeClass('file-selected');
	        }
	    }
	});

    $dropZone.on('dragover', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).addClass('drag-over');
    });

    $dropZone.on('dragleave', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).removeClass('drag-over');
    });

    $dropZone.on('drop', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $(this).removeClass('drag-over');
        const files = e.originalEvent.dataTransfer.files;
        if (files.length > 0) {
            $fileInput[0].files = files;
            $fileInput.trigger('change');
        }
    });

    // --- 제목 링크 기능 ---
    $('.title-link').on('click', function(e) {
        e.stopPropagation();
        const userConfirmed = confirm("자소서 내용 페이지로 이동하시겠습니까?");
        if (!userConfirmed) {
            e.preventDefault();
        }
    });

    // --- 최종 제출 버튼 기능 ---
    $submitBtn.on('click', function() {
        if ($('#panel-new-resume').hasClass('active')) {
            const formData = new FormData($('#new-refine-form')[0]);
            $.ajax({
                type: 'POST',
                url: 'refineNewCoverletter',
                data: formData,
                processData: false,
                contentType: false,
                success: function(res) {
                    if(res.success) {
                        alert("자소서 다듬기 요청 성공!");
                        location.href = 'coverletterResult?cl_idx=' + res.cl_idx;
                    } else {
                        alert("다듬기 요청 실패.");
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                }
            });
        } else {
            const $selectedItem = $('.resume-item.active');
            if ($selectedItem.length > 0) {
                const selectedId = $selectedItem.data('id');
                const selectedTitle = $selectedItem.data('title');
                alert(`선택된 자소서: "${selectedTitle}" (ID: ${selectedId})\n이 내용으로 다듬기를 실행합니다.`);
                // TODO: 저장된 자소서 다듬기 로직
            } else {
                alert("다듬을 자소서를 선택해주세요.");
            }
        }
    });
});
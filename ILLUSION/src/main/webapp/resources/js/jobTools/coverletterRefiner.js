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
    const $dropZone = $('.drop-zone');

    // "저장된 자소서" 탭 관련 요소
    const $resumeItems = $('.resume-item');
    
    // ======================================================
    //  Core Functions
    // ======================================================

    /** "새 자소서 다듬기" 탭의 모든 입력을 초기화하는 함수 */
    function resetNewResumeInputs() {
	    $fileInput.val(''); 
	    $textarea.val('');
	    $dropZone.find('.drop-zone-text').text('파일을 끌어 놓거나 클릭하여 선택 하세요');
	    $dropZone.removeClass('file-selected');
	    $sectionFileUpload.removeClass('disabled');
	    $sectionDirectInput.addClass('disabled');
    }

    /** "저장된 자소서" 탭의 선택을 초기화하는 함수 */
    function resetSavedResumeSelection() {
        $resumeItems.removeClass('active');
    }
    
    /** 실제 다듬기 로직(Ajax)을 처리하는 함수 */
    function executeRefinement() {
        // "새 자소서 다듬기" 탭이 활성화된 경우
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
                        location.href = 'coverletterResult?cl_idx=' + res.cl_idx;
                    } else {
                        alert("다듬기 요청 실패: " + (res.message || '알 수 없는 오류'));
                    }
                },
                error: function() {
                    alert("서버 통신 중 오류가 발생했습니다.");
                },
                complete: function() {
                    $('#loading-overlay').fadeOut();
                }
            });
        } 
        // "저장된 자소서" 탭이 활성화된 경우
        else {
		    const $selectedItem = $('.resume-item.active');
		
		    if ($selectedItem.length > 0) {
		        const selectedId = $selectedItem.data('id');
		        const submissionData = { cl_idx: selectedId };
		
	            $.ajax({
	                type: 'POST',
	                url: 'refineSavedCoverletter', 
	                data: submissionData,
	                dataType: 'json',
	                success: function(res) {
	                    if (res.success) {
	                        location.href = 'coverletterResult?cl_idx=' + res.cl_idx;
	                    } else {
	                        alert("다듬기 요청 실패: " + (res.message || '알 수 없는 오류'));
	                    }
	                },
	                error: function() {
	                    alert("서버 통신 중 오류가 발생했습니다.");
	                },
	                complete: function() {
	                    $('#loading-overlay').fadeOut();
	                }
	            });
		    } else {
		        alert("다듬을 자소서를 선택해주세요.");
                $('#loading-overlay').fadeOut();
		    }
        }
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
	 	e.stopPropagation();
    	e.preventDefault();
        $fileInput.click();
    });

    $fileInput.on('change', function() {
	    const allowedExtensions = ['txt', 'pdf', 'doc', 'docx', 'hwp'];
	    if (this.files && this.files.length > 0) {
	        const file = this.files[0];
	        const fileName = file.name;
	        const fileExtension = fileName.split('.').pop().toLowerCase();
	
	        if (allowedExtensions.includes(fileExtension)) {
	            $dropZone.find('.drop-zone-text').text(fileName);
	            $dropZone.addClass('file-selected');
	        } else {
	            alert('지원하지 않는 파일 형식입니다.\n(.txt, .pdf, .doc, .docx, .hwp 파일만 업로드 가능)');
	            $(this).val(''); 
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

    // --- 최종 제출 버튼 클릭 이벤트 -> 모달창 띄우기 ---
    $submitBtn.on('click', function() {
        const userTokens = parseInt($('#currentUserToken').val()) || 0;
        const requiredTokens = 30; 

        if (userTokens < requiredTokens) {
            $('#token-modal').css('display', 'flex').fadeTo(300, 1);
        } else {
            $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
        }
    });
    
    
    $('#confirm-yes-btn').on('click', function() {
        $('#confirm-modal').fadeOut();
        $('#loading-overlay').css('display', 'flex').fadeTo(300, 1);
        executeRefinement();
    });
    
    $('.btn-no, .close-modal-btn').on('click', function() {
        $(this).closest('.modal-overlay').fadeOut();
    });

});
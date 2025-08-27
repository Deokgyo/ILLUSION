$(function() {
	
	/*이벤트 연결*/
	
	$('.create').on('click', createClick);
	
	// 면접 예상 질문 생성 
	function executeInterviewCreate() {
		
		// 직접 입력 했을때 
		if($('[data-tab="panel-direct-input"]').hasClass('active')) {
			
			let text = $('textarea').val();
			let data = {data : text};
			
			if(text == '') {
				alert('텍스트를 입력해주세요');
				return;
			}
			
			$.ajax({
				type: 'POST',
				url: 'createInterviewByDirect',
				dataType: "text",
				data: data,
				success: function(res) {
					alert('연결성공');
					location.href = res;
				},
				error: function(xhr, status, error) {
					alert('연결실패');
					console.log(xhr);
				}
			});
			
			return;
		}	
		
		// 파일 업로드 했을때 
		if($('[data-tab="panel-file-upload"]').hasClass('active')) {
			
			return;
		}	
		
		// 저장된거 선택 했을때 
		if($('[data-tab="panel-saved-coverletter"]').hasClass('active')) {
			
			return;
		}	
	}
		
	
    $('.tabs-nav .tab-link').on('click', function(e) {
        e.preventDefault();

        $('.tabs-nav .tab-link').removeClass('active');
        $(this).addClass('active');

        $('.tab-panel').removeClass('active');

        const targetPanelId = $(this).data('tab');
        $('#' + targetPanelId).addClass('active');
    });
	
	$('.resume-list .resume-item').on('click', function(){
		const $clickedTab = $(this);
        $clickedTab.siblings().removeClass('active');
        $clickedTab.addClass('active');
	});
	
	$('textarea').on('input', function() {
		let text = $(this).val();
		//글자 수 세기 
		let textCnt = text.length;
		//단어 수 세기	
		let wordCnt = $.trim(text).split(/\s+/).filter(w => w.length > 0).length;
		$('.textCnt').text(textCnt);
		$('.wordCnt').text(wordCnt);
	});
	
	// --- 파일 업로드 (드롭존) 기능 ---
	let $dropZone = $('.drop-zone');
	let $fileInput = $('#file-input-hidden');
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
    
    // --- 최종 제출 버튼 클릭 이벤트 -> 모달창 띄우기 ---
    function createClick() {
		const userTokens = parseInt($('#currentUserToken').val()) || 0;
        console.log(userTokens);
        const requiredTokens = 30; 

        if (userTokens < requiredTokens) {
            $('#token-modal').css('display', 'flex').fadeTo(300, 1);
        } else {
            $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
        }
	}
    
    
    $('#confirm-yes-btn').on('click', function() {
        $('#confirm-modal').fadeOut();
        $('#loading-overlay').css('display', 'flex').fadeTo(300, 1);
        executeInterviewCreate();
    });
    
    $('.btn-no, .close-modal-btn').on('click', function() {
        $(this).closest('.modal-overlay').fadeOut();
    });
    
});
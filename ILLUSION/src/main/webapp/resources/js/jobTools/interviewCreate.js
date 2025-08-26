$(function() {

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
	
});
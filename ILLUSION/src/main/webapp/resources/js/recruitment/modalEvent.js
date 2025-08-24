// modalEvent.js 최종 수정안
$(function() {

    // 모달을 여는 버튼 이벤트
    $('#job-apply-btn').on('click', function() {
        $('#apply-modal-overlay').removeClass('hidden');
    });

    // 모달을 닫는 함수 (재사용을 위해 분리)
    function closeModal() {
        $('#apply-modal-overlay').addClass('hidden');
    }

    // 닫기 버튼 클릭 이벤트 (이벤트 위임)
    $(document).on('click', '.modal-close-btn', function() {
        closeModal();
    });

    // 모달 바깥 영역 클릭 이벤트 (이벤트 위임)
    $(document).on('click', '#apply-modal-overlay', function(event) {
        if (event.target === this) {
            closeModal();
        }
    });

    // ESC 키 이벤트
    $(document).on('keydown', function(event) {
        if (event.key === 'Escape' && !$('#apply-modal-overlay').hasClass('hidden')) {
            closeModal();
        }
    });

    // 파일 첨부 이벤트 (이벤트 위임)
    $(document).on('change', '#file-upload', function() {
        if (this.files && this.files.length > 0) {
            const fileName = this.files[0].name;
            const $modal = $(this).closest('.modal-content');
            $modal.find('.file-info-text').hide();
            $modal.find('.file-name-display').text('첨부된 파일: ' + fileName).show();
        }
    });
    
    // 자기소개서 부분 
    $('input[name="cl_idx"]').click(function(){
        // 이미 체크된 상태에서 클릭하면 해제
        if($(this).data('waschecked')) {
            $(this).prop('checked', false);
            $(this).data('waschecked', false);
        } else {
            // 다른 체크박스 해제
            $('input[name="cl_idx"]').not(this).prop('checked', false).data('waschecked', false);
            $(this).data('waschecked', true);
        }
    });

    // 초기 상태 모두 false
    $('input[name="cl_idx"]').data('waschecked', false);
    
    function resizeModal() {
		 let $modal = $('.modal-content');
	    let windowWidth = $(window).width();
	    let windowHeight = $(window).height();
	
	    let modalPadding = 75; // 상하 패딩 합
	    let baseWidth = 550;
	    let baseHeight = $modal.outerHeight() + modalPadding;
	
	    let scale = Math.min(windowWidth / baseWidth, windowHeight / baseHeight, 1);
	
	    $modal.css('transform', 'scale(' + scale + ')');
	}

	$(window).on('resize load', resizeModal);
    
    
});
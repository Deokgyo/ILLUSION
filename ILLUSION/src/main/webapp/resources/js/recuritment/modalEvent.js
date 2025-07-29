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
});
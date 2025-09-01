$(function(){
	// 게시글 삭제
	const deleteBtn = $('.delete-btn');
	
	deleteBtn.on('click', function(e) {
		const boardIdx = $(this).data('board-idx');
		
		// 삭제 확인 메시지
		if (!confirm('정말로 이 게시글을 삭제하시겠습니까?\n삭제된 게시글은 복구할 수 없습니다.')) {
			return; // 취소를 클릭한 경우 함수 종료
		}
		
		console.log(boardIdx);
        $.ajax({
            url: 'deleteBoard/' + boardIdx,
            type: 'DELETE',
            success: function(res) {
                alert('게시글이 성공적으로 삭제되었습니다.');
				location.reload();
                
            },
            error: function(xhr, status, error) {
                alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
	
});
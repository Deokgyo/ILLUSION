$(function(){
	// 게시글 삭제
	const deleteBtn = $('.delete-btn');
	
	deleteBtn.on('click', function(e) {
		const boardIdx = $(this).data('board-idx');
		console.log(boardIdx);
        $.ajax({
            url: 'deleteBoard/' + boardIdx,
            type: 'DELETE',
            success: function(res) {
                alert('삭제완료');
            },
            error: function(xhr, status, error) {
				debugger;
                alert('오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    });
	
});
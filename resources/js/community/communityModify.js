$(function(){
	
	// ---------- 변수 ----------
	
	// -------- events ---------
	
	$('form').on('submit', function(e){
		e.preventDefault();
		boardUpdate();	
	}); // 게시글 수정
	
	// ------- functions -----------
	
	// 게시글 수정
	function boardUpdate(){
		let board_idx = $('#board_idx').val();

		console.log(`api/board/${board_idx}`);
		
		if (!confirm('정말로 이 게시글을 수정하시겠습니까?')) {
        	return;
    	}
		
		 $.ajax({
            url: `api/board/${board_idx}`,
            type: 'POST',
	        data: {
	            title: $('#title').val(),
	            content: $('#content').val(),
	            category: $('#category').val()
    		},
    		dataType: 'text',
            success: function(res) {
				alert("수정 성공");
       			location.href = 'communityMain';
            },
            error: function(xhr, textStatus, errorThrown) {
				debugger;
                alert('수정 실패');
            }
        });
	}
});
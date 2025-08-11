$(function() {

	// ----- 변수 -----
	const board_idx = $('#board_idx').val();      
    const member_idx = $('#member_idx').val();
	
	// ----- 초기실행 -----
	getCmtList(); // 초기 화면에 댓글 불러와서 랜더링 작업
	
	// -------- events ---------
	
	$('form').on('submit', cmtSubmit); // 댓글 작성
	$('#delete_btn').on('click', boardDelete); // 게시글 삭제
	$('.comment-list').on('click', '.delete-comment-btn', function() {
	    const cmt_idx = $(this).data('comment-id'); 
	    deleteComment(cmt_idx);
	});
	
	// ----- functions ---------
    	
	function cmtSubmit(e) {
		e.preventDefault();
		
        const commentText = $('#cmt_textarea').val().trim();
        if (!commentText) {
            alert("댓글을 입력하세요.");
            return;
        }
        
        cmtWrite();
        $('#cmt_textarea').val('');
    }
	
	// 댓글 작성 및 조회    
    function cmtWrite() {
		const commentText = $('#cmt_textarea').val().trim();

        $.ajax({
            url: `api/boards/${board_idx}/comments`,
            type: 'POST',
            data: {
                comment: commentText,
                member_idx: member_idx
            },
//            dataType: 'json',
            success: function(res) {
				getCmtList();
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 등록 중 오류가 발생했습니다.');
            }
        });
	}
	
	// 댓글 가져오기
	function getCmtList() {

        $.ajax({
            url: `api/boards/${board_idx}/comments`,
            type: 'GET',
            dataType: 'json',
            success: function(res) {
				createCommentHtml(res);
				updateCommentCount(res.length);
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 등록 중 오류가 발생했습니다.');
            }
        });
	}
	// 댓글 삭제
	function deleteComment(cmt_idx) {
		if (!confirm('정말로 이 댓글을 삭제하시겠습니까?')) {
	        	return;
	    	}

        $.ajax({
            url: `api/boards/${board_idx}/comments/${cmt_idx}`,
            type: 'DELETE',
//            dataType: 'json',
            success: function(res) {
				alert("삭제 성공");
				getCmtList();	
            },
            error: function(xhr, textStatus, errorThrown) {
	            debugger;
                alert('댓글 삭제 중 오류가 발생했습니다.');
            }
        });
	}
	
	// 게시글 삭제
	function boardDelete(){
		if (!confirm('정말로 이 게시글을 삭제하시겠습니까?')) {
        	return;
    	}
		
		 $.ajax({
            url: `api/board/${board_idx}`,
            type: 'DELETE',
            success: function(res) {
				alert("삭제 성공");
       			location.href = 'communityMain';
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('삭제 실패');
            }
        });
	}
	
	// 댓글 카운트 함수
	function updateCommentCount(count) {
    $('#cmt_count').text(`댓글 ${count}`);
	}
	
	// 댓글영역 html 생성 함수
	function createCommentHtml(res){
		let result = '';
			res.forEach((e, i) => {
				result += 
                `
                <div class="comment-item">
                    <div class="comment-author-profile">
                        <i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i>
                    </div>
                    <div class="comment-content">
                        <div class="author-name">${e.member_id}</div>
                        <p class="comment-text">${e.cmt_content}</p>
                    </div>
	                <div class="comment-actions">
						<button type="button" class="delete-comment-btn" data-comment-id="${e.cmt_idx}">×</button>
					</div>
                </div>
                `;					
			})
			
			$('.comment-list').empty();
            $('.comment-list').append(result);
            
//            TODO => 여유되면 애니메이션 효과 적용해보기
//            $('.comment-list .comment-item:first-child').slideDown(300);
	} 

	
	// --------------------------
});
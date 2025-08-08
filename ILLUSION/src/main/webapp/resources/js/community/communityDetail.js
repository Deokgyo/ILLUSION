$(function() {

	getCmtList();	// 댓글 가져오기

	// ----- 변수 -----
	
	// -------- events ---------
	
	$('form').on('submit', cmtSubmit);
	
	// -------------------------
	
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
    
    function cmtWrite() {
		const commentText = $('#cmt_textarea').val().trim();
		const board_idx = $('#board_idx').val();      
        const member_idx = $('#member_idx').val(); 


        $.ajax({
            url: 'cmtWrite',
            type: 'POST',
            data: {
                comment: commentText,
                board_idx: board_idx,
                member_idx: member_idx
            },
            dataType: 'json',
            success: function(res) {
				getCmtList();
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 등록 중 오류가 발생했습니다.');
            }
        });
	}
	
	function getCmtList() {
		const board_idx = $('#board_idx').val();      

        $.ajax({
            url: 'cmtWrite',
            type: 'GET',
            data: {
                board_idx: board_idx,
            },
            dataType: 'json',
            success: function(res) {
				
				let result = '';
				res.forEach((e, i) => {
					result += 
	                `
	                <div class="comment-item">
	                    <div class="comment-author-profile">
	                        <i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i>
	                    </div>
	                    <div class="comment-content">
	                        <div class="author-name">${e.member_name}</div>
	                        <p class="comment-text">${e.cmt_content}</p>
	                    </div>
	                </div>
	                `;					
				})
				
				$('.comment-list').empty();
				$('#cmt_count').empty();
                $('.comment-list').append(result);
                $('#cmt_count').append(
					`
					<div class="comment-header" id="cmt_count">댓글 ${res.length}</div>
					`
				);
                $('.comment-list .comment-item:first-child').slideDown(300);

            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 등록 중 오류가 발생했습니다.');
            }
        });
	}
	
	// --------------------------
});

$(function() {

	// ------- 변수 --------
//	const board_idx = $('#board_idx').val();      
	
	// ------ 초기실행 ---------
	getCmtList(1); // 초기 화면에 댓글 불러와서 랜더링 작업
	
	// -------- events --------
	
	$('form').on('submit', cmtSubmit); // 댓글 작성
	$('#delete_btn').on('click', boardDelete); // 게시글 삭제 (작성자)
	$('#admin_delete_btn').on('click', adminBoardDelete); // 게시글 삭제 (관리자)
	$('.comment-list').on('click', '.delete-comment-btn', function() {
	    const cmt_idx = $(this).data('comment-id'); 
	    deleteComment(cmt_idx);
	});
	$('.comment-list').on('click', '.admin-delete-comment-btn', function() {
	    const cmt_idx = $(this).data('comment-id'); 
	    adminDeleteComment(cmt_idx);
	});
	
	// 페이지네이션 클릭 이벤트
    $('.pagination').on('click', 'a', function(e) {
        e.preventDefault();
        const pageNum = $(this).data('page');
        getCmtList(pageNum);
    });
	
	// ----- functions ---------
    	
	function cmtSubmit(e) {
	    e.preventDefault();
	
	    if (!loginId) { // 비로그인 상태
	        alert("로그인 후 댓글을 작성할 수 있습니다.");
	        return;
	    }
	
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
            },
//            dataType: 'json',
            success: function(res) {
				getCmtList(1);
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 등록 중 오류가 발생했습니다.');
            }
        });
	}
	
	// 댓글 가져오기
	function getCmtList(pageNum) {

        $.ajax({
            url: `api/boards/${board_idx}/comments`,
            type: 'GET',
            dataType: 'json',
            data: {
				pageNum: pageNum
			},
            success: function(res) {
				createCommentHtml(res.comments);
				updateCommentCount(res.pageInfo.listCount);
				renderPagination(res.pageInfo);
            },
            error: function(xhr, textStatus, errorThrown) {
                alert('댓글 조회 중 오류가 발생했습니다.');
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
            success: function(res) {
				alert("삭제 성공");
				getCmtList(1);	
            },
            error: function(xhr, textStatus, errorThrown) {
	            debugger;
                alert('댓글 삭제 중 오류가 발생했습니다.');
            }
        });
	}
	
 // 게시글 삭제
    function boardDelete() {
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
    function createCommentHtml(comments) {
        let result = '';
        if (comments && comments.length > 0) {
            comments.forEach((e) => {
                result += `
                    <div class="comment-item">
                        <div class="comment-author-profile">
                            <i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i>
                        </div>
                        <div class="comment-content">
                            <div class="author-name">${e.member_id}</div>
                            <p class="comment-text">${e.cmt_content}</p>
                        </div>
                        <div class="comment-actions">
                            ${e.member_id === loginId ? `<button class="delete-comment-btn" data-comment-id="${e.cmt_idx}">×</button>` : ''}
                            ${e.member_id !== loginId && isAdmin === 'true' ? `<button class="admin-delete-comment-btn btn-red-small" data-comment-id="${e.cmt_idx}">관리자 삭제</button>` : ''}
                        </div>
                    </div>
                `;
            });
        } else {
            result = '<p class="no-comments">아직 댓글이 없습니다.</p>';
        }

        $('.comment-list').empty().append(result);
    }

    // 페이지네이션 HTML 생성 함수
    function renderPagination(pageInfo) {
        const paginationContainer = $('.pagination');
        paginationContainer.empty();

        if (!pageInfo || pageInfo.listCount === 0) return;

        let paginationHtml = '';

        // 첫 페이지 버튼
        if (pageInfo.pageNum > 1) {
            paginationHtml += `<a href="#" class="page-arrow" data-page="1">&laquo;</a>`;
        }

        // 페이지 번호
        for (let i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
            if (i === pageInfo.pageNum) {
                paginationHtml += `<a href="#" class="active" data-page="${i}">${i}</a>`;
            } else {
                paginationHtml += `<a href="#" data-page="${i}">${i}</a>`;
            }
        }

        // 마지막 페이지 버튼
        if (pageInfo.pageNum < pageInfo.maxPage) {
            paginationHtml += `<a href="#" class="page-arrow" data-page="${pageInfo.maxPage}">&raquo;</a>`;
        }

        paginationContainer.html(paginationHtml);
    }
    
    // 관리자 게시글 삭제 함수
    function adminBoardDelete() {
        if (!confirm('관리자 권한으로 이 게시글을 삭제하시겠습니까?\n삭제된 게시글은 복구할 수 없습니다.')) {
            return;
        }
        
        $.ajax({
            url: `community/deleteBoard/${board_idx}`,
            type: 'DELETE',
            success: function(response) {
                alert('게시글이 관리자에 의해 삭제되었습니다.');
                location.href = 'communityMain';
            },
            error: function(xhr, status, error) {
                alert('삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }
    
    // 관리자 댓글 삭제 함수
    function adminDeleteComment(cmt_idx) {
        if (!confirm('관리자 권한으로 이 댓글을 삭제하시겠습니까?\n삭제된 댓글은 복구할 수 없습니다.')) {
            return;
        }
        
        $.ajax({
            url: `api/boards/${board_idx}/comments/${cmt_idx}`,
            type: 'DELETE',
            success: function(response) {
                alert('댓글이 관리자에 의해 삭제되었습니다.');
                getCmtList(1); // 댓글 목록 새로고침
            },
            error: function(xhr, status, error) {
                alert('댓글 삭제 중 오류가 발생했습니다. 다시 시도해주세요.');
            }
        });
    }

});
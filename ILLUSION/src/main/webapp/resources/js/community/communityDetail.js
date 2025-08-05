$(function(){
 $('#cmt_regist').on('click', function() {
		commentRegist();
    });
    
    
    
    
    function commentRegist(){
		const commentText = $('#cmt_textarea').val();

        const newCmt = 
        `
            <div class="comment-item" style="display:none;">
                <div class="comment-author-profile">
                    <i class="fa-solid fa-user fa-lg" style="color:#ccc;"></i>
                </div>
                <div class="comment-content">
                    <div class="author-name">test</div>
                    <p class="comment-text">${commentText}</p>
                </div>
            </div>
        `;

        $('.comment-list').prepend(newCmt);
        
        $('.comment-list .comment-item:first-child').slideDown(300);

        $('#cmt_textarea').val('');
	}
	

});
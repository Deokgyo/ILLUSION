$(function(){
    $('form').on('submit', function(e) {
        const commentText = $('#cmt_textarea').val().trim();

        if (!commentText) {
            alert("댓글을 입력하세요.");
            e.preventDefault();
            return;
        }

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
    });
});
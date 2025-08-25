$('.bookmark-btn').on('click', function() {
    const $button = $(this);
    const recruitIdx = $button.data('recruitIdx');
    const url = `${contextPath}/api/scraps/${recruitIdx}/toggle`;
    
    $.ajax({
        url: url,
        method: 'POST',
        dataType: 'json',
        success: function(response) {
            if (response.status === 'success') {
                // 서버가 보내준 최종 스크랩 상태(isScrapped)에 따라 버튼 클래스를 토글
                $button.toggleClass('active', response.isScrapped);
                console.log("현재 스크랩 상태:", response.isScrapped);
            } else {
                alert(response.message);
            }
        },
        error: function(xhr) {
            if (xhr.status === 403 || xhr.status === 401) { 
                alert("로그인이 필요한 기능입니다.");
                location.href = contextPath + '/login';
            } else {
                alert("오류가 발생했습니다.");
            }
        }
    });
});
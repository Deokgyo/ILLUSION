$(function() {
	//======================================
	//			이 벤 트 연 결 
	//======================================
	$(document).on('click', '.save', function() {
    	saveMypage(this);
	});

	$(document).on('click', '.submit', function() {
   	 	submit(this);
	});
});
	
	
	//======================================
	//			함 수 선 언 부 
	//======================================
	
	
	// --- 최종 제출 버튼 클릭 이벤트 -> 모달창 띄우기 ---
    function createClick() {
	$('#confirm-modal').fadeOut();
        $('#loading-overlay').css('display', 'flex').fadeTo(300, 1);
            
        }
    
    $('.btn-no, .close-modal-btn').on('click', function() {
    	$(this).closest('.modal-overlay').fadeOut();    
    });
    
	
	
	
	// 답변에 대한 피드백 받기 
	function submit(button) {
		
		// 모달 띄우기
		createClick();
		// 클릭한 버튼 기준으로 부모 카드 찾기
        const card = $(button).closest('.question-card');
        // 질문 텍스트
        const question = card.find('.q-text').text();
        // 사용자 답변
        const answer = card.find('textarea').val();
		const feedback = card.find('.feedback-text');
		console.log(question);
        console.log(answer);
        
        // ajax 호출 
        $.ajax({
			type: 'post',
			url: 'getAiFeedback',
			dataType: "json",
			data: {question : question,
				   answer : answer},
			success: function(res) {
				$('.btn-no, .close-modal-btn').click();
				feedback.empty().html(res.feedback);
			},
			error: function(xhr, status, error) {
				alert('연결실패');
				console.log(xhr);
			}
		});
	}
	
	// 질문 답변 피드백 저장하기 => answer 테이블
	function saveMypage(button) {
		// 클릭한 버튼 기준으로 부모 카드 찾기
        const card = $(button).closest('.question-card');
        // 질문 텍스트
        const question_idx = card.find('.question_idx').text();
        // 사용자 답변
        const answer = card.find('textarea').val();
        // AI 피드백
        const feedback = card.find('.feedback-text').text();
		console.log(question_idx);
        console.log(answer);
        console.log(feedback);
		// ajax 호출해서 디비에 저장 해야함 
		
		$.ajax({
			url: 'saveAnswer',
			method: 'post',
			data: {question_idx : question_idx,
				   answer : answer,
				   feedback : feedback},
			success: function() {
				alert('저장 되었습니다')
			},
			error: function(xhr, status, error) {
				alert('저장실패');
				console.log(xhr);
			}
		});
		
		
	}
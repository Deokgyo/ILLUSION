$(function() {

    const $initialView = $('.chat-initial-view');
    const $conversationView = $('.chat-conversation-view');
    const $chatMessages = $('.chat-messages');
    const $chatArea = $('.chat-messages-area');
    const $inputForm = $('.message-input-form'); 
    const $messageInput = $('#message-input');
    const $tokenModal = $('#token-modal');
    const $tokenRechargeBtn = $('.btn-token-charge');

    // 모달 열기
    function openTokenModal() {
        $tokenModal.fadeIn(200);
    }

    // 모달 닫기
    function closeTokenModal() {
        $tokenModal.fadeOut(200);
    }

    // 대화 시작 (초기 화면 숨기고 대화창 보이기)
    function startConversation() {
        if ($initialView.is(':visible')) {
            $initialView.fadeOut(200, function() {
                $conversationView.fadeIn(200);
            });
        }
    }

    // 채팅 메시지(말풍선) 추가 및 스크롤 맨 아래로 이동
	function addMessage(text, sender) {
	    const bubbleClass = sender === 'user' ? 'user' : 'bot';
	    const $bubble = $('<div class="chat-bubble"></div>').addClass(bubbleClass);
	
	    if (sender === 'bot') {
	        let formattedText = text;
	        formattedText = formattedText.replace(/\n/g, '<br>');
	        formattedText = formattedText.replace(/### (.*?)(<br>|$)/g, '<h3>$1</h3>');
	        formattedText = formattedText.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
	        $bubble.html(formattedText);
	    } else {
	        $bubble.text(text);
	    }
	    
	    $chatMessages.append($bubble);
	    $chatArea.scrollTop($chatArea[0].scrollHeight);
	}

    
    

    // 기본 질문 클릭 시
    $('.suggested-questions a').on('click', function(e) {
        e.preventDefault();
        // [삭제됨] 불필요한 프론트엔드 토큰 체크 로직
        const questionText = $(this).find('span').text();
        startConversation();
        addMessage(questionText, 'user');
        getAiResponse(questionText);
    });
    
    // 메시지 입력 폼 제출 시 
    $inputForm.on('submit', function(e) {
        e.preventDefault();
        const messageText = $messageInput.val().trim();
        if (messageText === '') return;

        const $submitButton = $(this).find('button[type="submit"]');
        $submitButton.prop('disabled', true);
        $messageInput.prop('disabled', true);

        startConversation();
        addMessage(messageText, 'user');
        $messageInput.val('');
        
        const $loadingBubble = $('<div class="chat-bubble bot typing"><span>.</span><span>.</span><span>.</span></div>');
        $chatMessages.append($loadingBubble);
        $chatArea.scrollTop($chatArea[0].scrollHeight);

        $.ajax({
            type: 'POST',
            url: 'aiChat', 
            data: { message: messageText },
            dataType: 'json', 
            success: function(res) {
                $loadingBubble.remove();
                if (res.success && res.reply) {
                    addMessage(res.reply, 'bot');
                    if (res.newToken !== undefined) {
                        $('#sidebar-token-count').text(res.newToken);
                    }
                } else {
                    const errorMessage = res.message || '답변을 생성하는 데 실패했어요.';
                    addMessage(errorMessage, 'bot');
                }
            },
            error: function(xhr, status, error) {
                $loadingBubble.remove();
                console.error("AJAX Error:", status, error); 
                addMessage('죄송합니다. 서버와 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'bot');
            },
            complete: function() {
                $submitButton.prop('disabled', false);
                $messageInput.prop('disabled', false);
            }
        });
    });

    // 토큰 충전 버튼 클릭 시
    $tokenRechargeBtn.on('click', function() {
        const currentTokens = $('#sidebar-token-count').text();
        $('#modal-token-count').text(currentTokens);
        openTokenModal();
    });

    // 모달 창의 아니요, X 버튼 클릭 시
    $tokenModal.on('click', '.btn-no, .close-modal-btn', function() {
        closeTokenModal();
    });

    // 모달 바깥의 어두운 영역 클릭 시 닫기
    $tokenModal.on('click', function(event) {
        if (event.target === this) {
            closeTokenModal();
        }
    });
    
    // ESC 키로 모달 창 닫기
    $(document).on('keydown', function(event) {
        if (event.key === 'Escape' && $tokenModal.is(':visible')) {
            closeTokenModal();
        }
    });

});
$(function() {
    
    // 필요한 요소들을 변수에 할당
    const $initialView = $('.chat-initial-view');
    const $conversationView = $('.chat-conversation-view');
    const $chatMessages = $('.chat-messages');
    const $inputForm = $('.message-input-form'); 
    const $messageInput = $('#message-input');
    const $modal = $('#token-modal'); // 모달 오버레이

    // --- 시뮬레이션용 변수 ---
    let hasTokens = true;
    
    // --- 기능 함수 ---
    function openTokenModal() {
        $modal.removeClass('hidden');
    }
    function closeTokenModal() {
        $modal.addClass('hidden');
    }

    function startConversation() {
        if ($initialView.is(':visible')) {
            $initialView.fadeOut(200, function() {
                $conversationView.fadeIn(200);
            });
        }
    }

    function addMessage(text, sender) {
        const bubbleClass = sender === 'user' ? 'user' : 'bot';
        const $bubble = $('<div class="chat-bubble"></div>').addClass(bubbleClass).text(text);
        $chatMessages.append($bubble);
        $('.chat-messages-area').scrollTop($('.chat-messages-area')[0].scrollHeight);
    }
    
    // --- 이벤트 핸들러 ---
    
    // 1. 추천 질문 클릭 시
    $('.suggested-questions a').on('click', function(e) {
        e.preventDefault();
        
        if (!hasTokens) {
            openTokenModal(); 
            return;
        }

        const questionText = $(this).find('span').text();
        startConversation();
        addMessage(questionText, 'user');
        setTimeout(() => addMessage("네, 그 질문에 대해 답변해 드릴게요!", 'bot'), 1000);
    });
    
    // 2. 메시지 입력 폼 제출 시
    $inputForm.on('submit', function(e) {
        e.preventDefault();
        const messageText = $messageInput.val().trim();
        
        if (messageText === '') return;
        
        if (!hasTokens) {
            openTokenModal(); 
            return;
        }

        startConversation();
        addMessage(messageText, 'user');
        $messageInput.val('');
        setTimeout(() => addMessage("흥미로운 질문이네요! 잠시만요.", 'bot'), 1000);
    });

    // 3. 토큰 충전 버튼 클릭 시
    $('.gradient-btn').on('click', function() {
        openTokenModal(); // ✅ 수정: 모달 열기 함수 호출
    });
    

    // 4. 모달 안의 '아니요', '네' 버튼, 닫기(X) 버튼 클릭 시
    $modal.on('click', '.btn-no, .btn-yes, .modal-close-btn', function() {
        closeTokenModal();
    });

    // 5. 모달 바깥의 어두운 영역 클릭 시
    $modal.on('click', function(event) {
        if (event.target === this) {
            closeTokenModal();
        }
    });
    
    // $modal.on('click', '.btn-yes', function(){ window.location.href = '/payment'; });

    // 6. ESC 키를 눌렀을 때
    $(document).on('keydown', function(event) {
        // 모달이 열려 있을 때만 (hidden 클래스가 없을 때)
        if (event.key === 'Escape' && !$modal.hasClass('hidden')) {
            closeTokenModal();
        }
    });
    

});
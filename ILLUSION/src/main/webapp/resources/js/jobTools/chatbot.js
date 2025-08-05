$(function() {
    
    const $initialView = $('.chat-initial-view');
    const $conversationView = $('.chat-conversation-view');
    const $chatMessages = $('.chat-messages');
    const $chatArea = $('.chat-messages-area');
    const $inputForm = $('.message-input-form'); 
    const $messageInput = $('#message-input');
    const $tokenModal = $('#token-modal');
    const $tokenRechargeBtn = $('.btn-token-charge');

    let hasTokens = true; 


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

    // 채팅 메시지 추가 및 스크롤 맨 아래로 이동
    function addMessage(text, sender) {
        const bubbleClass = sender === 'user' ? 'user' : 'bot';
        const $bubble = $('<div class="chat-bubble"></div>').addClass(bubbleClass).text(text);
        
        $chatMessages.append($bubble);
        
        // 스크롤을 항상 맨 아래로 이동
        $chatArea.scrollTop($chatArea[0].scrollHeight);
    }

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
        
        setTimeout(() => addMessage("네, '" + questionText + "'에 대해 답변해 드릴게요! 잠시만 기다려주세요.", 'bot'), 1000);
    });
    
    // 2. 메시지 입력 폼 제출 시 (전송 버튼 클릭 또는 Enter)
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
        
        // 1초 후 봇 답변 시뮬레이션
        setTimeout(() => addMessage("흥미로운 질문이네요! 잠시만요.", 'bot'), 1000);
    });

    // 3. 토큰 충전 버튼 클릭 시
    $tokenRechargeBtn.on('click', function() {
        openTokenModal();
    });

    // 4. 모달 안의 '아니요', '네', 닫기(X) 버튼 클릭 시
    // '네' 버튼은 a 태그이므로 페이지 이동이 기본 동작
    $tokenModal.on('click', '.btn-no, .close-modal-btn', function() {
        closeTokenModal();
    });

    // 5. 모달 바깥의 어두운 영역 클릭 시
    $tokenModal.on('click', function(event) {
        if (event.target === this) {
            closeTokenModal();
        }
    });
    
    // $modal.on('click', '.btn-yes', function(){ window.location.href = '/payment'; });
    
    // 6. ESC 키를 눌렀을 때
    $(document).on('keydown', function(event) {
        if (event.key === 'Escape' && $tokenModal.is(':visible')) {
            closeTokenModal();
        }
    });

});
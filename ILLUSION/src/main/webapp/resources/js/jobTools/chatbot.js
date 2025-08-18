$(function() {

    const $initialView = $('.chat-initial-view');
    const $conversationView = $('.chat-conversation-view');
    const $chatMessages = $('.chat-messages');
    const $chatArea = $('.chat-messages-area');
    const $inputForm = $('.message-input-form'); 
    const $messageInput = $('#message-input');
    const $tokenModal = $('#token-modal');
    const $tokenRechargeBtn = $('.btn-token-charge');

    // TODO 로그인한 사용자 토큰으로 수정해야함
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

    // 채팅 메시지(말풍선) 추가 및 스크롤 맨 아래로 이동
	function addMessage(text, sender) {
	    const bubbleClass = sender === 'user' ? 'user' : 'bot';
	    const $bubble = $('<div class="chat-bubble"></div>').addClass(bubbleClass);
	
	    if (sender === 'bot') {
	        let formattedText = text;
	        
	        // 1. 줄바꿈 -> <br>
	        formattedText = formattedText.replace(/\n/g, '<br>');
	        
	        // 2. ### 제목 -> <h3>제목</h3>
	        formattedText = formattedText.replace(/### (.*?)(<br>|$)/g, '<h3>$1</h3>');
	
	        // 3. **굵은 글씨** -> <strong>굵은 글씨</strong>
	        formattedText = formattedText.replace(/\*\*(.*?)\*\*/g, '<strong>$1</strong>');
	        
	        $bubble.html(formattedText);
	        
	    } else {
	        $bubble.text(text);
	    }
	    
	    $chatMessages.append($bubble);
	    $chatArea.scrollTop($chatArea[0].scrollHeight);
	}

    
    //서버에 메시지를 보내고 AI 답변을 받아오는 함수
     
    function getAiResponse(userMessage) {
        // 1. "답변 생성 중" 로딩 인디케이터를 화면에 먼저 표시 (UX 개선)
        // CSS에 .bot.typing 클래스에 대한 애니메이션 스타일이 필요합니다.
        const $loadingBubble = $('<div class="chat-bubble bot typing"><span>.</span><span>.</span><span>.</span></div>');
        $chatMessages.append($loadingBubble);
        $chatArea.scrollTop($chatArea[0].scrollHeight);

        $.ajax({
            type: 'POST',
            url: 'aiChat', 
            data: {
                message: userMessage 
            },
            dataType: 'json', 
            success: function(res) {
                $loadingBubble.remove(); // 로딩 인디케이터 제거
                if (res.success && res.reply) {
                    addMessage(res.reply, 'bot'); // 서버로부터 받은 AI 답변을 화면에 추가
                } else {
                    addMessage('죄송합니다. 답변을 생성하는 데 실패했어요.', 'bot');
                }
            },
            error: function(xhr, status, error) {
                $loadingBubble.remove(); // 로딩 인디케이터 제거
                console.error("AJAX Error:", status, error); 
                addMessage('죄송합니다. 서버와 통신 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'bot');
            }
        });
    }


    // 기본 질문 클릭 시
    $('.suggested-questions a').on('click', function(e) {
        e.preventDefault();
        
        if (!hasTokens) {
            openTokenModal(); 
            return;
        }

        const questionText = $(this).find('span').text();
        startConversation();
        addMessage(questionText, 'user');
        
        // [MODIFIED] 시뮬레이션(setTimeout) 대신 실제 AI에게 답변 요청
        getAiResponse(questionText);
    });
    
    // 메시지 입력 폼 제출 시 
    $inputForm.on('submit', function(e) {
        e.preventDefault();
        const messageText = $messageInput.val().trim();
        
        if (messageText === '') return; // 입력값이 없으면 아무것도 하지 않음
        
        if (!hasTokens) {
            openTokenModal(); 
            return;
        }

        startConversation();
        addMessage(messageText, 'user'); // 사용자가 입력한 메시지를 먼저 화면에 표시
        $messageInput.val(''); // 입력창 비우기
        
        getAiResponse(messageText);
    });

    // 토큰 충전 버튼 클릭 시
    $tokenRechargeBtn.on('click', function() {
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
    
    // 모달 창 닫기
    $(document).on('keydown', function(event) {
        if (event.key === 'Escape' && $tokenModal.is(':visible')) {
            closeTokenModal();
        }
    });

});
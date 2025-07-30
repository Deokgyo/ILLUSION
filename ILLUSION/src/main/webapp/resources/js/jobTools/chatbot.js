//$(function() {
//    
//    // 필요한 요소들을 변수에 할당
//    const $initialView = $('.chat-initial-view');
//    const $conversationView = $('.chat-conversation-view');
//    const $chatMessages = $('.chat-messages');
//    const $inputForm = $('.chat-input-form');
//    const $messageInput = $('#message-input');
//    const $modal = $('#token-modal');
//
//    // --- 시뮬레이션용 변수 ---
//    let hasTokens = true; // 실제로는 서버에서 사용자의 토큰 보유 여부를 받아와야 함
//    
//    // --- 기능 함수 ---
//    
//    // 대화 시작 시 호출될 함수
//    function startConversation() {
//        if ($initialView.is(':visible')) {
//            $initialView.fadeOut(200, function() {
//                $conversationView.fadeIn(200);
//            });
//        }
//    }
//
//    // 말풍선을 추가하는 함수
//    function addMessage(text, sender) {
//        const bubbleClass = sender === 'user' ? 'user' : 'bot';
//        const $bubble = $('<div class="chat-bubble"></div>').addClass(bubbleClass).text(text);
//        $chatMessages.append($bubble);
//        // 새 메시지가 추가되면 스크롤을 맨 아래로 이동
//        $('.chat-main-area').scrollTop($('.chat-main-area')[0].scrollHeight);
//    }
//    
//    // --- 이벤트 핸들러 ---
//    
//    // 1. 추천 질문 클릭 시
//    $('.suggested-questions a').on('click', function(e) {
//        e.preventDefault();
//        
//        if (!hasTokens) { // 토큰 없으면 모달 표시
//            $modal.fadeIn();
//            return;
//        }
//
//        const questionText = $(this).find('span').text();
//        startConversation();
//        addMessage(questionText, 'user');
//        // (시뮬레이션) 챗봇이 답변하는 것처럼 보이게 함
//        setTimeout(() => addMessage("네, 그 질문에 대해 답변해 드릴게요!", 'bot'), 1000);
//    });
//    
//    // 2. 메시지 입력 폼 제출 시
//    $inputForm.on('submit', function(e) {
//        e.preventDefault();
//        const messageText = $messageInput.val().trim();
//        
//        if (messageText === '') return;
//        
//        if (!hasTokens) { // 토큰 없으면 모달 표시
//            $modal.fadeIn();
//            return;
//        }
//
//        startConversation();
//        addMessage(messageText, 'user');
//        $messageInput.val(''); // 입력창 비우기
//        // (시뮬레이션) 챗봇이 답변하는 것처럼 보이게 함
//        setTimeout(() => addMessage("흥미로운 질문이네요! 잠시만요.", 'bot'), 1000);
//    });
//
//    // 3. 토큰 부족 모달 버튼 이벤트
//    $modal.on('click', '.btn-no, .btn-yes', function() {
//        $modal.fadeOut();
//    });
//    // (참고) '.btn-yes'를 누르면 실제로는 결제 페이지로 이동하는 로직이 추가되어야 함
//    // $('.btn-yes').on('click', function(){ window.location.href = '/payment'; });
//
//});
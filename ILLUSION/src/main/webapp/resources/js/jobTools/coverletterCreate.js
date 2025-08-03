$(function() {

    // --- 1. 경력사항 선택 (신입/경력) 기능 ---
    $('#experience-toggle .option').on('click', function() {
        const $this = $(this);
        const selectedValue = $this.data('value');

        $this.addClass('active').siblings().removeClass('active');

        if (selectedValue === 'experienced') {
            $('#experience-fields').slideDown(300); // 300ms 동안 부드럽게 나타남
        } else {
            $('#experience-fields').slideUp(300); // 300ms 동안 부드럽게 사라짐
        }
    });
    
  	 // --- 1-1. 경력 기간 드롭다운 기능 (수정 완료) ---
	// 이 코드는 현재 HTML 구조에 완벽하게 동작하므로 수정할 필요 없습니다.
		const $dropdownSelect = $('#experience-level-select');
		const $dropdownMenu = $dropdownSelect.next('.dropdown-menu');
		
		// 드롭다운 헤더 클릭 시 메뉴 토글
		$dropdownSelect.on('click', function(e) {
		    e.stopPropagation(); 
		    $dropdownMenu.slideToggle(200);
		});

	// 드롭다운 아이템 클릭 시
	$dropdownMenu.on('click', '.dropdown-item', function() {
	    const selectedText = $(this).text();
	    $dropdownSelect.find('span').text(selectedText);
	});
	
	$(document).on('click', function(e) {
	    if (!$dropdownMenu.is(e.target) && $dropdownMenu.has(e.target).length === 0) {
	        $dropdownMenu.slideUp(200);
	    }
	});

    // --- 2. 직무 선택 및 태그 추가/삭제 기능 ---
    $('.category-options .option-btn').on('click', function() {
        const $this = $(this);
        const keyword = $this.text().trim();
        const $formSection = $this.closest('.form-section');
        const $targetArea = $formSection.find('.selected-tags-area');

        $this.toggleClass('active');

        if ($this.hasClass('active')) {
            const tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
            $targetArea.append(tagHTML);
        } else {
            $targetArea.find(`.tag[data-keyword="${keyword}"]`).remove();
        }
    });

    // 동적으로 생성된 태그의 삭제 버튼 이벤트
    $('.selected-tags-area').on('click', '.close-btn', function() {
        const $tag = $(this).parent('.tag');
        const keyword = $tag.data('keyword');
        
        $('.option-btn').filter(function() {
            return $(this).text().trim() === keyword;
        }).removeClass('active');
        $tag.remove();
    });

    // --- 4. 폼 유효성 검사 및 생성 버튼 활성화 ---
    const $generateBtn = $('#generate-btn');
    const $form = $('#resume-form'); 

    function validateForm() {
        let isValid = true;
        if ($('input[name="title"]').val().trim() === '' || $('input[name="company"]').val().trim() === '') {
            isValid = false;
        }
        if ($('.category-options .option-btn.active').length === 0) {
            isValid = false;
        }
        return isValid;
    }

    $form.on('input keyup click change', function() {
        if (validateForm()) {
            $generateBtn.prop('disabled', false);
        } else {
            $generateBtn.prop('disabled', true);
        }
    });

    // --- 5. 생성 버튼 클릭 및 모달 로직 ---
	$generateBtn.on('click', function(e) {
	    e.preventDefault();
	    const userTokens = 50;
	    if (userTokens < 30) {
	        $('#token-modal').css('display', 'flex').fadeTo(300, 1);
	    } else {
	        $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
	    }
	});
	
	$('#confirm-yes-btn').on('click', function() {
	    $('#confirm-modal').fadeOut();
	    $('#loading-overlay').css('display', 'flex').fadeTo(300, 1);
	    setTimeout(function() {
	        alert("AI 생성 중...");
	        $('#loading-overlay').fadeOut();
	    }, 2000);
	});
	
	$('.btn-no').on('click', function() {
	    $(this).closest('.modal-overlay').fadeOut();
	});
});
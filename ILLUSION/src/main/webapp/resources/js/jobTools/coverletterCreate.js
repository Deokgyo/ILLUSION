$(function() {

    // 경력사항 선택 (신입/경력) 기능
    $('#experience-toggle .option').on('click', function() {
        const $this = $(this);
        const selectedValue = $this.data('value');

        $this.addClass('active').siblings().removeClass('active');

        if (selectedValue === 'experienced') {
            $('#experience-fields').slideDown(300); 
        } else {
            $('#experience-fields').slideUp(300); 
        }
    });
    
  	 // 경력 기간 드롭다운 기능
	const $dropdownSelect = $('#experience-level-select');
	
	$dropdownSelect.on('click', function(e) {
	    e.stopPropagation(); 
	    $(this).closest('.dropdown-wrapper').find('.form-dropdown-menu').slideToggle(200);
	});
	
	$('.dropdown-wrapper').on('click', '.form-dropdown-item', function() {
	    const selectedText = $(this).text();
	    $(this).closest('.form-dropdown-menu').siblings('.dropdown-select').find('span').text(selectedText);
	    $(this).closest('.form-dropdown-menu').slideUp(200);
	});
	
	$(document).on('click', function(e) {
	    if ($('.dropdown-wrapper').has(e.target).length === 0) {
	        $('.form-dropdown-menu').slideUp(200);
	    }
	});
	
	//================================ 3.직무 선택영역 ==================================
	
	//=============0. ajax 호출 함수 ===============
	function ajaxReq(url, method, key, value, func) {
		$.ajax({
			url: url, method: method,
			data: { [key] : value },dataType: 'json',
			success: function(res) {
				func(res);
			},
			error : function() {
				alert('실패!');
			}	
		});
	}
	
	//3. 직무 선택
	//3-1) 직무 부분 온클릭 이벤트
	$('.occupation').on('click', occupationActive);
	//3-2) 세부 직무 부분 온클릭 이벤트  
	$(document).on('click', '.job', function () {
		jobActive(this);
		updateKeyword(this);
		updateJobValue();
	});
	//3-3) 키워드 삭제 버튼 이벤트 
	$(document).on('click', '.close-btn', function() {
		deleteKeyword(this);
		updateJobValue();
	});
	
	$('.occupation').first().trigger('click');
	
	function occupationActive() {
		$('.occupation').removeClass('active');
		$(this).addClass('active');
		const occupation = $(this).data('value');
		ajaxReq('getJobList', 'GET', 'occupation', occupation, renderJobs);
	}
	
	function renderJobs(getJobList) {
		$('#jobs').empty();
		let joblist = [];
		for(let job of getJobList) {
			joblist.push($(`<div class="option-btn job" data-code='${job.code}'>
				${job.code_name}</div>`));
		}
		$('#jobs').append(joblist);
	}
	
	// 세부 직무 active 주기 
	function jobActive (el) {
		if (!($(el).hasClass('active'))) {
			$(el).addClass('active');
		} else {
			$(el).removeClass('active');
		}
	}
	
	// 키워드 추가하기 
	function updateKeyword(el) {
		// 액티브된 세부 직무의 밸류 값을 추출
		// 요소 만드는 메서드에 액티브된 세무 직무의 밸류 값을 넣어서 생성하게 만들기 
		let keyword = $(el).text();
		if ($(el).hasClass('active')) {
	        let tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span>
	        	<span class="close-btn">x</span></div>`;
	        $('.selected-tags-area').append(tagHTML);
		} else {
			//현재 선택된 keyword 값과 같은 <span>태그의 값을 가진 div 요소 제거 
			$(`.tag[data-keyword="${keyword}"]`).remove();			
		}
	}
	
	// 활성화 된 값 input hidden value에 넣기 
	function updateJobValue () {
		let $jobValue = $('.job.active').map(function() {
			return $(this).data('code');
			}).get().join(', ');
		$('#selected-occupation').val($jobValue);
	}
	
	// 키워드 삭제
	function deleteKeyword (el) {
		const keyword = $(el).siblings('span').text().trim(); // 선택한 키워드
		$(`.job.active`).filter(function() {
	  		return $(el).text().trim() === keyword;
	  	}).removeClass('active');
	  $(el).closest('.tag').remove();
	}
	
	
//
//    // 직무 선택 및 태그 추가/삭제 기능 
//    $('.category-options .option-btn').on('click', function() {
//        const $this = $(this);
//        const keyword = $this.text().trim();
//        const $formSection = $this.closest('.form-section');
//        const $targetArea = $formSection.find('.selected-tags-area');
//
//        $this.toggleClass('active');
//
//        if ($this.hasClass('active')) {
//            const tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
//            $targetArea.append(tagHTML);
//        } else {
//            $targetArea.find(`.tag[data-keyword="${keyword}"]`).remove();
//        }
//    });
//
//    // 동적으로 생성된 태그의 삭제 버튼 이벤트
//    $('.selected-tags-area').on('click', '.close-btn', function() {
//        const $tag = $(this).parent('.tag');
//        const keyword = $tag.data('keyword');
//        
//        $('.option-btn').filter(function() {
//            return $(this).text().trim() === keyword;
//        }).removeClass('active');
//        $tag.remove();
//    });

    // 폼 유효성 검사 및 생성 버튼 활성화 
//    const $generateBtn = $('#generate-btn');
//    const $form = $('#resume-form'); 
//
//    function validateForm() {
//        let isValid = true;
//        if ($('input[name="title"]').val().trim() === '' || $('input[name="company"]').val().trim() === '') {
//            isValid = false;
//        }
//        if ($('.category-options .option-btn.active').length === 0) {
//            isValid = false;
//        }
//        return isValid;
//    }
//
//    $form.on('input keyup click change', function() {
//        if (validateForm()) {
//            $generateBtn.prop('disabled', false);
//        } else {
//            $generateBtn.prop('disabled', true);
//        }
//    });

    // 5. 생성 버튼 클릭 및 모달 로직 
//	$generateBtn.on('click', function(e) {
//	    e.preventDefault();
//	    const userTokens = 50;
//	    if (userTokens < 30) {
//	        $('#token-modal').css('display', 'flex').fadeTo(300, 1);
//	    } else {
//	        $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
//	    }
//	});
//	
//	$('#confirm-yes-btn').on('click', function() {
//	    $('#confirm-modal').fadeOut();
//	    $('#loading-overlay').css('display', 'flex').fadeTo(300, 1);
//	    setTimeout(function() {
//	        alert("창닫기");
//	        $('#loading-overlay').fadeOut();
//	    }, 2000);
//	});
//	
//	$('.btn-no').on('click', function() {
//	    $(this).closest('.modal-overlay').fadeOut();
//	});
});
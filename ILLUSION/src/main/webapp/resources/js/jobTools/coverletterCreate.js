$(function() {

    // =========================================================================
    // 1. 경력 사항 관련 기능
    // =========================================================================

    // 신입/경력 선택 토글 
    $('#experience-toggle').on('click', '.option', function() {
        const $this = $(this);
        const selectedValue = $this.data('value');

        // (UI 처리) 클릭된 버튼에 'active' 클래스를 주고, 다른 버튼에선 제거합니다.
        $this.addClass('active').siblings().removeClass('active');
        
        // (데이터 처리) 숨겨진 input에 선택된 값 ('new' 또는 'experienced')을 저장합니다.
        $('#experience-type-value').val(selectedValue);

        // '경력'을 선택했을 때만 경력 상세 입력 필드를 보여줍니다.
        if (selectedValue === 'experienced') {
            $('#experience-fields').slideDown(300);
        } else {
            $('#experience-fields').slideUp(300);
        }
    });

    // 경력 기간 커스텀 드롭다운
    $('#experience-level-select').on('click', function(e) {
        e.stopPropagation(); 
        $(this).closest('.dropdown-wrapper').find('.form-dropdown-menu').slideToggle(200);
    });
    
    $('.form-dropdown-menu').on('click', '.form-dropdown-item', function() {
        const selectedValue = $(this).data('value'); // data-value 속성 값 가져오기
        const selectedText = $(this).text(); // 화면에 보이는 텍스트 가져오기

        $('#experience-level-value').val(selectedValue);
        $('#experience-level-select > span').text(selectedText);
        $(this).closest('.form-dropdown-menu').slideUp(200);
    });
    
    // 드롭다운 메뉴 바깥 영역을 클릭하면 메뉴를 닫습니다.
    $(document).on('click', function(e) {
        // 클릭된 요소가 드롭다운 영역(.dropdown-wrapper) 내부가 아닐 경우에만
        if ($('.dropdown-wrapper').has(e.target).length === 0) {
            $('.form-dropdown-menu').slideUp(200);
        }
    });


    // =========================================================================
    // 2. 직무 선택 관련 기능 (AJAX 사용)
    // =========================================================================

    // 공통 AJAX 요청 함수 
    function ajaxReq(url, method, data, func) {
        $.ajax({
            url: url,
            method: method,
            data: data, // 데이터를 객체로 받도록 수정
            dataType: 'json',
            success: function(res) {
                func(res); // 성공 시 콜백 함수 실행
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                alert('데이터를 불러오는 데 실패했습니다.');
            }   
        });
    }

    // 직무 선택 로직을 위한 함수들
    
    // 직무 카테고리 클릭 시 동작하는 메인 함수
    function activateOccupation() {
        $('.occupation').removeClass('active');
        $(this).addClass('active');
        const occupationCode = $(this).data('value');
        
        // 선택된 직무 카테고리에 맞는 세부 직무 목록을 서버에 요청
        ajaxReq('getJobList', 'GET', { occupation: occupationCode }, renderJobs);
    }

    // 서버에서 받은 세부 직무 목록을 화면에 렌더링하는 함수
    function renderJobs(jobList) {
        const $jobsContainer = $('#jobs');
        $jobsContainer.empty(); // 기존 목록 초기화
        
        if (jobList && jobList.length > 0) {
            const jobElements = jobList.map(function(job) {
                return `<div class="option-btn job" data-code='${job.code}'>${job.code_name}</div>`;
            });
            $jobsContainer.append(jobElements.join(''));
        }
    }

    // 세부 직무 클릭 시 'active' 클래스를 토글하고, 선택된 태그와 hidden input 값을 업데이트
    function handleJobClick() {
        $(this).toggleClass('active');
        updateSelectedJobTags();
        updateHiddenJobInput();
    }
    
    // 선택된 세부 직무에 맞춰 화면 하단의 태그를 업데이트하는 함수
    function updateSelectedJobTags() {
        const $tagsArea = $('.selected-tags-area');
        $tagsArea.empty(); // 태그 영역 초기화
        
        $('.job.active').each(function() {
            const keyword = $(this).text();
            const tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
            $tagsArea.append(tagHTML);
        });
    }

    // 태그의 'x' 버튼 클릭 시 해당 태그와 직무 선택을 해제하는 함수
    function deleteJobTag() {
        const keyword = $(this).closest('.tag').data('keyword');
        
        // 태그에 해당하는 직무 버튼을 찾아서 'active' 클래스 제거
        $('.job.active').filter(function() {
            return $(this).text() === keyword;
        }).removeClass('active');
        
        // 태그 자체를 삭제
        $(this).closest('.tag').remove();
        
        // hidden input 값 다시 업데이트
        updateHiddenJobInput();
    }
    
    // (데이터 처리) 'active' 상태인 모든 세부 직무의 코드 값을 콤마(,)로 연결하여 hidden input에 저장
    function updateHiddenJobInput() {
        const selectedJobCodes = $('.job.active').map(function() {
            return $(this).data('code');
        }).get().join(','); // 콤마로 구분된 문자열로 만듦
        
        $('#selected-occupation').val(selectedJobCodes);
    }

    $('.occupation').on('click', activateOccupation);
    $(document).on('click', '.job', handleJobClick); // 동적으로 생성되므로 document에 위임
    $(document).on('click', '.close-btn', deleteJobTag); // 동적으로 생성되므로 document에 위임

    if ($('.occupation').length > 0) {
        $('.occupation').first().trigger('click');
    }


    // 최종 폼 제출 기능 (AJAX)
    $('#coverletter-form').on('submit', function(e) {
        e.preventDefault();

        const formData = $(this).serialize();
        
        console.log('서버로 전송될 최종 데이터:', formData);
        
        debugger;

        $.ajax({
            type: 'POST',                       // 폼의 method와 동일하게 설정
            url: $(this).attr('action'),        // 폼의 action 속성에 지정된 URL로 요청
            data: formData,                     // 직렬화된 폼 데이터
            success: function(response) {
                console.log('AJAX 요청 성공. 결과 페이지로 이동합니다.');
                window.location.href = 'coverletterResult'; 
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
                alert('자기소개서 생성 중 오류가 발생했습니다.');
            }
        });
    });

});
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

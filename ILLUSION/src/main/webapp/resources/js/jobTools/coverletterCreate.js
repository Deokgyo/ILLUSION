$(function() {
    // =================================================================
    // 경력 사항 관련 기능
    // =================================================================

    // 신입/경력 선택 토글 
    $('#experience-toggle').on('click', '.option', function() {
        const $this = $(this);
        const selectedValue = $this.data('value');

        $this.addClass('active').siblings().removeClass('active');
        $('#experience-type-value').val(selectedValue);

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
    
    // 경력 기간 드롭다운 아이템 클릭 시
    $('.form-dropdown-menu').on('click', '.form-dropdown-item', function() {
        const selectedValue = $(this).data('value');
        const selectedText = $(this).text();

        $('#experience-level-value').val(selectedValue);
        $('#experience-level-select > span').text(selectedText);
        $(this).closest('.form-dropdown-menu').slideUp(200);
    });
    
    // 드롭다운 메뉴 바깥 클릭 시 닫기
    $(document).on('click', function(e) {
        if ($('.dropdown-wrapper').has(e.target).length === 0) {
            $('.form-dropdown-menu').slideUp(200);
        }
    });

    // =================================================================
	// 직무 선택 관련 기능 (AJAX)
	// =================================================================

	function ajaxReq(url, method, data, func) {
	    $.ajax({
	        url: url,
	        method: method,
	        data: data,
	        dataType: 'json',
	        success: function(res) { func(res); },
	        error: function(xhr, status, error) {
	            console.error("AJAX Error:", status, error);
	            alert('데이터를 불러오는 데 실패했습니다.');
	        }   
	    });
	}
	
	/**
	 * 직무 대분류 버튼 클릭 시 실행되는 함수
	 * - 클릭된 버튼을 활성화하고, 해당 대분류 코드(occupationCode)로 세부 직무 목록을 AJAX로 요청합니다.
	 */
	function activateOccupation() {
	    $('.occupation').removeClass('active');
	    $(this).addClass('active');
	    const occupationCode = $(this).data('value');
	    ajaxReq('getJobList', 'GET', { occupation: occupationCode }, renderJobs);
	}
	
	// AJAX로 받아온 세부 직무 목록(jobList)을 화면에 동적으로 생성하는 함수
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
	
	// 세부 직무 버튼 클릭 시 실행되는 함수
	function handleJobClick() {
	    $(this).toggleClass('active');
	    updateSelectedJobTags();
	}
	
	
	// 현재 활성화된 세부 직무들을 기반으로 선택된 태그 영역을 업데이트하는 함수
	function updateSelectedJobTags() {
	    const $tagsArea = $('.selected-tags-area');
	    $tagsArea.empty(); // 기존 태그 초기화
	    
	    // 활성화된(.active) 모든 세부 직무 버튼을 순회
	    $('.job.active').each(function() {
	        const keyword = $(this).text();
	        const tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
	        $tagsArea.append(tagHTML);
	    });
	    
	    // 태그가 업데이트되었으므로, 숨겨진 input 값도 함께 업데이트
	    updateHiddenJobInput(); 
	}
	
	// 선택된 태그의 'x' 버튼 클릭 시 실행되는 함수
	function deleteJobTag() {
	    const keyword = $(this).closest('.tag').data('keyword');
	    // 삭제할 태그의 텍스트와 동일한 세부 직무 버튼을 찾아 'active' 클래스를 제거
	    $('.job.active').filter(function() { return $(this).text() === keyword; }).removeClass('active');
	    // 화면에서 태그 요소를 제거
	    $(this).closest('.tag').remove();
	    // 태그가 삭제되었으므로, 숨겨진 input 값도 업데이트
	    updateHiddenJobInput();
	}
	
	
	// 현재 활성화된 세부 직무들의 텍스트를 조합하여 숨겨진 input(#selected-occupation)의 값을 업데이트하는 함수
	function updateHiddenJobInput() {
	    // 활성화된 모든 세부 직무 버튼의 텍스트를 배열로 만든 후, ', '로 연결하여 하나의 문자열로 만듦
	    const selectedJobNames = $('.job.active').map(function() { return $(this).text(); }).get().join(', ');
	    $('#selected-occupation').val(selectedJobNames);
	}
	
	// --- 이벤트 핸들러 바인딩 ---
	$('.occupation').on('click', activateOccupation);
	$(document).on('click', '.job', handleJobClick); // 동적으로 생성되는 .job 요소에 이벤트 위임
	$(document).on('click', '.close-btn', deleteJobTag); // 동적으로 생성되는 .close-btn 요소에 이벤트 위임
	
	// 페이지 로드 시, 첫 번째 직무 대분류를 자동으로 클릭하여 초기 세부 직무 목록을 표시
	if ($('.occupation').length > 0) {
	    $('.occupation').first().trigger('click');
	}

	// =================================================================
	// 최종 폼 제출 및 모달 연동 기능
	// =================================================================
	
	// 실제 자기소개서 생성을 요청하는 AJAX 함수
	function generateCoverLetter() {
	    // --- 개별 값 가져오기 ---
	    const title = $('input[name="title"]').val();
	    const company = $('input[name="company"]').val();
	    const question = $('textarea[name="question"]').val();
	    const keywords = $('input[name="keywords"]').val();
	    const maxLength = $('input[name="maxLength"]').val();
	    const occupation = $('#selected-occupation').val();
	
	    // --- 경력 정보 ---
	    let prevCompany = '';
	    let prevJob = '';
	    let experience = ''; // 핵심 경험/역량
	
	    if ($('#experience-toggle .option[data-value="experienced"]').hasClass('active')) {
	        prevCompany = $('input[name="prevCompany"]:visible').val(); 
	        prevJob = $('input[name="prevJob"]:visible').val();    
	        experience = $('#experience-level-select > span').text();
	        if (experience.includes('선택')) {
	            experience = '';
	        }
	    }
	
	    // --- 컨트롤러 파라미터와 일치하는 데이터 객체 ---
	    const submissionData = {
	        title: title,
	        company: company,
	        prevCompany: prevCompany,
	        prevJob: prevJob,
	        occupation: occupation,
	        maxLength: maxLength,
	        keywords: keywords,
	        question: question,
	        experience: experience
	    };
	
	    console.log('서버로 전송될 데이터:', submissionData);
	
	    // --- AJAX 요청 ---
	    $.ajax({
	        type: 'POST',
	        url: $('#coverletter-form').attr('action'),
	        data: submissionData,
	        dataType: 'json',
	        success: function(res) {
	            if (res.success) {
	                console.log('AJAX 요청 성공. 페이지 이동합니다.');
	                window.location.href = res.redirectUrl;
	            } else {
	                alert('자기소개서 생성에 실패했습니다.');
	            }
	        },
	        error: function(xhr, status, error) {
				debugger;
	            console.error('AJAX 요청 실패:', status, error);
	            alert('자기소개서 생성 중 오류가 발생했습니다.');
	        },
	        complete: function() {
	            // 요청 성공/실패 여부와 관계없이 로딩 모달을 숨김
	            $('#loading-overlay').fadeOut();
	        }
	    });
	}
	
	// 자기소개서 생성 버튼 클릭 이벤트 (폼 제출)
	$('#coverletter-form').on('submit', function(e) {
	    e.preventDefault(); 
	
	    const userTokens = 50; // TODO 
	
	    if (userTokens < 30) {
	        $('#token-modal').css('display', 'flex').fadeTo(300, 1);
	    } else {
	        $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
	    }
	});
	
	// 확인 모달에서 네 버튼 클릭 시
	$('#confirm-yes-btn').on('click', function() {
	    $('#confirm-modal').fadeOut(); // 확인 모달 닫기
	    $('#loading-overlay').css('display', 'flex').fadeTo(300, 1); // 로딩 모달 표시
	    
	    // 실제 생성 함수 호출
	    generateCoverLetter();
	});
	
	// 모든 모달의 아니요 또는 x 버튼 클릭 시
	$('.btn-no, .close-modal-btn').on('click', function() {
	    $(this).closest('.modal-overlay').fadeOut();
	});
});
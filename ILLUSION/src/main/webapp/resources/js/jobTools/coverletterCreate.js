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

    function activateOccupation() {
        $('.occupation').removeClass('active');
        $(this).addClass('active');
        const occupationCode = $(this).data('value');
        ajaxReq('getJobList', 'GET', { occupation: occupationCode }, renderJobs);
    }

    function renderJobs(jobList) {
        const $jobsContainer = $('#jobs');
        $jobsContainer.empty();
        if (jobList && jobList.length > 0) {
            const jobElements = jobList.map(function(job) {
                return `<div class="option-btn job" data-code='${job.code}'>${job.code_name}</div>`;
            });
            $jobsContainer.append(jobElements.join(''));
        }
    }

    function handleJobClick() {
        $(this).toggleClass('active');
        updateSelectedJobTags();
        updateHiddenJobInput();
    }
    
    function updateSelectedJobTags() {
        const $tagsArea = $('.selected-tags-area');
        $tagsArea.empty();
        $('.job.active').each(function() {
            const keyword = $(this).text();
            const tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
            $tagsArea.append(tagHTML);
        });
    }

    function deleteJobTag() {
        const keyword = $(this).closest('.tag').data('keyword');
        $('.job.active').filter(function() { return $(this).text() === keyword; }).removeClass('active');
        $(this).closest('.tag').remove();
        updateHiddenJobInput();
    }
    
    function updateHiddenJobInput() {
        const selectedJobNames = $('.job.active').map(function() { return $(this).text(); }).get().join(', ');
        $('#selected-occupation').val(selectedJobNames);
    }

    $('.occupation').on('click', activateOccupation);
    $(document).on('click', '.job', handleJobClick);
    $(document).on('click', '.close-btn', deleteJobTag);

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
	        prevCompany = $('input[name="prevCompany"]:visible').val(); // 보이는 input만 선택
	        prevJob = $('input[name="prevJob"]:visible').val();     // 보이는 input만 선택
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
	            console.error('AJAX 요청 실패:', status, error);
	            alert('자기소개서 생성 중 오류가 발생했습니다.');
	        },
	        complete: function() {
	            // 요청 성공/실패 여부와 관계없이 로딩 모달을 숨김
	            $('#loading-overlay').fadeOut();
	        }
	    });
	}
	
	// "자기소개서 생성" 버튼 클릭 이벤트 (폼 제출)
	$('#coverletter-form').on('submit', function(e) {
	    e.preventDefault(); // 기본 제출 동작을 막고 모달 로직 실행
	
	    const userTokens = 50; // 실제로는 서버에서 가져온 사용자 토큰 값이어야 합니다.
	
	    if (userTokens < 30) {
	        // 토큰이 부족할 경우
	        $('#token-modal').css('display', 'flex').fadeTo(300, 1);
	    } else {
	        // 토큰이 충분할 경우 확인 모달 표시
	        $('#confirm-modal').css('display', 'flex').fadeTo(300, 1);
	    }
	});
	
	// 확인 모달에서 "네" 버튼 클릭 시
	$('#confirm-yes-btn').on('click', function() {
	    $('#confirm-modal').fadeOut(); // 확인 모달 닫기
	    $('#loading-overlay').css('display', 'flex').fadeTo(300, 1); // 로딩 모달 표시
	    
	    // 실제 생성 함수 호출
	    generateCoverLetter();
	});
	
	// 모든 모달의 "아니요" 또는 "닫기(x)" 버튼 클릭 시
	$('.btn-no, .close-modal-btn').on('click', function() {
	    $(this).closest('.modal-overlay').fadeOut();
	});
});

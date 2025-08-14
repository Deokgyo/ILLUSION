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
    // 최종 폼 제출 기능 (AJAX)
    // =================================================================
    $('#coverletter-form').on('submit', function(e) {
        e.preventDefault();

        // --- 개별 값 가져오기 ---
        const company = $('input[name="company"]').val();
        const question = $('textarea[name="question"]').val();
        const keywords = $('input[name="keywords"]').val();
        const charLimit = $('input[name="maxLength"]').val();
        const jobText = $('#selected-occupation').val();

        // --- 경력 정보 ---
        let experienceText = "신입";
        if ($('#experience-toggle .option[data-value="experienced"]').hasClass('active')) {
            const prevCompany = $('input[name="prevCompany"]').val();
            const prevJob = $('input[name="prevJob"]').val();
            const experienceLevelText = $('#experience-level-select > span').text();
            
            if (prevCompany && prevJob) {
                experienceText = `${prevCompany}에서 ${prevJob}로 근무 (${experienceLevelText})`;
            } else {
                experienceText = `경력 (${experienceLevelText})`;
            }
        }
        
        // --- 핵심 역량 ---
        const coreCompetencyText = $('#experience-level-select > span').text();
        
        // --- 최종 프롬프트 ---
//        const finalPrompt = `너는 이제부터 채용을 위한 자기소개서를 작성해주는 전문가야. 아래 조건에 맞춰서 자기소개서를 완벽하게 작성해줘.
//- 지원 회사: ${company || '지정 안됨'}
//- 지원 직무: ${jobText || '지정 안됨'}
//- 자기소개서 문항: ${question || '없음'}
//- 이전 회사 및 직무 경험: ${experienceText || '신입/해당없음'}
//- 나의 핵심 경험/역량: ${coreCompetencyText.includes('선택') ? '지정 안됨' : coreCompetencyText}
//- 반드시 포함할 키워드: ${keywords || '없음'}
//- 글자 수 제한: ${charLimit || '제한 없음'}자 이내
//- 위의 모든 조건을 충실하게 반영해서 자연스럽고 설득력 있는 어투로 자기소개서를 작성해줘.`;
//
//        console.log("--- 생성된 프롬프트 ---");
//        console.log(finalPrompt);

        // --- 전송 데이터 ---
        const submissionData = {
            company: company,
            occupation: jobText,
            question: question,
            experience: experienceText,
            core_competency: coreCompetencyText,
            keywords: keywords,
            maxLength: charLimit
        };

        console.log('서버로 전송될 데이터:', submissionData);

        // --- AJAX 요청 ---
        $.ajax({
            type: 'POST',
		    url: $(this).attr('action'),
		    data: submissionData,
		    dataType: 'json',
		    success: function(res) {
		        if (res.success) {
		            console.log('AJAX 요청 성공. 서버가 지정한 페이지로 이동합니다.');
		            window.location.href = res.redirectUrl; 
		        }
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

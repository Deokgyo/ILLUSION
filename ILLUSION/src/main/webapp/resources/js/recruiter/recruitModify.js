$(function () {
	
	// 1. 제출 유효성 검사 
//	$('form').on('submit', onSubmitRequired);
		
	// 2.근무 지역 선택
	$('#major-region-list').on('click', handleMajorRegionClick);
	$('#sub-region-list').on('click', handleSubRegionClick);
	$('.filter-reset-btn').on('click', handleResetClick);
	$('#search-input').on('keyup', handleSearchInput);
	$('#check-all-sub-regions').on('click', function () {
		const checked = $(this).is(':checked');
		$('#sub-region-list').find('input[type="checkbox"]').prop('checked', checked);
		updateSelectedValues();
	});
	
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
	
	//4. 채용 인원 선택 
	//4-1) 최솟값, 정수만 입력 
	$('[name="recruit_hiring_num"]').attr({min: 0, step: 1});
	//4-2)미정 체크박스 설정시 
	$('#undecided').on('click', setUndecided);
	
	// 날짜 설정 관련
	$('[name="end_date"]').on('change', dateValid);
	
	//-------------------------------------------------------- 
	//                   서머노트, 이미지 업로드  
	//-------------------------------------------------------- 
    $('#summernote').summernote({
		lang: 'ko-KR',
		height: 300,   // 에디터 높이 설정
		placeholder: '여기에 내용을 입력하세요',
		toolbar: [
	        ['style', ['bold', 'italic', 'underline', 'clear']],
	        ['insert', ['picture']],
	        ['para', ['ul', 'ol']],
	        ['view', ['codeview']]
      	],
      	callbacks : {
			onImageUpload : function(files) {
				
				let file = new FormData();
	      		file.append('file', files[0]);
	      		
	      		$.ajax({
					url: 'imgUpload',
					method: 'POST',
					data: file,
					processData : false,
					contentType : false,
					enctype: 'multipart/form-data',
					dataType : 'json',
					success : function(data) {
						console.log(data);
						$('#summernote').summernote('insertImage', data.url)
					},
					error: function(xhr, textStatus, errorThrown) {
						alert('실패');
					}
				})
			}
		}
    });
	
	let context = $('#summernote').html();
	console.log(context);
	$('.summernote').summernote('code', context); // Summernote 초기화
	

});// 윈도우 레디

// 함수 선언 부 



//=============0. ajax 호출 함수 ===============
function ajaxReq(url, method, key, value, func) {
	$.ajax({
		url: url, method: method,
		data: { [key] : value }, dataType: 'json',
		success: function(res) {
			func(res);
		},
		error : function() {
			alert('실패!');
		}	
	});
}
//==============================1 . 유효성 검사 ============================================
 const requiredFields = [
	{ selector: '#subject', message: '제목을 입력해주세요.' },
	{ selector: 'select[name="recruit_type"]', message: '채용 유형을 선택해주세요.' },
    { selector: 'select[name="workTime"]', message: '근무 시간을 선택해주세요.' },
    { selector: '#selected-locations', message: '근무 지역을 선택해주세요.' },
    { selector: 'input[name="occupation"]', message: '채용 직무를 선택해주세요.' },
    { selector: 'input[name="recruit_hiring_num"]', message: '채용 인원을 선택해주세요.' },
    { selector: 'select[name="experience"]', message: '경력 조건을 선택해주세요.' },
    { selector: 'select[name="category"]', message: '학력을 선택해주세요.' },
    { selector: 'select[name="salary"]', message: '급여를 선택해주세요.' },
    { selector: 'input[name="end_date"]', message: '공고 마감 날짜를 선택해주세요.' }
];

function isEmpty(value) {
	return !value || value.trim() == '';
}

function onSubmitRequired(e) {
	for (const field of requiredFields) {
		const el = $(field.selector);
		if (el.length == 0) continue; // 엘리먼트 없으면 패스
	    const val = el.val();
	    if (isEmpty(val)) {
	      alert(field.message);
	      el.focus();
	      e.preventDefault();
	      return false;
	    }
	 }
	return true;
}
//==============================2. 근무 지역 선택 ========================================
function updateCheckAllState() {
	let subRegionList = $('#sub-region-list');
	let checkAllCheckbox = $('#check-all-sub-regions');
    const $all = subRegionList.find('input[type="checkbox"]:not([data-is-select-all])');
    const $checked = $all.filter(':checked');
    const $selectAllInList = subRegionList.find('input[data-is-select-all]');
    const isAllChecked = $all.length > 0 && $all.length === $checked.length;
    $selectAllInList.prop('checked', isAllChecked);
    checkAllCheckbox.prop('checked', isAllChecked);
}	

// 3-2. 소분류 지역 렌더링 함수
function renderSubRegions(locDetailList) {
	$('#sub-region-list').empty();
	let sub = [];
	for (let loc of locDetailList) {
		sub.push($(`<label class="sub"><input type="checkbox" class="checkbox" 
			value='${loc.code}'>${loc.code_name}</label>`));
	}
	$('#sub-region-list').append(sub);
 }

// 대분류 클릭 함수 
function handleMajorRegionClick(e) {
    const $target = $(e.target);
    // 클릭시 active 효과 주기 
    if (!$target.hasClass('major-region-item')) return;
    $('.major-region-item').removeClass('active');
    $target.addClass('active');
	// 클릭시 세부 데이터 가져오기 
	const location = $(e.target).val();
	ajaxReq('getlocDetailList', 'GET', 'location', location, renderSubRegions);
    updateCheckAllState();
}

// 이벤트 핸들러: 소분류 변경
function handleSubRegionClick(e) {
	const $target = $(e.target);
	let subRegionList = $('#sub-region-list');
	if (!$target.is(':checkbox')) return;
	
	if ($target.data('is-select-all') == true 
		|| $target.data('is-select-all') == 'true') {
	 const checked = $target.is(':checked');
	 subRegionList.find('input[type="checkbox"]').prop('checked', checked);
	}
	updateCheckAllState();
	updateSelectedValues();
	keywordSelectedValues(e);
}

function keywordSelectedValues(e) {
	// 현재 클릭된 체크 박스의 라벨의 텍스트 값 불러오기 
	let text =$(e.target).parent().text();
	// 현재 클릭된 체크박스의 val값 들고오기 
	let val = $(e.target).val();
	// 생성할 요소 변수에 담기 
	let el = $(`<div class="tag" data-value="${val}"><span>${text}</span><span class="close-btn">x</span></div>`)
	// 이미 생성된 div는 변수에 담기 
	let exist = $('.selected_location').children('div').filter(function() {return $(this).data('value') == val ; });
	// 체크 해제시, 만들어진 키워드 삭제, 체크시, 이미 만들어진것인지 판별하고 난뒤 만들어지지 않았는지를 길이로 체크하고 아니면 만들기  
	!($(e.target).is(':checked')) ? exist.remove() : exist.length == 0 ? $('.selected_location').append(el): null ;  
}




// 선택된 값 hidden input에 반영
function updateSelectedValues() {
	let values = $('#sub-region-list')
	  .find('input[type="checkbox"]:not([data-is-select-all]):checked')
	  .map(function () { return this.value; })
	  .get()
	  .join(', ');
	let selectedLocationsInput = $('#selected-locations');
	selectedLocationsInput.val(values);
}

// 초기화 기능 
function handleResetClick() {
	let subRegionList = $('#sub-region-list');
	let checkAllCheckbox = $('#check-all-sub-regions');
	let selectedLocation = $('.selected_location');
    subRegionList.find('input[type="checkbox"]').prop('checked', false);
    checkAllCheckbox.prop('checked', false);
    selectedLocation.empty();
    updateSelectedValues();
}

// 검색 필터
function handleSearchInput() {
	let keyword = searchInputEl.val().trim();
	ajaxReq('getlocDetailList', 'GET', 'location', keyword, renderSubRegions);
}

//================================ 3.직무 선택영역 ==================================
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
//		let el = $(`<div class="option-btn job" data-code='${job.code}'>
//			${job.code_name}</div>`);
//		if (el.text() == keyword.data('keyword')) {
//			
//		}
		joblist.push($(`<div class="option-btn job" data-code='${job.code}'>
			${job.code_name}</div>`));
	}
	$('#jobs').append(joblist);
	// 만약, 여기서 생성된 요소중에서 이미 키워드에 반영된 값이 있다면, active 효과 주기 
	// 키워드 영역 요소의 자식 중 data-code의 값과, el.text()의 값이 일치하는 경우  
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
        let tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
        if ($(`.selected-tags-area .tag[data-keyword="${keyword}"]`).length > 0) return;
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
	$('.job.active').filter(function() {
  		return $(this).text().trim() == keyword;
  	}).removeClass('active');
  	
  	const value = $(el).parent().data('value');
  	$('.checkbox').filter(function() {
		return $(this).val() == value;
	}).prop('checked', false);
	
  $(el).closest('.tag').remove();
}

//================================ 4.채용인원 선택영역 ==================================
function setUndecided () {
	let check = $('#undecided').is(':checked');
	$('[name="recruit_hiring_num"]').prop('disabled', check).val(check ? 0 : '');
}

//================================5. 날짜 선택 영역 ==========================
function dateValid() { 
	let date = new Date($('[name="end_date"]').val()) 
	if (date < $.now()) {
		alert('마감일은 오늘 이후로 설정하세요');
		$('[name="end_date"]').val('');
	}
}
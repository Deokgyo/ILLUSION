$(function () {
	// 1. 제출 유효성 검사 
	$('form').on('submit', onSubmitRequired);
		
	// 2.근무 지역 선택
	$('#sub-region-list').on('change', handleSubRegionChange);
	$('#major-region-list').on('click', handleMajorRegionClick);
	$('.filter-reset-btn').on('click', handleResetClick);
	$('#search-input').on('keyup', handleSearchInput);
	$('#check-all-sub-regions').on('change', function () {
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
	
//-------------------------------------------------------- 
//                   세부 공고 내용 관련 js  
//-------------------------------------------------------- 
	
	//실제로 사용자가 작성한 세부 내용이 전달되기 위한 설정 
	$('form').on('submit', () => {
		const editorContent = $('#editor').html();
		$('#hiddenContent').val(editorContent);
	});
	
	const $editor = $('#editor');
	const $upload = $('#upload');

  // 툴바 명령 실행
  document.format = (command, value = null) => {
    document.execCommand(command, false, value);
  };

  // 파일 업로드 버튼
  $upload.on('change', function () {
    const file = this.files[0];
    if (file && file.type.startsWith('image/')) {
      uploadImageToServer(file).then(function (url) {
        insertImage(url);
      });
    }
  });

  // 이미지 삽입 함수
  function insertImage(url) {
    const $img = $('<img>').attr('src', url);
    insertAtCursor($img[0]);
  }

  // 커서 위치에 이미지 삽입
  function insertAtCursor(node) {
    const sel = window.getSelection();
    if (sel.rangeCount) {
      const range = sel.getRangeAt(0);
      range.deleteContents();
      range.insertNode(node);
      range.setStartAfter(node);
      range.setEndAfter(node);
      sel.removeAllRanges();
      sel.addRange(range);
    }
  }

  // 이미지 업로드 (서버 대신 base64 예시)
  function uploadImageToServer(file) {
    return new Promise(function (resolve) {
      const reader = new FileReader();
      reader.onload = function (e) {
        resolve(e.target.result);
      };
      reader.readAsDataURL(file);
    });
  }

  // 드래그앤드롭 이미지
  $editor.on('dragover', function (e) {
    e.preventDefault();
  });

  $editor.on('drop', function (e) {
    e.preventDefault();
    const file = e.originalEvent.dataTransfer.files[0];
    if (file && file.type.startsWith('image/')) {
      uploadImageToServer(file).then(function (url) {
        insertImage(url);
      });
    }
  });

  // 붙여넣기 이미지 처리
  $editor.on('paste', function (e) {
    const items = e.originalEvent.clipboardData.items;
    for (const item of items) {
      if (item.type.startsWith('image/')) {
        const file = item.getAsFile();
        uploadImageToServer(file).then(function (url) {
          insertImage(url);
        });
        e.preventDefault();
      }
    }
  });
	
	
  
});// 윈도우 레디 
	
// 함수 선언 부 

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
function handleSubRegionChange(e) {
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
    subRegionList.find('input[type="checkbox"]').prop('checked', false);
    checkAllCheckbox.prop('checked', false);
    updateSelectedValues();
}

// 검색 필터
function handleSearchInput() {
// 사용자가 값을 검색하면 그 값과 일치하는 code_name 값을 가진 데이터를 디비에서 불러와서 출력함 이것도 ajax 네 ... 
// 사용자가 검색한 값 변수에 저장함 
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

//================================ 4.채용인원 선택영역 ==================================
function setUndecided () {
	let check = $('#undecided').is(':checked');
	$('[name="recruit_hiring_num"]').prop('disabled', check).val(check ? 0 : '');
}

$(function () {
	// 제출 유효성 검사 
	$('form').on('submit', onSubmitRequired);
		
	// 근무 지역 선택
	$('#sub-region-list').on('change', handleSubRegionChange);
	$('#major-region-list').on('click', handleMajorRegionClick);
	$('.filter-reset-btn').on('click', handleResetClick);
	$('#search-input').on('keyup', handleSearchInput);
	$('#check-all-sub-regions').on('change', function () {
		const checked = $(this).is(':checked');
		$('#sub-region-list').find('input[type="checkbox"]').prop('checked', checked);
		updateSelectedValues();
	});
	
	  
//-------------------------------------------------------- 
//                   직무 선택 
//-------------------------------------------------------- 
	  
  // 1. 직무 데이터 삽입
const occupationsData = {
	  design: { 
	    name: '디자인',
	    code: 'JOB002',
	    jobs: [
	      { code: 'JOB002002', label: '그래픽 디자인' },
	      { code: 'JOB002001', label: 'UI/UX 디자인' },
	      { code: '3d', label: '3D 디자인' },
	      { code: 'product_design', label: '제품 디자인' },
	      { code: 'animation', label: '애니메이션' }
	    ]
	  },
	  developer: {
	    name: '개발',
	    code: 'JOB001',
	    jobs: [
	      { code: 'JOB001001', label: '프론트엔드 개발' },
	      { code: 'JOB001002', label: '백엔드 개발' },
	      { code: 'fullstack', label: '풀스택 개발' },
	      { code: 'JOB001003', label: '앱 개발' },
	      { code: 'game', label: '게임 개발' },
	      { code: 'pc_repair', label: '컴퓨터 수리공' }
	    ]
	  },
	  marketing: {
	    name: '마케팅',
	    jobs: [
	      { code: 'brand', label: '브랜드 마케팅' },
	      { code: 'performance', label: '퍼포먼스 마케팅' },
	      { code: 'content', label: '콘텐츠 마케팅' },
	      { code: 'digital', label: '디지털 마케팅' },
	      { code: 'research', label: '시장 조사' }
	    ]
	  },
	  sales: {
	    name: '영업',
	    jobs: [
	      { code: 'b2b', label: 'B2B 영업' },
	      { code: 'b2c', label: 'B2C 영업' },
	      { code: 'global', label: '해외 영업' },
	      { code: 'sales_planning', label: '영업 기획' },
	      { code: 'sales_admin', label: '영업 관리' },
	      { code: 'phone_sales', label: '폰팔이' }
	    ]
	  },
	  hr: {
	    name: '인사/총무',
	    jobs: [
	      { code: 'recruit', label: '채용' },
	      { code: 'hr_planning', label: '인사 기획' },
	      { code: 'pay_benefit', label: '급여/복리후생' },
	      { code: 'labor', label: '노무 관리' },
	      { code: 'general', label: '총무' }
	    ]
	  },
	  finance: {
	    name: '재무/회계',
	    jobs: [
	      { code: 'accounting', label: '회계' },
	      { code: 'tax', label: '세무' },
	      { code: 'fund', label: '자금 관리' },
	      { code: 'analysis', label: '재무 분석' },
	      { code: 'ir', label: 'IR' }
	    ]
	  },
	  cs: {
	    name: '고객지원',
	    jobs: [
	      { code: 'support', label: '고객 상담' },
	      { code: 'cs_planning', label: '고객 CS기획' },
	      { code: 'voc', label: 'VOC 관리' },
	      { code: 'as', label: 'AS 관리' }
	    ]
	  },
	  planning: {
	    name: '기획',
	    jobs: [
	      { code: 'service_plan', label: '서비스 기획' },
	      { code: 'product_plan', label: '제품 기획' },
	      { code: 'biz_plan', label: '사업 기획' },
	      { code: 'strategy', label: '전략 기획' }
	    ]
	  }
	};
	//2. 변수 정리 
	
	
	//3. 데이터 동적 렌더링 작업 
	//3-1) 직무 렌더링 
	// 저장된 데이터를 가져와서, 자바스크립트로 <div class="option-btn">추가 + 밸류 값과 html도 넣어야함 
	// 상위 요소를 가져와서 추가하는  기능인 append (막내에 추가) a메서드 이용 
//	$.each(occupationsData, (key,value) => {
//		const $occupationKey = key; // 직종 밸류값 
//		const $occupationName = value.name; // 직종 한글로 보여줄거 
//		
//		// 직종 한글로 보여줄거,. 밸류값 추가 
//		const $occupationDiv = $('<div class="option-btn occupation"></div>')
//			.html($occupationName)
//			.attr('data-value',$occupationKey);
//		// 카테고리에 넣기 
//		$('#occupations').append($occupationDiv)
//	});
		
	//3-2) 세부직무 렌더링
	// 대분류의 값에 의해서 그안에 값들만 출력이 되어야 함 
	// 대분류의 활성화 된 name의 값을 가져와서, 같은 객체에 속한 job의 값을 배열을 순회하며 가져와야함 
	// 대분류의 값이 뭐가 선택된건지 어떻게 알 것인가? active 라는 클래스를 통해 그 name값을 가져와서 
	// 가져ㅛ온 name값으로 어디의 배열을 순회해서 추가할것인지 설정 해야함 
	// => 대분류 온클릭 이벤트 함수 내부에서 실행됨 

	
	
	// 4. 이벤트 관리  
	
	// 4-1) 대분류 클릭시 active 클래스 주기 (3-2에서 파생됨)
	// active는 어떻게 동적으로 넣을 것인가? 
	// 온클릭 이벤트 사용해서, 클릭 할시 active 라는 클래스를 추가할 것 
	
	// 직무 부분 온클릭 이벤트
	$('.occupation').on('click', occupationActive);
	
	
	
	//4-2) 세부 직무 부분 온클릭 이벤트  & 인풋 타입 히든에 값 넣기 	
	$(document).on('click', '.job', function () {
		jobActive(this);
		updateKeyword(this);
		updateJobValue();
	});
	
	$(document).on('click', '.close-btn', function() {
		const keyword = $(this).siblings('span').text().trim(); // 선택한 키워드
		$(`.job.active`).filter(function() {
	  		return $(this).text().trim() === keyword;
	  	}).removeClass('active');
	  $(this).closest('.tag').remove();
	  updateJobValue();
	});
	
	function jobActive (el) {
		if (!($(el).hasClass('active'))) {
			$(el).addClass('active');
		} else {
			$(el).removeClass('active');
		}
	}	
	
	// 5. 활성화 된 값 input hidden value에 넣기 
	function updateJobValue () {
		let $jobValue = $('.job.active').map(function() {
			return $(this).data('code');
			}).get().join(', ');
		$('#selected-occupation').val($jobValue);
	}
	
	function updateKeyword(el) {
		// 액티브된 세부 직무의 밸류 값을 추출
		// 요소 만드는 메서드에 액티브된 세무 직무의 밸류 값을 넣어서 생성하게 만들기 
		let keyword = $(el).text();
		if ($(el).hasClass('active')) {
            let tagHTML = `<div class="tag" data-keyword="${keyword}"><span>${keyword}</span><span class="close-btn">x</span></div>`;
            $('.selected-tags-area').append(tagHTML);
		} else {
			//현재 선택된 keyword 값과 같은 <span>태그의 값을 가진ㄴ div 요소 제거 
			$(`.tag[data-keyword="${keyword}"]`).remove();			
		}
	}
	

	//-------------------------------------------------------- 
	//                   채용 인원 관련  
	//-------------------------------------------------------- 
	let hireNum = $('[name="recruit_hiring_num"]');
	let undecided =$('#undecided');
	hireNum.attr({min: 0, step: 1});
	undecided.on('click', setUndecided);
	
	function setUndecided () {
		let check = undecided.is(':checked');
		hireNum.prop('disabled', check).val(check ? 0 : '');
	}
	
	
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
	
	// ajax 호출 함수 
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
			sub.push($(`<label class="sub"><input type="checkbox" class="checkbox" value='${loc.code}'>${loc.code_name}</label>`));
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
	
	// -=============== 직무 영역 ================
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
			joblist.push($(`<div class="option-btn job" data-code='${job.code}'>${job.code_name}</div>`));
		}
		$('#jobs').append(joblist);
	}
	
	

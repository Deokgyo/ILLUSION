$(function () {
	//1. 제출시 유효성 검사 
	$('form').on('submit', validCheck);
	function validCheck(e) {
	  let isValid = true;
	 console.log($('.valid'));	
	  $('.valid').each(function() {
	    if ($(this).val().trim() == '') {
		 console.log($('.valid').val());	
	      alert('모든 항목을 입력해주세요!');
	      isValid = false;
	      return false; // .each 중단
	    }
	  });
	
	  if (!isValid) {
	    e.preventDefault(); // 이벤트 한 번만 막기
		debugger;
	  }
	}

  	// 2. 요소 선택
	const $majorRegionListEl = $('#major-region-list');
	const $subRegionListEl = $('#sub-region-list');
	const searchInputEl = $('#search-input');
	const $resetBtnEl = $('.filter-reset-btn');
	const $checkAllCheckboxEl = $('#check-all-sub-regions');
	const $selectedLocationsInputEl = $('#selected-locations');

  	// 3. 이벤트 연결
	$majorRegionListEl.on('click', handleMajorRegionClick);
	$subRegionListEl.on('change', handleSubRegionChange);
	$checkAllCheckboxEl.on('change', function () {
		const checked = $(this).is(':checked');
		$subRegionListEl.find('input[type="checkbox"]').prop('checked', checked);
		updateSelectedValues();
	});
	$resetBtnEl.on('click', handleResetClick);
	searchInputEl.on('keyup', handleSearchInput);

	// 3-1. 대분류 지역 렌더링
	// => el 식으로 대체함 

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
  
  	// ajax 호출 함수 
	function ajaxReq(url, method, key, value, func) {
		$.ajax({
			url: url,
			method: method,
			data: { [key] : value },
			dataType: 'json',
			success: function(res) {
				if (value == '') {
					console.log(value);
					$('.sub').hide();
				} else {
					func(res);
				}
			},
			error : function() {
				alert('실패!');
			}	
		});
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

  // 이벤트 핸들러: 소분류 변경
  function handleSubRegionChange(e) {
    const $target = $(e.target);
    if (!$target.is(':checkbox')) return;

    if ($target.data('is-select-all') === true || $target.data('is-select-all') === 'true') {
      const checked = $target.is(':checked');
      $subRegionListEl.find('input[type="checkbox"]').prop('checked', checked);
    }

    updateCheckAllState();
    updateSelectedValues();
  }

  // 초기화 버튼
  function handleResetClick() {
    $subRegionListEl.find('input[type="checkbox"]').prop('checked', false);
    $checkAllCheckboxEl.prop('checked', false);
    updateSelectedValues();
  }

  // 검색 필터
	function handleSearchInput() {
	// 사용자가 값을 검색하면 그 값과 일치하는 code_name 값을 가진 데이터를 디비에서 불러와서 출력함 이것도 ajax 네 ... 
	// 사용자가 검색한 값 변수에 저장함 
		let keyword = searchInputEl.val().trim();
		ajaxReq('getlocDetailList', 'GET', 'location', keyword, renderSubRegions);
	}
	
  // 체크 상태 동기화
	function updateCheckAllState() {
	    const $all = $subRegionListEl.find('input[type="checkbox"]:not([data-is-select-all])');
	    const $checked = $all.filter(':checked');
	    const $selectAllInList = $subRegionListEl.find('input[data-is-select-all]');
	
	    const isAllChecked = $all.length > 0 && $all.length === $checked.length;
	
	    $selectAllInList.prop('checked', isAllChecked);
	    $checkAllCheckboxEl.prop('checked', isAllChecked);
	}

  // 선택된 값 hidden input에 반영
  function updateSelectedValues() {
    const values = $subRegionListEl
      .find('input[type="checkbox"]:not([data-is-select-all]):checked')
      .map(function () { return this.value; })
      .get()
      .join(', ');
    $selectedLocationsInputEl.val(values);
  }

  
  
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
	$.each(occupationsData, (key,value) => {
		const $occupationKey = key; // 직종 밸류값 
		const $occupationName = value.name; // 직종 한글로 보여줄거 
		
		// 직종 한글로 보여줄거,. 밸류값 추가 
		const $occupationDiv = $('<div class="option-btn occupation"></div>')
			.html($occupationName)
			.attr('data-value',$occupationKey);
		// 카테고리에 넣기 
		$('#occupations').append($occupationDiv)
	});
		
	//3-2) 세부직무 렌더링
	// 대분류의 값에 의해서 그안에 값들만 출력이 되어야 함 
	// 대분류의 활성화 된 name의 값을 가져와서, 같은 객체에 속한 job의 값을 배열을 순회하며 가져와야함 
	// 대분류의 값이 뭐가 선택된건지 어떻게 알 것인가? active 라는 클래스를 통해 그 name값을 가져와서 
	// 가져ㅛ온 name값으로 어디의 배열을 순회해서 추가할것인지 설정 해야함 
	// => 대분류 온클릭 이벤트 함수 내부에서 실행됨 
	function renderJobs($activeKey) {
		$('#jobs').empty();
		const $jobObj = occupationsData[$activeKey].jobs;
		$.each($jobObj, function(_,value) {
			const $jobsDiv = $('<div class="option-btn job"></div>')
			.html(value.label)
			.attr('data-code', value.code);
			$('#jobs').append($jobsDiv);
		});
	}
	
	
	// 4. 이벤트 관리  
	
	// 4-1) 대분류 클릭시 active 클래스 주기 (3-2에서 파생됨)
	// active는 어떻게 동적으로 넣을 것인가? 
	// 온클릭 이벤트 사용해서, 클릭 할시 active 라는 클래스를 추가할 것 
	
	// 직무 부분 온클릭 이벤트
	$('.occupation').on('click', occupationActive);
	function occupationActive() {
		$('.occupation').removeClass('active');
		$(this).addClass('active');
		const $activeKey = $(this).data('value');
		renderJobs($activeKey); // 소분류 렌더링 함수 실행
	}
	
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
	
	

	



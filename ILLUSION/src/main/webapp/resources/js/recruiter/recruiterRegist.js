$(function () {
  // 1. 데이터
  const locationsData = {
    'seoul': { name: '서울', subregions: ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'] },
    'busan': { name: '부산', subregions: ['강서구', '금정구', '기장군', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구'] },
    'daegu': { name: '대구', subregions: ['남구', '달서구', '달성군', '동구', '북구', '서구', '수성구', '중구'] },
    'incheon': { name: '인천', subregions: ['연수구', '남동구'] }
  }; 
  // 2. 요소 선택
  const $majorRegionListEl = $('#major-region-list');
  const $subRegionListEl = $('#sub-region-list');
  const $searchInputEl = $('#search-input');
  const $resetBtnEl = $('.filter-reset-btn');
  const $checkAllCheckboxEl = $('#check-all-sub-regions');
  const $selectedLocationsInputEl = $('#selected-locations');

  // 3-1. 대분류 지역 렌더링
  function renderMajorRegions() {
    Object.keys(locationsData).forEach(key => {
      const name = locationsData[key].name;
      $('<li>')
        .addClass('major-region-item')
        .attr('data-region-code', key)
        .text(name)
        .appendTo($majorRegionListEl);
    });
  }
  renderMajorRegions();

  // 3-2. 소분류 지역 렌더링
  function renderSubRegions(regionCode) {
    $subRegionListEl.empty();
    const region = locationsData[regionCode];
    if (!region) return;

    region.subregions.forEach((subregion, index) => {
      const $label = $('<label>');
      const $checkbox = $('<input type="checkbox">').val(`${region.name} ${subregion}`);
//      if (index === 0) {
//        $checkbox.attr('data-is-select-all', 'true');
//      }
      $label.append($checkbox).append(`${subregion}`).addClass('sub');
      $subRegionListEl.append($label);
    });
  }

  // 이벤트 핸들러: 대분류 클릭
  function handleMajorRegionClick(e) {
    const $target = $(e.target);
    if (!$target.hasClass('major-region-item')) return;

    $('.major-region-item').removeClass('active');
    $target.addClass('active');

    const regionCode = $target.data('region-code');
    renderSubRegions(regionCode);
    updateCheckAllState();
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
  const searchTerm = $searchInputEl.val().toLowerCase();

  // 모든 대분류 비활성화
  $('.major-region-item').removeClass('active');

  // 1. 대분류 이름과 매칭되는 경우
  let matchedRegionCode = null;

  // 대분류 이름으로 매칭되는지 먼저 확인
  Object.keys(locationsData).forEach(regionCode => {
    const region = locationsData[regionCode];
    const regionName = region.name.toLowerCase();

    if (regionName.includes(searchTerm) && !matchedRegionCode) {
      matchedRegionCode = regionCode;
    }
  });

  if (matchedRegionCode) {
    // 대분류 검색일 경우 → 전체 구 보여줌
    renderSubRegions(matchedRegionCode);
    $(`.major-region-item[data-region-code="${matchedRegionCode}"]`).addClass('active');
    $('.sub').show(); // 모든 구 다 보이기
    return;
  }

  // 2. 대분류 이름이 아니면, 구 이름으로 검색
  Object.keys(locationsData).forEach(regionCode => {
    const region = locationsData[regionCode];
    const hasMatch = region.subregions.some(sub => sub.toLowerCase().includes(searchTerm));
    if (hasMatch && !matchedRegionCode) matchedRegionCode = regionCode;
  });

  if (matchedRegionCode) {
    renderSubRegions(matchedRegionCode);
    $(`.major-region-item[data-region-code="${matchedRegionCode}"]`).addClass('active');

    // 구 이름 필터링
    $('.sub').each(function () {
      const text = $(this).text().toLowerCase();
      $(this).toggle(text.includes(searchTerm));
    });
  } else {
    // 검색어로 아무것도 못 찾으면 전체 숨김
    $('.sub').hide();
  }
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

  // 이벤트 연결
  $majorRegionListEl.on('click', handleMajorRegionClick);
  $subRegionListEl.on('change', handleSubRegionChange);
  $checkAllCheckboxEl.on('change', function () {
    const checked = $(this).is(':checked');
    $subRegionListEl.find('input[type="checkbox"]').prop('checked', checked);
    updateSelectedValues();
  });
  $resetBtnEl.on('click', handleResetClick);
  $searchInputEl.on('input', handleSearchInput);
  
  
  //-------------------------------------------------------- 
  //                   직무 선택 
  //-------------------------------------------------------- 
  
  // 1. 직무 데이터 삽입
	const occupationsData = {
	  'design': { 
		name: '디자인',
	    job: ['그래픽 디자인', 'UI/UX 디자인', '3D 디자인', '제품 디자인', '애니메이션']
	  },
	  'developer': {
	    name: '개발',
	    job: ['프론트엔드 개발', '백엔드 개발', '풀스택 개발', '앱 개발', '게임 개발', '컴퓨터 수리공']
	  },
	  'marketing': {
	    name: '마케팅',
	    job: ['브랜드 마케팅', '퍼포먼스 마케팅', '콘텐츠 마케팅', '디지털 마케팅', '시장 조사']
	  },
	  'sales': {
	    name: '영업',
	    job: ['B2B 영업', 'B2C 영업', '해외 영업', '영업 기획', '영업 관리', '폰팔이']
	  },
	  'hr': {
	    name: '인사/총무',
	    job: ['채용', '인사 기획', '급여/복리후생', '노무 관리', '총무']
	  },
	  'finance': {
	    name: '재무/회계',
	    job: ['회계', '세무', '자금 관리', '재무 분석', 'IR']
	  },
	  'cs': {
	    name: '고객지원',
	    job: ['고객 상담', '고객 CS기획', 'VOC 관리', 'AS 관리']
	  },
	  'planning': {
	    name: '기획',
	    job: ['서비스 기획', '제품 기획', '사업 기획', '전략 기획']
	  }
	};
	
	//2. 변수 정리 
	
	
	//3. 데이터 동적 렌더링 작업 
	//3-1) 직무 렌더링 
	// 저장된 데이터를 가져와서, 자바스크립트로 <div class="option-btn">추가 + 밸류 값과 html도 넣어야함 
	// 상위 요소를 가져와서 추가하는  기능인 append (막내에 추가) a메서드 이용 
	
	occupationsData.
	
	const $occupation = $('<div class="option-btn"></div>').text();
	
	$('.category-options').append()
	
	
	//3-2) 세부직무 렌더링
	
  
  
});

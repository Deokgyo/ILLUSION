// 페이지의 모든 HTML이 로드된 후 스크립트를 실행합니다.
document.addEventListener('DOMContentLoaded', function () {

    // 1. 데이터: 모든 지역 정보를 이 객체에서 관리합니다.
    const locationsData = {
        'seoul': { name: '서울', subregions: ['전체', '강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'] },
        'busan': { name: '부산', subregions: ['전체', '강서구', '금정구', '기장군', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구'] },
        'daegu': { name: '대구', subregions: ['전체', '남구', '달서구', '달성군', '동구', '북구', '서구', '수성구', '중구'] }
        // (필요한 다른 시/도 데이터를 여기에 추가)
    };

    // 2. HTML 요소 가져오기
    const majorRegionListEl = document.getElementById('major-region-list');
    const subRegionListEl = document.getElementById('sub-region-list');
    const searchInputEl = document.getElementById('search-input');
    const resetBtnEl = document.querySelector('.filter-reset-btn');
    const checkAllCheckboxEl = document.getElementById('check-all-sub-regions');
    const selectedLocationsInputEl = document.getElementById('selected-locations');

    // 3. UI 렌더링 함수
    function renderSubRegions(regionCode) {
        subRegionListEl.innerHTML = ''; // 기존 내용 비우기
        const region = locationsData[regionCode];
        if (!region) return;

        region.subregions.forEach((subregion, index) => {
            const label = document.createElement('label');
            
            const checkbox = document.createElement('input');
            checkbox.type = 'checkbox';
            checkbox.value = `${region.name} ${subregion}`;
            // '전체' 체크박스는 특별한 데이터 속성을 부여
            if (index === 0) {
                 checkbox.dataset.isSelectAll = 'true';
            }
            
            label.appendChild(checkbox);
            label.appendChild(document.createTextNode(` ${subregion}`));
            subRegionListEl.appendChild(label);
        });
    }

    // 4. 이벤트 핸들러 함수
    function handleMajorRegionClick(e) {
        if (!e.target.classList.contains('major-region-item')) return;

        document.querySelectorAll('.major-region-item').forEach(item => item.classList.remove('active'));
        e.target.classList.add('active');

        const regionCode = e.target.dataset.regionCode;
        renderSubRegions(regionCode);
        updateCheckAllState();
    }
    
    // 이벤트 위임을 사용하여 오른쪽 패널의 체크박스 변경을 감지
    function handleSubRegionChange(e) {
        if (e.target.type !== 'checkbox') return;
        
        // '전체' 체크박스를 클릭한 경우
        if (e.target.dataset.isSelectAll === 'true') {
            const allCheckboxes = subRegionListEl.querySelectorAll('input[type="checkbox"]');
            allCheckboxes.forEach(cb => cb.checked = e.target.checked);
        }

        updateCheckAllState();
        updateSelectedValues();
    }
    
    function handleResetClick() {
        subRegionListEl.querySelectorAll('input[type="checkbox"]').forEach(checkbox => checkbox.checked = false);
        checkAllCheckboxEl.checked = false;
        updateSelectedValues();
    }
    
    function handleSearchInput(e) {
        const searchTerm = e.target.value.toLowerCase();
        document.querySelectorAll('.major-region-item').forEach(item => {
            const regionName = item.textContent.toLowerCase();
            item.style.display = regionName.includes(searchTerm) ? 'block' : 'none';
        });
    }

    // 5. 헬퍼(Helper) 함수
    function updateCheckAllState() {
        const allSubCheckboxes = subRegionListEl.querySelectorAll('input[type="checkbox"]:not([data-is-select-all])');
        const checkedSubCheckboxes = subRegionListEl.querySelectorAll('input[type="checkbox"]:not([data-is-select-all]):checked');
        const selectAllInList = subRegionListEl.querySelector('input[data-is-select-all]');

        const isAllChecked = allSubCheckboxes.length > 0 && allSubCheckboxes.length === checkedSubCheckboxes.length;
        
        // 외부 '전체' 체크박스와 내부 '전체' 체크박스 상태 동기화
        if (selectAllInList) selectAllInList.checked = isAllChecked;
        checkAllCheckboxEl.checked = isAllChecked;
    }
    
    function updateSelectedValues() {
        const checkedSubCheckboxes = subRegionListEl.querySelectorAll('input[type="checkbox"]:not([data-is-select-all]):checked');
        const values = Array.from(checkedSubCheckboxes).map(cb => cb.value).join(', ');
        selectedLocationsInputEl.value = values;

        console.log('Selected:', selectedLocationsInputEl.value);
    }

    // 6. 이벤트 리스너 연결
    majorRegionListEl.addEventListener('click', handleMajorRegionClick);
    subRegionListEl.addEventListener('change', handleSubRegionChange);
    checkAllCheckboxEl.addEventListener('change', (e) => {
        // 외부 '전체' 체크박스 클릭 시 내부 체크박스들을 제어
        const allCheckboxes = subRegionListEl.querySelectorAll('input[type="checkbox"]');
        allCheckboxes.forEach(cb => cb.checked = e.target.checked);
        updateSelectedValues();
    });
    resetBtnEl.addEventListener('click', handleResetClick);
    searchInputEl.addEventListener('input', handleSearchInput);

    // 7. 초기화: 첫 번째 주요 지역을 클릭한 것처럼 실행
    if (majorRegionListEl.firstChild) {
        majorRegionListEl.firstChild.click();
    }
});
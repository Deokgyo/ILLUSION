$(function() { // $(document).ready()의 축약형

    //================================================
    // 1. 공통 헬퍼 함수 및 변수 (두 번째 코드에서 가져옴)
    //================================================
    const $tagsArea = $('#selected-tags-area'); // 선택된 태그가 표시될 영역

    /**
     * 범용 AJAX 요청 함수
     * @param {string} url - 요청을 보낼 URL
     * @param {string} method - HTTP 메소드 (GET, POST 등)
     * @param {object} data - 서버로 보낼 데이터 객체 (예: { key: value })
     * @param {function} successCallback - 성공 시 실행할 콜백 함수
     */
    function ajaxRequest(url, method, data, successCallback) {
        $.ajax({
            url: url,
            method: method,
            data: data,
            dataType: 'json',
            success: function(response) {
                // 성공 시, 받은 데이터를 콜백 함수에 넘겨줌
                successCallback(response);
            },
            error: function(xhr, status, error) {
                console.error("AJAX Error:", status, error);
                alert('데이터를 불러오는 데 실패했습니다.');
            }
        });
    }

    //================================================
    // 2. 범용 UI 이벤트 핸들러 (첫 번째 코드에서 가져옴)
    //================================================

    /* 드롭다운 토글 기능 */
    $('.toggle-filter-btn').on('click', function(event) {
        const $currentMenu = $(this).siblings('.filter-dropdown-menu');
        // 현재 메뉴를 제외한 다른 모든 메뉴는 닫음
        $('.filter-dropdown-menu').not($currentMenu).addClass('hidden');
        $currentMenu.toggleClass('hidden');
        event.stopPropagation(); // 이벤트 버블링 방지
    });

    /* 문서 외부 클릭 시 모든 드롭다운 닫기 */
    $(document).on('click', function(event) {
        if (!$(event.target).closest('.filter-dropdown').length) {
            $('.filter-dropdown-menu').addClass('hidden');
        }
    });

    /* 범용 체크박스 변경 감지 -> 태그 생성/삭제 (이벤트 위임) */
    $(document).on('change', '.filter-checkbox', function() {
        const $checkbox = $(this);
        const value = $checkbox.val();
        const text = $checkbox.data('text'); // data-text 속성에서 텍스트를 가져옴

        const isTagExist = $tagsArea.find(`.filter-tag[data-value="${value}"]`).length > 0;

        if ($checkbox.is(':checked') && !isTagExist) {
            const newTag = `
                <div class="filter-tag" data-value="${value}">
                    <span>${text}</span>
                    <button class="remove-tag-btn" data-value="${value}">×</button>
                </div>
            `;
            $tagsArea.append(newTag);
        } else if (!$checkbox.is(':checked') && isTagExist) {
            $tagsArea.find(`.filter-tag[data-value="${value}"]`).remove();
        }
    });

    /* 동적으로 생성된 태그의 'x' 버튼 클릭 (이벤트 위임) */
    $tagsArea.on('click', '.remove-tag-btn', function() {
        const valueToRemove = $(this).data('value');
        $(this).closest('.filter-tag').remove();
        // 태그 삭제 시, 해당하는 체크박스도 해제
        $(`.filter-checkbox[value="${valueToRemove}"]`).prop('checked', false);
    });

    /* 범용 초기화 버튼 기능 */
    $('.filter-reset-btn').on('click', function() {
        // 현재 드롭다운 내의 체크된 박스들을 모두 해제하고 change 이벤트를 발생시켜 태그도 삭제
        const $checkboxesInDropdown = $(this).closest('.filter-dropdown').find('.filter-checkbox:checked');
        $checkboxesInDropdown.prop('checked', false).trigger('change');
    });

    //================================================
    // 3. 지역 필터 전용 로직 (두 코드를 병합한 핵심 부분)
    //================================================

    const $locationFilter = $('.filter-dropdown[data-filter-type="location"]');
    // 지역 필터가 페이지에 존재할 때만 아래 로직을 실행
    if ($locationFilter.length) {
        const $majorRegionList = $locationFilter.find('#major-region-list');
        const $subRegionList = $locationFilter.find('#sub-region-list');
        const $checkAll = $locationFilter.find('#check-all-sub-regions');
        const $searchInput = $locationFilter.find('#location-search-input');
//        let searchTimer; // 검색 디바운싱을 위한 타이머 변수

        /**
         * (병합) 서버에서 받은 소분류 지역 목록으로 체크박스를 생성하는 함수
         * @param {Array} subRegionData - 서버에서 받은 지역 데이터 배열 (e.g., [{code: '11010', code_name: '종로구'}])
         */
        function populateSubRegionCheckboxes(subRegionData) {
            $subRegionList.empty(); // 기존 목록 비우기
            if (!subRegionData || subRegionData.length === 0) {
                $subRegionList.append('<li>결과가 없습니다.</li>');
                return;
            }

            subRegionData.forEach(region => {
                // 첫 번째 코드의 태그 생성 로직을 위해 data-text 속성에 code_name을 넣어줍니다.
                const newCheckbox = `
                    <label>
                        <input type="checkbox" class="filter-checkbox" name="location" 
                               value="${region.code}" data-text="${region.code_name}">
                        ${region.code_name}
                    </label>
                `;
                $subRegionList.append(newCheckbox);
            });
        }

        /* (병합) 대분류 지역 클릭 이벤트 */
        $majorRegionList.on('click', '.major-region-item', function() {
            const $this = $(this);
            $majorRegionList.find('.major-region-item').removeClass('active');
            $this.addClass('active');
            
            const regionCode = $this.data('region-code'); // 클릭한 지역의 코드 (예: '11' for 서울)
            
            // AJAX 요청으로 소분류 지역 데이터를 가져옵니다.
            ajaxRequest('getlocDetailList', 'GET', { location: regionCode }, populateSubRegionCheckboxes);
            
            $checkAll.prop('checked', false);
            $searchInput.val(''); // 검색창 초기화
        });

        /* (병합) 소분류 '전체' 체크박스 이벤트 */
        $checkAll.on('change', function() {
            const isChecked = $(this).is(':checked');
            // 현재 화면에 보이는 모든 체크박스에 대해 상태를 변경하고, change 이벤트를 강제로 발생시켜 태그를 생성/삭제합니다.
            $subRegionList.find('label:visible .filter-checkbox').prop('checked', isChecked).trigger('change');
        });

//        /* (병합 및 개선) 검색 기능 - Debouncing 적용 */
//        $searchInput.on('keyup', function() {
//            clearTimeout(searchTimer); // 이전 타이머를 취소 (키 입력이 계속되면 요청 방지)
//
//            const searchTerm = $(this).val().trim();
//
//            // 0.3초 후에 검색 실행 (API 요청 횟수를 줄여 서버 부하 감소)
//            searchTimer = setTimeout(() => {
//                if (searchTerm === "") {
//                    // 검색어가 없으면 현재 선택된 대분류 지역 목록을 다시 불러옴
//                    const activeRegionCode = $majorRegionList.find('.active').data('region-code') || '11'; // 기본값 서울
//                    ajaxRequest('getlocDetailList', 'GET', { location: activeRegionCode }, populateSubRegionCheckboxes);
//                } else {
//                    // 검색어가 있으면, 검색 API를 호출
//                    // NOTE: 서버에 검색을 처리하는 별도의 API(예: 'searchLocations')가 필요할 수 있습니다.
//                    ajaxRequest('searchLocations', 'GET', { keyword: searchTerm }, populateSubRegionCheckboxes);
//                }
//            }, 300); 
//        });

        // 페이지 로드 시, 기본값으로 첫 번째 대분류(서울)의 소분류 지역을 불러옴
        const initialRegionCode = $majorRegionList.find('.active').data('region-code') || '11';
        ajaxRequest('getlocDetailList', 'GET', { location: initialRegionCode }, populateSubRegionCheckboxes);
    }
});
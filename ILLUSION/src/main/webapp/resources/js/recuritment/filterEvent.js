$(function() {
    const $tagsArea = $('#selected-tags-area');

    /* 1. 범용 드롭다운 토글 기능 */
    $('.toggle-filter-btn').on('click', function(event) {
        const $currentMenu = $(this).siblings('.filter-dropdown-menu');
        $('.filter-dropdown-menu').not($currentMenu).addClass('hidden');
        $currentMenu.toggleClass('hidden');
        event.stopPropagation();
    });

    /* 2. 문서 외부 클릭 시 모든 드롭다운 닫기 */
    $(document).on('click', function(event) {
        if (!$(event.target).closest('.filter-dropdown').length) {
            $('.filter-dropdown-menu').addClass('hidden');
        }
    });

    /* =======================================
        지역 필터 전용 로직
    ======================================= */

    // NOTE: 이 데이터는 API를 통해 받아오는 것이 좋습니다. (이전 대화 내용 참고)
    const locationData = {
        'seoul': ['강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'],
        'busan': ['강서구', '금정구', '기장군', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구'],
        'daegu': ['남구', '달서구', '달성군', '동구', '북구', '서구', '수성구', '중구'],
    };

    const $locationFilter = $('.filter-dropdown[data-filter-type="location"]');
    if ($locationFilter.length) { // 지역 필터가 페이지에 존재할 때만 로직 실행
        const $majorRegionList = $locationFilter.find('#major-region-list');
        const $subRegionList = $locationFilter.find('#sub-region-list');
        const $checkAll = $locationFilter.find('#check-all-sub-regions');

        function populateSubRegions(regionCode) {
            const subRegions = locationData[regionCode] || [];
            $subRegionList.empty();

            subRegions.forEach(subRegion => {
                const value = `${regionCode}-${subRegion}`;
                const newCheckbox = `
                    <label>
                        <input type="checkbox" class="filter-checkbox" name="location" value="${value}" data-text="${subRegion}"> ${subRegion}
                    </label>
                `;
                $subRegionList.append(newCheckbox);
            });
        }

        $majorRegionList.on('click', '.major-region-item', function() {
            const $this = $(this);
            $majorRegionList.find('.major-region-item').removeClass('active');
            $this.addClass('active');
            const regionCode = $this.data('region-code');
            populateSubRegions(regionCode);
            $checkAll.prop('checked', false);
        });

        $checkAll.on('change', function() {
            const isChecked = $(this).is(':checked');
            $subRegionList.find('.filter-checkbox').prop('checked', isChecked).trigger('change');
        });

        populateSubRegions('seoul');
    }
    
        // NOTE: 이 데이터는 API를 통해 받아오는 것이 좋습니다. (이전 대화 내용 참고)
    const occupationData = {
        'occupation1': ['프론트', '백', '모바일'],
        'occupation2': ['UI/UX', '그래픽'],
    };

    const $occupationFilter = $('.filter-dropdown[data-filter-type="occupation"]');
    if ($occupationFilter.length) { // 지역 필터가 페이지에 존재할 때만 로직 실행
        const $majorRegionList = $occupationFilter.find('#major-region-list');
        const $subRegionList = $occupationFilter.find('#sub-region-list');
        const $checkAll = $occupationFilter.find('#check-all-sub-regions');

        function populateSubRegions(regionCode) {
            const subRegions = occupationData[regionCode] || [];
            $subRegionList.empty();

            subRegions.forEach(subRegion => {
                const value = `${regionCode}-${subRegion}`;
                const newCheckbox = `
                    <label>
                        <input type="checkbox" class="filter-checkbox" name="location" value="${value}" data-text="${subRegion}"> ${subRegion}
                    </label>
                `;
                $subRegionList.append(newCheckbox);
            });
        }

        $majorRegionList.on('click', '.major-region-item', function() {
            const $this = $(this);
            $majorRegionList.find('.major-region-item').removeClass('active');
            $this.addClass('active');
            const regionCode = $this.data('region-code');
            populateSubRegions(regionCode);
            $checkAll.prop('checked', false);
        });

        $checkAll.on('change', function() {
            const isChecked = $(this).is(':checked');
            $subRegionList.find('.filter-checkbox').prop('checked', isChecked).trigger('change');
        });

        populateSubRegions('occupation1');
    }

    /* =======================================
        범용 이벤트 핸들러 (이벤트 위임 방식 적용)
    ======================================= */
    
    /* 3. (수정됨) 범용 체크박스 변경 감지 -> 태그 생성/삭제 */
    $(document).on('change', '.filter-checkbox', function() {
        const $checkbox = $(this);
        const value = $checkbox.val();
        const text = $checkbox.data('text');
        const icon = '💼';

        // 이미 생성된 태그가 있는지 확인 (중복 생성 방지)
        const isTagExist = $tagsArea.find(`.filter-tag[data-value="${value}"]`).length > 0;

        if ($checkbox.is(':checked') && !isTagExist) {
            const newTag = `
                <div class="filter-tag" data-value="${value}">
                    <span>${icon} ${text}</span>
                    <button class="remove-tag-btn" data-value="${value}">×</button>
                </div>
            `;
            $tagsArea.append(newTag);
        } else if (!$checkbox.is(':checked') && isTagExist) {
            $tagsArea.find(`.filter-tag[data-value="${value}"]`).remove();
        }
    });

    /* 4. 동적으로 생성된 태그의 'x' 버튼 클릭 (이벤트 위임) */
    $tagsArea.on('click', '.remove-tag-btn', function() {
        const valueToRemove = $(this).data('value');
        $(this).closest('.filter-tag').remove();
        $(`.filter-checkbox[value="${valueToRemove}"]`).prop('checked', false);
    });

    /* 5. 범용 초기화 버튼 기능 */
    $('.filter-reset-btn').on('click', function() {
        const $checkboxesInDropdown = $(this).closest('.filter-dropdown').find('.filter-checkbox:checked');
        $checkboxesInDropdown.prop('checked', false).trigger('change');
    });
});
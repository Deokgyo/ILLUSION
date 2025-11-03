// 모든 코드를 단 하나의 $(function() { ... }); 안에 정리합니다.
$(function() {

    //================================================
    // 1. 전역 변수 및 헬퍼 함수
    //================================================
    
    // JavaScript가 자신의 경로를 기반으로 contextPath를 동적으로 계산합니다.
    const scriptSrc = $('script[src*="filterEvent.js"]').attr('src');
    const contextPath = scriptSrc ? scriptSrc.substring(0, scriptSrc.indexOf('/resources')) : "";
    
    const $tagsArea = $('#selected-tags-area');
    const $form = $('#filter-form');
    
    // JSP가 <form> 태그에 심어둔 선택된 필터 데이터를 페이지 로드 시 미리 읽어둡니다.
    const selectedFilters = $form.data('selected-filters') || {};
    
    console.log("페이지 로드 시 복원할 필터 데이터:", selectedFilters);

    /**
     * 범용 AJAX 요청 함수
     */
    function ajaxRequest(url, method, data, successCallback) {
        $.ajax({
            url: url,
            method: method,
            data: data,
            dataType: 'json',
            success: successCallback,
            error: function(xhr, status, error) {
                console.error(`AJAX Error requesting ${url}:`, status, error);
                console.error("Response Text:", xhr.responseText);
            }
        });
    }
    
    //================================================
    // 2. 범용 UI 이벤트 핸들러 (모든 필터 공통)
    //================================================

    /* 드롭다운 토글 기능 */
    $('.toggle-filter-btn').on('click', function(event) {
        const $currentMenu = $(this).siblings('.filter-dropdown-menu');
        $('.filter-dropdown-menu').not($currentMenu).addClass('hidden');
        $currentMenu.toggleClass('hidden');
        event.stopPropagation();
    });

    /* 문서 외부 클릭 시 모든 드롭다운 닫기 */
    $(document).on('click', function(event) {
        if (!$(event.target).closest('.filter-dropdown').length) {
            $('.filter-dropdown-menu').addClass('hidden');
        }
    });

    /* 체크박스 변경 -> 태그 생성/삭제 (이벤트 위임) */
    $(document).on('change', '.filter-checkbox', function() {
        const $checkbox = $(this);
        const value = $checkbox.val();
        const text = $checkbox.data('text');
        const isTagExist = $tagsArea.find(`.filter-tag[data-value="${value}"]`).length > 0;

        if ($checkbox.is(':checked') && !isTagExist) {
            const newTag = `<div class="filter-tag" data-value="${value}"><span>${text}</span><button class="remove-tag-btn" data-value="${value}">×</button></div>`;
            $tagsArea.append(newTag);
        } else if (!$checkbox.is(':checked') && isTagExist) {
            $tagsArea.find(`.filter-tag[data-value="${value}"]`).remove();
        }
    });

    /* 태그 'x' 버튼 클릭 -> 태그 삭제 및 체크박스 해제 (이벤트 위임) */
    $tagsArea.on('click', '.remove-tag-btn', function() {
        const valueToRemove = $(this).data('value');
        $(this).closest('.filter-tag').remove();
        $(`.filter-checkbox[value="${valueToRemove}"]`).prop('checked', false);
    });

    //================================================================
    // 3. 필터 초기화 및 상태 복원
    //================================================================

    /**
     * [범용] 체크박스 UI를 그리고, 그려진 UI에 대해 즉시 상태를 복원하는 함수
     */
    function populateAndRestore($targetElement, filterName, codeData) {
        $targetElement.empty();
        if (!codeData || codeData.length === 0) {
            $targetElement.append('<div>옵션이 없습니다.</div>');
            return;
        }
        
        // 체크박스 HTML 생성
        codeData.forEach(code => {
            const newCheckboxHTML = `<label><input type="checkbox" class="filter-checkbox" name="${filterName}" value="${code.code}" data-text="${code.code_name}">${code.code_name}</label>`;
            $targetElement.append(newCheckboxHTML);
        });
        
        // ✨ 체크박스가 모두 그려진 직후, 상태 복원 실행
        const selectedCodes = selectedFilters[filterName];
        if (selectedCodes && Array.isArray(selectedCodes)) {
            selectedCodes.forEach(code => {
                const $checkbox = $targetElement.find(`.filter-checkbox[value="${code}"]`);
                if ($checkbox.length > 0 && !$checkbox.is(':checked')) {
                    $checkbox.prop('checked', true).trigger('change');
                }
            });
        }
    }
    
    // [A. 단일 목록 필터 초기화]
    $('.single-level-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();
        const $optionsTarget = $filterDropdown.find('.filter-options');
        
        if (groupId && $optionsTarget.length) {
            ajaxRequest(contextPath + '/api/codes?groupId=' + groupId, 'GET', {}, 
                response => populateAndRestore($optionsTarget, filterType, response)
            );
        }
    });

    // [B. 계층 구조 필터 초기화]
    $('.hierarchical-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();
        const $majorList = $filterDropdown.find('.major-list');
        const $subList = $filterDropdown.find('.sub-list');
        const $checkAll = $filterDropdown.find('.check-all');
        const $searchInput = $filterDropdown.find('.search-input');
        
        // selectedFilters를 기반으로 활성화될 대분류 결정
        let activeParentCode = null;
        const selectedSubCodes = selectedFilters[filterType];
        if (selectedSubCodes && selectedSubCodes.length > 0) {
            const firstSubCode = selectedSubCodes[0];
            $majorList.find('.major-item').each(function() {
                const $majorItem = $(this);
                const majorCode = $majorItem.data('code');
                if (String(firstSubCode).startsWith(String(majorCode))) {
                    activeParentCode = majorCode;
                }
            });
        }
        
        if (!activeParentCode) {
            activeParentCode = $majorList.find('.major-item:first').data('code');
        }
        
        // 결정된 대분류에 active 클래스 부여 및 소분류 로드
        if (activeParentCode) {
            $majorList.find('.major-item').removeClass('active');
            $majorList.find(`.major-item[data-code="${activeParentCode}"]`).addClass('active');

            ajaxRequest(
                contextPath + '/api/codes?groupId=' + groupId + '&parentCode=' + activeParentCode,
                'GET', {},
                response => populateAndRestore($subList, filterType, response)
            );
        }
        
        // 대분류 클릭 이벤트
        $majorList.on('click', '.major-item', function() {
            const $this = $(this);
            if ($this.hasClass('active')) return;
            $majorList.find('.major-item').removeClass('active');
            $this.addClass('active');
            const parentCode = $this.data('code');
            ajaxRequest(
                contextPath + '/api/codes?groupId=' + groupId + '&parentCode=' + parentCode,
                'GET', {},
                response => populateAndRestore($subList, filterType, response)
            );
            $checkAll.prop('checked', false);
            if($searchInput.length) $searchInput.val('');
        });
        
            $checkAll.on('change', function() {
        // 1. '전체' 체크박스의 현재 체크 상태를 가져옵니다. (true/false)
        const isChecked = $(this).is(':checked');
        
        // 2. 소분류 목록($subList) 안에서, "화면에 보이는(visible)" 모든 체크박스를 찾습니다.
        //    (검색 기능으로 일부가 숨겨졌을 경우를 대비)
        const $visibleCheckboxes = $subList.find('label:visible .filter-checkbox');
        
        // 3. 찾은 모든 체크박스의 'checked' 속성을 '전체' 체크박스의 상태와 동일하게 변경합니다.
        //    그리고 'change' 이벤트를 강제로 발생시켜, 연결된 태그 생성/삭제 로직이 실행되도록 합니다.
        $visibleCheckboxes.prop('checked', isChecked).trigger('change');
    });
    
    });
    
    //================================================================
    // 4. 최종 필터 검색 로직
    //================================================================
//    $form.on('submit', function(event) {
//        event.preventDefault();
//        const $hiddenInputsArea = $('#hidden-filter-inputs');
//        $hiddenInputsArea.empty();
//
//        const $checkedFilters = $('.filter-checkbox:checked');
//        const filterParams = {};
//        
//        $checkedFilters.each(function() {
//            const name = $(this).attr('name');
//            const value = $(this).val();
//            if (!filterParams[name]) {
//                filterParams[name] = [];
//            }
//            filterParams[name].push(value);
//        });
//
//        // URL에서 현재 sort 값을 읽어와 함께 보냄
//        const currentUrlParams = new URLSearchParams(window.location.search);
//        const sortValue = currentUrlParams.get('sort') || 'latest';
//        $hiddenInputsArea.append(`<input type="hidden" name="sort" value="${sortValue}">`);
//
//        for (const name in filterParams) {
//            const valueString = filterParams[name].join(',');
//            $hiddenInputsArea.append(`<input type="hidden" name="${name}" value="${valueString}">`);
//        }
//        
//        $form.get(0).submit();
//    });

});
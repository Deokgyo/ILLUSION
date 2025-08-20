$(function() {

    //================================================
    // 1. 전역 변수 및 헬퍼 함수
    //================================================
    
    const scriptSrc = $('script[src*="filterEvent.js"]').attr('src');
    const contextPath = scriptSrc ? scriptSrc.substring(0, scriptSrc.indexOf('/resources')) : "";
    
    console.log("Dynamically detected contextPath:", contextPath); // 확인용 로그
    
    const $tagsArea = $('#selected-tags-area');

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

    /**
     * [범용] 서버 응답으로 체크박스 UI를 생성하는 함수
     */
    function populateCheckboxes($targetElement, filterName, codeData) {
        $targetElement.empty();
        if (!codeData || codeData.length === 0) {
            $targetElement.append('<div>옵션이 없습니다.</div>');
            return;
        }
        codeData.forEach(code => {
            const newCheckboxHTML = `
                <label>
                    <input type="checkbox" class="filter-checkbox" 
                           name="${filterName}" value="${code.code}" data-text="${code.code_name}">
                    ${code.code_name}
                </label>
            `;
            $targetElement.append(newCheckboxHTML);
        });
    }
    
    //================================================
    // 2. 범용 UI 이벤트 핸들러 (모든 필터 공통)
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
    

    
    //================================================================
    // 3. 필터 유형별 초기화 로직 (유일한 실행 로직)
    //================================================================

    // ✨ [A. 단일 목록 필터 초기화]
    $('.single-level-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();
        const $optionsTarget = $filterDropdown.find('.filter-options');
        
        if (groupId && $optionsTarget.length) {
            ajaxRequest(
                contextPath + '/api/codes',
                'GET',
                { groupId: groupId },
                response => populateCheckboxes($optionsTarget, filterType, response)
            );
        }
    });

    // ✨ [B. 계층 구조 필터 초기화]
    $('.hierarchical-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();

        const $majorList = $filterDropdown.find('.major-list');
        const $subList = $filterDropdown.find('.sub-list');
        const $checkAll = $filterDropdown.find('.check-all');
        const $searchInput = $filterDropdown.find('.search-input');
        let searchTimer;

        // 대분류 클릭 이벤트
        $majorList.on('click', '.major-item', function() {
            const $this = $(this);
            $majorList.find('.major-item').removeClass('active');
            $this.addClass('active');
            const parentCode = $this.data('code');
            
            ajaxRequest(
                contextPath + '/api/codes',
                'GET',
                { groupId: groupId, parentCode: parentCode },
                response => populateCheckboxes($subList, filterType, response)
            );
            $checkAll.prop('checked', false);
            if($searchInput.length) $searchInput.val('');
        });
        
        // '전체 선택' 체크박스 기능
        $checkAll.on('change', function() {
            $subList.find('label:visible .filter-checkbox').prop('checked', $(this).is(':checked')).trigger('change');
        });
        
        // 검색 기능 (검색창이 있는 경우에만)
        if($searchInput.length) {
            $searchInput.on('keyup', function() {
                clearTimeout(searchTimer);
                const keyword = $(this).val().trim();
                searchTimer = setTimeout(() => {
                    ajaxRequest(
                        contextPath + '/api/codes/search',
                        'GET',
                        { groupId: groupId, keyword: keyword },
                        response => populateCheckboxes($subList, filterType, response)
                    );
                }, 300);
            });
        }

        // 페이지 로드 시, 기본 소분류 목록 불러오기
        const initialParentCode = $majorList.find('.major-item.active').data('code');
        if (initialParentCode) {
            ajaxRequest(
                contextPath + '/api/codes',
                'GET',
                { groupId: groupId, parentCode: initialParentCode },
                response => populateCheckboxes($subList, filterType, response)
            );
        }
    });
    
    //================================================================
    // 4. 페이지 로드 시, 선택된 필터 복원 로직
    //================================================================

    function restoreSelectedFilters() {
        // 1. JSP가 <form> 태그의 data-selected-filters 속성에 심어둔 JSON 데이터를 읽는다.
        const selectedFilters = $('#filter-form').data('selected-filters');
        
        console.log("복원할 필터 데이터:", selectedFilters);

        if (!selectedFilters || Object.keys(selectedFilters).length === 0) {
            return; // 복원할 데이터가 없으면 종료
        }

        // 2. DTO의 필드명(locations, occupations 등)을 순회한다.
        for (const filterName in selectedFilters) {
            const selectedCodes = selectedFilters[filterName];

            // 3. 선택된 코드 목록(배열)이 있는지 확인한다.
            if (selectedCodes && Array.isArray(selectedCodes)) {
                // 4. 각 코드를 순회하면서 해당하는 체크박스를 찾아서 체크한다.
                selectedCodes.forEach(code => {
                    // name 속성과 value 속성이 모두 일치하는 체크박스를 정확히 찾는다.
                    const $checkbox = $(`.filter-checkbox[name="${filterName}"][value="${code}"]`);
                    
                    if ($checkbox.length > 0) {
                        // 체크박스를 체크하고, 'change' 이벤트를 강제로 발생시켜
                        // 연결된 태그 생성 로직도 함께 실행되도록 한다.
                        $checkbox.prop('checked', true).trigger('change');
                    }
                });
            }
        }
    }
    
    //================================================================
    // 5. 최종 필터 검색 로직
    //================================================================
//    $('#filter-form').on('submit', function(event) {
//        event.preventDefault();
//        const $form = $(this);
//        const $hiddenInputsArea = $('#hidden-filter-inputs');
//        $hiddenInputsArea.empty();
//
//        const $checkedFilters = $('.filter-checkbox:checked');
//
//        const filterParams = {};
//        $checkedFilters.each(function() {
//            const name = $(this).attr('name');
//            const value = $(this).val();
//            if (!filterParams[name]) {
//                filterParams[name] = [];
//            }
//            filterParams[name].push(value);
//        });
//
//        // 정렬 기준(sort) 값도 함께 보내기 위해 hidden input을 추가
//        // URL에서 현재 sort 값을 읽어온다.
//        const currentUrlParams = new URLSearchParams(window.location.search);
//        const sortValue = currentUrlParams.get('sort') || 'latest';
//        filterParams['sort'] = [sortValue]; // 배열 형태로 통일
//
//        for (const name in filterParams) {
//            const valueString = filterParams[name].join(',');
//            $hiddenInputsArea.append(`<input type="hidden" name="${name}" value="${valueString}">`);
//        }
//        
//        $form.get(0).submit();
//    });

    //================================================================
    // 6. 실행 순서 보장
    //================================================================
    
    // 이 이벤트는 현재 페이지에서 진행중인 모든 AJAX 요청이 완료되면 단 한번 실행됩니다.
    $(document).ajaxStop(function () {
        
        // 모든 필터 옵션(체크박스)들이 그려진 것이 보장된 이 시점에 복원 함수를 호출합니다.
        restoreSelectedFilters();
        
        // 이 이벤트 핸들러는 한번만 실행되면 되므로, 실행 후에는 제거하여 불필요한 반복을 막습니다.
        $(this).off("ajaxStop");
    });

});
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

    //================================================================
    // 3. 필터 유형별 초기화 로직
    //================================================================

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

    /**
     * [A. 단일 목록 필터 초기화]
     */
    $('.single-level-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();
        const $optionsTarget = $filterDropdown.find('.filter-options');
        
        if (groupId && $optionsTarget.length) {
            ajaxRequest(
                contextPath + '/api/codes', // 고정 URL
                'GET',
                { groupId: groupId },      // data 객체에 파라미터 전달
                response => populateCheckboxes($optionsTarget, filterType, response)
            );
        }
    });

    /**
     * [B. 계층 구조 필터 초기화]
     */
    $('.hierarchical-filter').each(function() {
        const $filterDropdown = $(this);
        const filterType = this.id.replace('-filter-group', '');
        const groupId = filterType.toUpperCase();

        const $majorList = $filterDropdown.find('.major-list');
        const $subList = $filterDropdown.find('.sub-list');
        const $checkAll = $filterDropdown.find('.check-all');
        const $searchInput = $filterDropdown.find('.search-input');
        let searchTimer;

        /* 대분류 클릭 이벤트 */
        $majorList.on('click', '.major-item', function() {
            const $this = $(this);
            $majorList.find('.major-item').removeClass('active');
            $this.addClass('active');
            const parentCode = $this.data('code');
            
            ajaxRequest(
                contextPath + '/api/codes',
                'GET',
                {
                    groupId: groupId,
                    parentCode: parentCode
                },
                response => populateCheckboxes($subList, filterType, response)
            );
//            $checkAll.prop('checked', false);
//            if($searchInput.length) $searchInput.val('');
        });
        
        /* '전체 선택' 체크박스 기능 */
        $checkAll.on('change', function() {
            $subList.find('label:visible .filter-checkbox').prop('checked', $(this).is(':checked')).trigger('change');
        });
        
//        /* 검색 기능 (검색창이 있는 필터만 동작) */
//        if($searchInput.length) {
//            $searchInput.on('keyup', function() {
//                clearTimeout(searchTimer);
//                const keyword = $(this).val().trim();
//                searchTimer = setTimeout(() => {
//                    ajaxRequest(
//                        contextPath + '/api/codes/search',
//                        'GET',
//                        {
//                            groupId: groupId,
//                            keyword: keyword
//                        },
//                        response => populateCheckboxes($subList, filterType, response)
//                    );
//                }, 300);
//            });
//        }

        // 페이지 로드 시, 기본 소분류 목록 불러오기
        const initialParentCode = $majorList.find('.major-item.active').data('code');
        if (initialParentCode) {
            // ✅ @RequestParam 방식 AJAX 호출
            ajaxRequest(
                contextPath + '/api/codes',
                'GET',
                {
                    groupId: groupId,
                    parentCode: initialParentCode
                },
                response => populateCheckboxes($subList, filterType, response)
            );
        }
    });
    
        /**
     * 서버에서 받은 코드 목록으로 체크박스 UI를 생성하여 타겟 영역에 채워넣는 함수
     * @param {jQuery} $targetElement - 체크박스가 삽입될 JQuery 객체
     * @param {string} filterName - 체크박스의 name 속성에 들어갈 값 (예: 'locations')
     * @param {Array} codeData - 서버에서 받은 공통 코드 데이터 배열
     */
    function populateFilterOptions($targetElement, filterName, codeData) {
        $targetElement.empty(); // 기존 내용 비우기
        
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

    /**
     * 페이지에 있는 모든 동적 필터들을 초기화하는 메인 함수
     */
    function initializeDynamicFilters() {
        // data-group-id 속성을 가진 모든 필터 드롭다운을 찾아서 반복 실행
        $('.filter-dropdown[data-group-id]').each(function() {
            const $filterDropdown = $(this);
            const groupId = $(this).data('group-id'); // 예: "LOCATION", "OCCUPATION"
            const filterName = $filterDropdown.data('filter-type') + 's'; // 예: "locations", "occupations"
            const $optionsTarget = $filterDropdown.find('[data-target="options-list"]');
            const requestUrl = contextPath + '/api/codes/' + groupId;

            if (groupId && $optionsTarget.length) {
	
			console.log(`API 요청 시작: groupId = ${groupId}`); 
                // 각 필터에 맞는 범용 API를 호출하여 데이터를 가져온다.
                ajaxRequest(
                    requestUrl, // ✨ Controller에 만든 범용 API URL
                    'GET',
                    { groupId: groupId },
                    function(response) {
                        // 성공 시, 받아온 데이터로 체크박스를 생성하는 함수 호출
                        populateFilterOptions($optionsTarget, filterName, response);
                    }
                );
            }
        });
    }
    
    initializeDynamicFilters();
    
});

// ------------------------------------------------------------

$(function() {
    
    // ...

    //================================================================
    // 4. 최종 '필터 검색' 버튼 클릭 시 동작
    //================================================================
    $('#filter-form').on('submit', function(event) {
	
		console.log("체크되노?");
        
        // 1. 폼의 기본 제출 기능을 일단 막는다. (URL이 바로 바뀌는 것을 방지)
        event.preventDefault(); 
        
        const $form = $(this);
        const $hiddenInputsArea = $('#hidden-filter-inputs');
        
        // 2. 이전 검색 시 만들어졌을 수 있는 hidden input들을 모두 비운다 (초기화).
        $hiddenInputsArea.empty();

        // 3. 현재 페이지에서 사용자가 체크한 모든 필터 체크박스를 찾는다.
        const $checkedFilters = $('.filter-checkbox:checked');
        
        // 4. (선택사항) 만약 체크된 필터가 하나도 없다면, 바로 폼을 제출하여 전체 목록을 보게 한다.
        if ($checkedFilters.length === 0) {
            $form.get(0).submit();
            return;
        }

        // 5. 선택된 값들을 name을 기준으로 그룹화한다.
        // 예: { locations: ['11', '21'], occupations: ['JOB010'] }
        const filterParams = {};
        $checkedFilters.each(function() {
            const name = $(this).attr('name'); // 예: "locations", "occupations"
            const value = $(this).val();      // 예: "11", "JOB010"
            
            // 해당 name의 배열이 없으면 새로 만든다.
            if (!filterParams[name]) {
                filterParams[name] = [];
            }
            // 해당 name의 배열에 값을 추가한다.
            filterParams[name].push(value);
        });

        // 6. 그룹화된 값들을 쉼표로 구분된 문자열로 만들고,
        //    <input type="hidden">을 생성하여 form에 추가한다.
        for (const name in filterParams) {
            const valueString = filterParams[name].join(','); // 예: "11,21"
            const hiddenInput = `<input type="hidden" name="${name}" value="${valueString}">`;
            $hiddenInputsArea.append(hiddenInput);
        }
        
        // 7. 모든 hidden input이 준비되면, JavaScript가 직접 폼을 제출하여
        //    서버로 필터 조건들을 전송한다.
        $form.get(0).submit(); 
    });
});

$(function() {
    // ... (기존의 모든 코드) ...

    //================================================================
    // 4. 페이지 로드 시, 선택된 필터 복원 로직
    //================================================================
    function restoreSelectedFilters() {
        const $form = $('#filter-form');
        const selectedFilters = $form.data('selected-filters'); // 숨겨진 JSON 데이터 읽기

        if (!selectedFilters) return;

        // 모든 필터 종류(locations, occupations 등)에 대해 반복
        for (const filterName in selectedFilters) {
            const selectedCodes = selectedFilters[filterName]; // 예: ["11230", "11220"]

            if (selectedCodes && Array.isArray(selectedCodes)) {
                selectedCodes.forEach(code => {
                    // 해당 code 값을 가진 체크박스를 찾아서 'checked' 상태로 만든다.
                    const $checkbox = $(`.filter-checkbox[value="${code}"]`);
                    if ($checkbox.length) {
                        $checkbox.prop('checked', true);
                        
                        // change 이벤트를 강제로 발생시켜, 태그 생성 로직을 실행한다.
                        $checkbox.trigger('change'); 
                    }
                });
            }
        }
    }

    setTimeout(restoreSelectedFilters, 500); // 0.5초 후에 실행

});
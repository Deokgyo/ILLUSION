// DOM이 모두 로드된 후 코드가 실행되도록 보장합니다.
$(function () {
    // 페이지가 로드되면, 서버에서 지원자 데이터를 가져와서 그리드를 렌더링하는 함수를 호출합니다.
    loadAndRenderGrid();
});

// ================================================================
// ==         함 수 선 언 부                                     ==
// ================================================================
	$('.download').on('click', function() {
		alert('이거언제뜨냐');
	});


/**
 * 서버에서 지원자 목록 데이터를 비동기(AJAX)로 가져와
 * Grid.js를 초기화하고 화면에 렌더링하는 메인 함수
 */
function loadAndRenderGrid() {
    $.ajax({
        url: 'getApply', // 데이터를 요청할 백엔드 URL
        method: 'post',
        dataType: 'json',
       success: function(response) {
    if (!response || response.length === 0) {
        alert("표시할 지원자 데이터가 없습니다.");
        return;
    }
	console.log(response);
    // --- 1. 최종 데이터 배열 순서 정의 ---
    // formatter에서 사용할 모든 데이터를 명확한 순서로 배열에 담습니다.
    const gridData = response.map(applicant => [
        applicant.rn,				//0번
        applicant.member_name,      // 1번
        applicant.recruit_idx,      // 2번
        applicant.recruit_subject,  // 3번
        applicant.resume_idx,       // 4번
        applicant.resume_title,     // 5번
        applicant.cl_idx,           // 6번
        applicant.cl_title,         // 7번
        applicant.status_code,      // 8번 (상태 코드)
        applicant.status,            // 9번 (상태 이름, 예: "심사중")
        applicant.apply_idx,        // 10번
        applicant.apply_files_path        // 11번
    ]);

    // --- 2. 위 데이터 순서에 맞춰 컬럼 정의 ---
    const grid = new gridjs.Grid({
        columns: [
            // 컬럼 1: 번호 (CSS로 자동 생성, 데이터 사용 안 함)
            { 	
				id: 'rn',
                name: '번호',
                width: '70px'
            },
            // 컬럼 2: 지원자 이름 (데이터 1번 인덱스 사용)
            { name: '지원자 이름' },
            // 컬럼 3: 공고 제목 (데이터 2, 3번 인덱스 사용)
            {
                name: '공고 제목',
                formatter: (_, row) => {
                    const recruitIdx = row.cells[2].data;
                    const recruitSubject = row.cells[3].data;
                    return gridjs.html(`<a href='recruitmentDetail?recruit_idx=${recruitIdx}'>${recruitSubject}</a>`);
                }
            },
            // 컬럼 4: 이력서 제목 (데이터 4, 5번 인덱스 사용)
            {
                name: '이력서 제목',
                formatter: (_, row) => {
                    const resumeIdx = row.cells[4].data;
                    const resumeTitle = row.cells[5].data;
                    const applyIdx = row.cells[10].data;
                    return gridjs.html(`<a href='viewResume?resume_idx=${resumeIdx}&apply_idx=${applyIdx}'>${resumeTitle}</a>`);
                }
            },
            // 컬럼 5: 자소서 제목 (데이터 6, 7번 인덱스 사용)
            {
                name: '자소서 제목',
                formatter: (_, row) => {
                    const clIdx = row.cells[6].data;
                    const clTitle = row.cells[7].data;
                    return clTitle == '자소서가 없습니다' ? 
                    gridjs.html(`${clTitle}`) : 
                    gridjs.html(`<a href='viewCoverletter?cl_idx=${clIdx}'>${clTitle}</a>`);
//                    return gridjs.html(`<a href='coverletterResult?cl_idx=${clIdx}'>${clTitle}</a>`);
                }
            },
            {
				name:'첨부파일',
				formatter: (_,row) => {
					let apply_files_path = row.cells[11].data;
					return apply_files_path == '첨부파일 없음' ? 
					gridjs.html(`${apply_files_path}`) : 
					gridjs.html(`<a href="${apply_files_path}" download class="download">다운로드하기</a>`)				
				}
			},
            // 컬럼 6: 상태변경 (데이터 0, 8, 9번 인덱스 사용)
            {
                name: '상태변경',
                sort: false,
                width: '300px',
                formatter: (_, row) => {
                    const applyIdx = row.cells[10].data;
                    const currentStatusCode = row.cells[8].data;
                    const Status = row.cells[9].data;
                    const options = `
                        <option value="APS001" ${currentStatusCode === 'APS001' ? 'selected' : ''}>심사중</option>
                        <option value="APS002" ${currentStatusCode === 'APS002' ? 'selected' : ''}>합격</option>
                        <option value="APS003" ${currentStatusCode === 'APS003' ? 'selected' : ''}>불합격</option>
                    `;
                    return gridjs.html(
                        `<div>
                            <select class="status-select" data-id="${applyIdx}">${options}</select>
                            <button class="update-btn" data-id="${applyIdx}">변경</button>
                        </div>`
                    );
                }
            },
            // formatter에서만 사용할 데이터들은 hidden 컬럼으로 관리하면 편리합니다.
            { name: 'apply_idx', hidden: true },
            { name: 'recruit_idx', hidden: true },
            { name: 'recruit_subject', hidden: true },
            { name: 'resume_idx', hidden: true },
            { name: 'resume_title', hidden: true },
            { name: 'cl_idx', hidden: true },
            { name: 'cl_title', hidden: true },
            { name: 'status_code', hidden: true },
            { name: 'status', hidden: true }
        ],

        data: gridData,
        search: true,
        pagination: { limit: 10 },
        sort: true,
        language: {
		search: {
	      placeholder: '검색어를 입력하세요'   // 검색창 placeholder
	    },
    	pagination: {
	      previous: '<',
	      next: '>',
		 },
	   	loading: '불러오는 중...',
	    noRecordsFound: '검색 결과가 없습니다',   // ← 여기
	    error: '데이터를 불러오는 중 오류가 발생했습니다'
	},
    });

            // --- 3. 그리드를 실제 화면에 렌더링합니다. ---
            const gridContainer = $('#applicant-grid');
            grid.render(gridContainer[0]);

            // --- 4. 렌더링된 그리드에 이벤트 핸들러를 바인딩합니다. ---
            // (이벤트 핸들러 코드는 기존 코드와 거의 동일)
            gridContainer.on('click', '.update-btn', function() {
                const applyId = $(this).data('id'); // apply_idx를 사용
                const selectElement = $(`.status-select[data-id="${applyId}"]`);
                const newStatus = selectElement.val();
                const statusText = selectElement.find('option:selected').text();

                if (confirm(`상태를 '${statusText}'(으)로 변경하시겠습니까?`)) {
                    $.ajax({
                        url: 'updateApplyStatus',
                        method: 'POST',
                        data: {
                            apply_idx: applyId, // 백엔드에 apply_idx 전송
                            status: newStatus
                        },
                        success: function() {
                            alert("상태가 성공적으로 변경되었습니다.");
                        },
                        error: function() {
                            alert("서버 통신 중 오류가 발생했습니다.");
                        }
                    });
                }
            });
        },
        error: function() {
            // AJAX 호출 자체에 실패했을 때 처리
            alert("지원자 목록을 불러오는 데 실패했습니다.");
        }
    });
}
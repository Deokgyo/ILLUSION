$(document).ready(function() {
    let rowIndex = 0;
    const tableBody = $('#code-table-body');

    // 템플릿 HTML 가져오기
    const templateHtml = $('#code-row-template').html();

    function addRow() {
        // 템플릿에서 행 복제
        const newRow = $(templateHtml);

        // 각 input/select에 고유한 name 속성을 부여합니다. (배열 형태로)
        newRow.find('select.code-group-id').attr('name', `codes[${rowIndex}].code_group_id`);
        newRow.find('input.code').attr('name', `codes[${rowIndex}].code`);
        newRow.find('input.code-name').attr('name', `codes[${rowIndex}].code_name`);
        newRow.find('input.parent-code-id').attr('name', `codes[${rowIndex}].parent_code_id`);

        // 테이블 본문에 새 행을 추가합니다.
        tableBody.append(newRow);
        rowIndex++;
    }

    // 페이지가 로드될 때 기본으로 한 행 추가
    addRow();

    // '행 추가' 버튼 클릭 이벤트
    $('#btn-add-row').on('click', function() {
        addRow();
    });

    // '삭제' 버튼 클릭 이벤트 
    tableBody.on('click', '.btn-remove-row', function() {
        if (tableBody.find('tr').length > 1) {
            $(this).closest('tr').remove();
        } else {
            alert("최소 한 개의 행은 필요합니다.");
        }
    });
});

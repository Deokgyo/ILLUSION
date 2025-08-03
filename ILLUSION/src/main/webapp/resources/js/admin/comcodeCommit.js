document.addEventListener('DOMContentLoaded', () => {

    const addRowBtn = document.querySelector('.btn-add-row');
    const deleteRowBtn = document.querySelector('.btn-delete-row');
    const checkAll = document.getElementById('check-all-rows');
    const tableBody = document.getElementById('common-code-tbody');

    // 행 번호를 다시 매기는 함수
    function renumberRows() {
        const rows = tableBody.querySelectorAll('tr');
        rows.forEach((row, index) => {
            row.querySelector('.row-num').textContent = index + 1;
        });
    }

    // 행 추가 기능
    addRowBtn.addEventListener('click', () => {
        const newRow = document.createElement('tr');
        const rowCount = tableBody.querySelectorAll('tr').length;

        newRow.innerHTML = `
            <td><input type="checkbox" class="row-check"></td>
            <td class="row-num">${rowCount + 1}</td>
            <td><input type="text" placeholder="공통 코드 ID 입력"></td>
            <td><input type="text" placeholder="공통 코드 명 입력"></td>
            <td><input type="text" placeholder="설명 입력"></td>
        `;
        tableBody.appendChild(newRow);
    });

    // 선택된 행 삭제 기능
    deleteRowBtn.addEventListener('click', () => {
        const checkedRows = tableBody.querySelectorAll('.row-check:checked');
        if (checkedRows.length === 0) {
            alert('삭제할 행을 선택해주세요.');
            return;
        }
        checkedRows.forEach(checkbox => {
            checkbox.closest('tr').remove();
        });
        renumberRows(); // 행 삭제 후 번호 다시 매기기
    });

    // 전체 선택/해제 기능
    checkAll.addEventListener('click', () => {
        const allCheckboxes = tableBody.querySelectorAll('.row-check');
        allCheckboxes.forEach(checkbox => {
            checkbox.checked = checkAll.checked;
        });
    });

});
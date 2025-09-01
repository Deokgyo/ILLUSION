  $(document).ready(function () {

  const editableKeys = new Set(['담당자 이메일','기업 로고']);

  let editingKey = null; // 현재 편집중인 key

const grid = new gridjs.Grid({
  columns: [
    { 
      name: '항목',
      width: '120px',
      formatter: (cell) => gridjs.html(cell) // 항목 컬럼 HTML 처리
    },
    { 
      name: '값',
      formatter: (cell, row) => {
        const key = row.cells[0].data;

        // 기업로고: DB에 <img> 태그 그대로 저장되어 있으므로 그대로 HTML 렌더링
        if (key === '기업 로고' && typeof cell === 'string') {
          return gridjs.html(cell); // DB에 들어있는 <img> 태그 그대로 렌더링
        }

        // 편집 모드 - 담당자 이메일
        if (key === editingKey && key === '담당자 이메일') {
          return gridjs.html(
            `<input type="text" class="edit-input" value="${cell}" data-key="${key}"/>`
          );
        }

        return gridjs.html(cell); // 다른 값도 HTML 처리
      }
    },
    {
      name: '수정',
      width: '10px',
      formatter: (_, row) => {
        const key = row.cells[0].data;
        if (!editableKeys.has(key)) return '';
        return gridjs.html(`<button class="btn-edit" data-key="${key}">수정</button>`);
      }
    }
  ],
  data: () => {
    return $.ajax({
      url: 'getCompanyInfo',
      method: 'POST',
      dataType: 'json'
    }).then(res => {
      // DB에 <img> 태그가 이미 들어 있으므로 그대로 반환
      return Object.entries(res).map(([key, value]) => [key, value]);
    });
  },
  search: false, 
  sort: false, 
  pagination: false,
  style: {
    table: { border: 'none' },
    th: { border: 'none', background: '#ffe894' },
    td: { border: 'none' }
  }
}).render(document.getElementById('companyTable'));

function hideHeader() {
  const head = document.querySelector('#companyTable thead');
  if (head) head.style.display = 'none';
  const h1 = document.querySelector('#companyTable .gridjs-thead');
  if (h1) h1.style.display = 'none';
  const h2 = document.querySelector('#companyTable .gridjs-head');
  if (h2) h2.style.display = 'none';
}

grid.on('ready', hideHeader);

  // 수정 버튼 클릭 이벤트
  document.addEventListener('click', (e) => {
    const btn = e.target.closest('.btn-edit');
    if (!btn) return;

    const key = btn.dataset.key;
//    const i = data.findIndex(r => r.key === key);
//    if (i < 0) return;

    if (key == '기업 로고') {
     $('#logoFile').click();
      return;
    }

    // 담당자 이름 / 이메일 → 편집 모드 전환
    if (key == '담당자 이메일') {
      editingKey = key;
      grid.updateConfig({ data: data.map(r => [r.key, r.value]) }).forceRender();
    }
  });

  // 파일 선택 시 로고 업데이트
  document.getElementById('logoFile').addEventListener('change', (e) => {
    const file = e.target.files && e.target.files[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) { alert('이미지 파일만 업로드하세요.'); return; }

    const previewUrl = URL.createObjectURL(file);
    const i = data.findIndex(r => r.key === '기업로고');
    if (i >= 0) {
      data[i].value = previewUrl;
      grid.updateConfig({ data: data.map(r => [r.key, r.value]) }).forceRender();
    }
    e.target.value = '';
  });

  // 인풋 포커스 아웃 시 값 저장
  document.addEventListener('blur', (e) => {
    if (!e.target.classList.contains('edit-input')) return;
    const key = e.target.dataset.key;
    const i = data.findIndex(r => r.key === key);
    if (i >= 0) {
      data[i].value = e.target.value;
    }
    editingKey = null;
    grid.updateConfig({ data: data.map(r => [r.key, r.value]) }).forceRender();
  }, true);
  
  grid.updateConfig({ data: newData }).forceRender();
hideHeader();
  

 });
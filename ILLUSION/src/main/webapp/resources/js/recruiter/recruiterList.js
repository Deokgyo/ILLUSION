$(function () {
	
	$('.tab').on('click', function () {
	    $('.tab').removeClass('active');
	    $(this).addClass('active');
	    // 탭 전환 시 필요한 추가 동작 넣기
 	 });
	
	  $('input[name="sort"]').on('change', function () {
	    const selected = $(this).val();
	    console.log('선택된 정렬:', selected);
	    // 여기에 정렬 로직 추가 가능
	  });
	
	
	// ==========================================================	
	// girs.js 	
	// ==========================================================	
	$(document).ready(function () {
  const grid = new gridjs.Grid({
    columns: [
      {
        name: '선택',
        width: '80px',
        formatter: (_, row) =>
          gridjs.html(`<input type="checkbox" class="row-check" data-id="${row._index}" />`)
      },
      '공고 제목',
      '공고 상태',
      '지원자 수',
      '등록일',
      '마감일',
      {
        name: '관리',
        formatter: (_, row) => gridjs.html(`
          <button class="btn btn-edit" data-id="${row._index}">수정</button>
          <button class="btn btn-reg" data-id="${row._index}">재등록</button>
        `)
      }
    ],
    data: [
      ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""],
  	  ["", "[아이티윌] 백엔드", "채용중", "10명", "25.07.25", "25.08.01", ""]
    ],
    pagination: true,
    sort: true,
    search: true,
    className: {
    table: 'grid-custom-table'
    },
    rowAttributes: (row, index) => {
      return row[1] === "채용중" && index === 0
        ? { class: 'active-row' }
        : {};
    }
  });

  grid.render(document.getElementById("grid"));
});
	
	
	
}) // 도큐먼트 레디 
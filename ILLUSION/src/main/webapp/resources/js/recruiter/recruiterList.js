
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
		
  const grid = new gridjs.Grid({
    columns: [
      {
        id: 'no', 
        name: '번호', 
        width: '73px'
      },
      {
		id: 'recruit_subject',
		name : '공고 제목',
		width: '300px'
	  },		
      {
		id: 'rec_status',
		name : '공고 상태',
		width: '120px'
	  },		
      {
		id: 'app_count',
		name : '지원자 수',
		width: '112px'
	  },		
      {
		id: 'post_create_at',
		name : '등록일',
		formatter: c => {
		  if (!c) return '';
		  // 문자열 → 쉼표 기준 분리
		  const parts = c.toString().replace(/,$/, '').split(',');
		  // [년도, 월, 일] 형태일 때만 변환
		  if (parts.length >= 3) {
		    return `${parts[0]}.${parts[1]}.${parts[2]}`;
		  }
		  return c;
		}
	  },		
      {
		id: 'end_date',
		name : '마감일',
		formatter: c => {
		  if (!c) return '';
		  // 문자열 → 쉼표 기준 분리
		  const parts = c.toString().replace(/,$/, '').split(',');
		  // [년도, 월, 일] 형태일 때만 변환
		  if (parts.length >= 3) {
		    return `${parts[0]}.${parts[1]}.${parts[2]}`;
		  }
		  return c;
		}
	  },		
      {
        name: '관리',
        width: '171px',
        sort: false,
        formatter: () => gridjs.html(`
          <button class="btn btn-edit">수정</button>
          <button class="btn btn-reg">마감</button>
        `)
      }
    ],
	data: () => 
     Promise.resolve(
	    $.ajax({
	      url: 'getRecruitmentList',
	      method: 'GET',
	      dataType: 'json'
	    })
	  ).then(list => list.map((it, i) => ({ no: i + 1, ...it })))
	  .catch(err => {
	    console.error(err);
	    return [];
	  }),
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
    pagination: true,
    sort: true,
    search: true,
    className: { table: 'grid-custom-table'},
    rowAttributes: (row) => {
	  var status = (row && row._cells && row._cells[2]) ? row._cells[2].data : null;
	  return status === '채용중' ? { class: 'active-row' } : {};
    }, 
  });
  grid.render(document.getElementById("grid"));
  
});
	
	
	

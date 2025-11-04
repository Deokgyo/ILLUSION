$(function () {
	const grid = new gridjs.Grid({
    columns: [
      {
        id: 'no', 
        name: '번호', 
        width: '73px'
      },
      {
		id: 'company_name',
		name : '기업명',
		width: '120px'
	  },		
      {
		id: 'recruit_subject',
		name : '공고 제목',
		width: '300px'
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
		id: 'writer',
		name : '등록자',
		width: '112px'
	  },				
      {
		id: 'recruit_idx',
        name: '관리',
        width: '171px',
        sort: false,
        formatter: (cell) => gridjs.html(`
          <button class="btn btn-edit" onclick="location.href='recruitmentDetail?recruit_idx=${cell}'">공고상세보기</button>
          <button class="btn btn-reg" onclick="if(confirm('이 공고를 마감하시겠습니까?')) location.href='recruitClose?recruit_idx=${cell}'">마감</button>
          <button class="btn btn-reg" onclick="if(confirm('이 공고를 삭제하시겠습니까?')) location.href='recruitDelete?recruit_idx=${cell}'">삭제</button>
        `)
      }
    ],
	data: listChange,
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
	rowAttributes: function (row)  {
	  const statusCell = row?.cells?.find(cell => cell.column.id == 'rec_status');
	  return statusCell?.data == '채용중' ? { class: 'active-row' } : {};
	}
  });
  grid.render(document.getElementById("grid"));
	
	$('.tab').on('click', function () {
	    $('.tab').removeClass('active');
	    $(this).addClass('active');
	    // 탭 전환 시 필요한 추가 동작 넣기
	    grid.updateConfig({
		  data: grid.config.data // 👉 원래 넣어둔 data 함수 다시 실행
		}).forceRender();
 	 });	
	
	
})

// 위에 필터 눌렀을때 그리드.js 데이터 불러오는게 다름 
function listChange() {
	let val = $('.tab-container .tab.active').data('value');
	let url = (val == undefined) ? 'getAdminRecruitmentList' : `getAdminRecruitmentList?status=${val}`;
	return fetch(url)
	    .then(r => r.json())
	    .then(list => list.map((it, i) => ({ no: i + 1, ...it })))
	    .catch(err => {
	      return [];
    });
} 


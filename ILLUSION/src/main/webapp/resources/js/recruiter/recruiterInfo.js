  $(document).ready(function () {
    new gridjs.Grid({
      columns: [
		    {
      name: '기업 이름',
      width: '30px' // ← 너비 지정
    },
    {
      name: '일루션',
      width: '60px'
    }
	  ],
      data: [
        ["기업로고", gridjs.html('<div class="cell-inner">logo.png <button class="btn-yellow">수정</button></div>')],
        ["대표자명", gridjs.html('<div class="cell-inner">홍길동</div>')],
        ["아이디", gridjs.html('<div class="cell-inner">itwillbs3030</div>')],
        ["이메일", gridjs.html('<div class="cell-inner">itwillbs3030@itwillbs.com</div> <button class="btn-yellow">수정</button></div>')],
        ["담당자명", gridjs.html('<div class="cell-inner">김담당 <button class="btn-yellow">수정</button></div>')],
      ],
      pagination: false,
      sort: false,
      search: false
    }).render($(".member-info-container")[0]);
  });
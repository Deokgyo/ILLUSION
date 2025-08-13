<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 
    [전체 구조]
    - 최상위 div: JS가 이 필터를 '계층형'으로 인식하도록 공통 클래스 및 고유 ID 부여
    - 버튼: 드롭다운을 토글하는 역할
    - 드롭다운 메뉴: CSS에 정의된 클래스들을 사용하여 2단 패널 레이아웃 구성
    - 패널 내부: JS가 각 부분을 식별할 수 있도록 공통 클래스 부여
--%>
<div class="filter-dropdown hierarchical-filter" id="location-filter-group">
  
  <button type="button" class="toggle-filter-btn">
    지역별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <%-- CSS의 .location-filter-menu 스타일이 적용됩니다. --%>
  <div class="filter-dropdown-menu location-filter-menu hidden">
    
    <%-- 2단 패널 전체를 감싸는 래퍼 (CSS의 .location-panel-wrapper 스타일 적용) --%>
    <div class="location-panel-wrapper">
    
      <%-- 왼쪽 패널 (시/도 목록) --%>
      <div class="region-panel-left">
        <%-- JS가 대분류 목록과 아이템을 식별하기 위한 공통 class 추가 --%>
        <ul class="major-list major-region-list">
          <%-- 
            - major-item: JS가 클릭 이벤트를 감지하기 위한 공통 클래스
            - active: 페이지 로드 시 기본으로 선택될 항목
            - data-code: JS가 소분류 목록을 요청할 때 서버로 보낼 상위 코드 값
          --%>
          <li class="major-item major-region-item active" data-code="11">서울특별시</li>
          <li class="major-item major-region-item" data-code="21">부산광역시</li>
          <li class="major-item major-region-item" data-code="22">대구광역시</li>
          <li class="major-item major-region-item" data-code="23">인천광역시</li>
          <li class="major-item major-region-item" data-code="24">광주광역시</li>
          <li class="major-item major-region-item" data-code="25">대전광역시</li>
          <li class="major-item major-region-item" data-code="26">울산광역시</li>
          <li class="major-item major-region-item" data-code="31">경기도</li>
          <li class="major-item major-region-item" data-code="32">강원도</li>
          <li class="major-item major-region-item" data-code="33">충청북도</li>
          <li class="major-item major-region-item" data-code="34">충청남도</li>
          <li class="major-item major-region-item" data-code="35">전라북도</li>
          <li class="major-item major-region-item" data-code="36">전라남도</li>
          <li class="major-item major-region-item" data-code="37">경상북도</li>
          <li class="major-item major-region-item" data-code="38">경상남도</li>
          <li class="major-item major-region-item" data-code="39">제주도</li>
        </ul>
      </div>

      <%-- 오른쪽 패널 (시/군/구 목록) --%>
      <div class="region-panel-right">
        <%-- CSS의 .filter-header 스타일 적용 --%>
        <div class="filter-header">
          <%-- JS가 '전체 선택' 체크박스를 식별하기 위한 공통 class 추가 --%>
          <label><input type="checkbox" class="check-all"> 전체</label>
          <button type="button" class="filter-reset-btn">초기화</button>
        </div>
        
        <%-- 
          - filter-options: 체크박스들의 그리드 레이아웃 등을 위한 CSS 클래스
          - sub-list: JS가 이 영역을 소분류 목록 영역으로 식별하기 위한 공통 클래스
        --%>
        <div class="filter-options sub-list">
          <%-- 이 영역은 비어있으며, JavaScript가 AJAX로 데이터를 받아 동적으로 채웁니다. --%>
        </div>
      </div>
      
    </div>
  </div>
</div>
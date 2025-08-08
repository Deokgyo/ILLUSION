<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="filter-dropdown" data-filter-type="location">
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn">
    지역별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <div class="filter-dropdown-menu location-filter-menu hidden">
    <%-- 상단 검색창 --%>
    <div class="search-input-wrapper">
      <input type="text" id="location-search-input" placeholder="지역을 입력하세요">
    </div>

    <%-- 2단 패널 컨테이너 --%>
    <div class="location-panel-wrapper">
      <%-- 왼쪽: 시/도 목록 --%>
      <div class="region-panel-left">
        <ul id="major-region-list">
          <%-- 이 부분은 JS로 동적 생성하거나, JSP로 직접 출력할 수 있습니다. --%>
          <li class="major-region-item active" data-region-code="seoul">서울</li>
          <li class="major-region-item" data-region-code="busan">부산</li>
          <li class="major-region-item" data-region-code="daegu">대구</li>
          <%-- (기타 시/도 생략) --%>
        </ul>
      </div>

      <%-- 오른쪽: 시/군/구 목록 --%>
      <div class="region-panel-right">
        <div class="filter-header">
          <%-- '전체' 체크박스 추가 --%>
          <label><input type="checkbox" id="check-all-sub-regions"> 전체</label>
          <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
        </div>
        <div class="filter-options" id="sub-region-list">
          <%-- 시/도 클릭 시 JS가 이 영역을 동적으로 채웁니다. --%>
        </div>
      </div>
    </div>
  </div>
</div>
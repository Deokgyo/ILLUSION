<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="filter-dropdown single-level-filter" id="degree-filter-group">
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn" 
          data-filter-type="degree" data-group-id="DEGREE">
    학력별 <i class="bi bi-chevron-down"></i>
  </button>
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>학력 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      <div class="filter-options">
        <%-- JS가 /api/codes/DEGREE 를 호출하여 이 영역을 채웁니다. --%>
      </div>
    </div>
  </div>
</div>

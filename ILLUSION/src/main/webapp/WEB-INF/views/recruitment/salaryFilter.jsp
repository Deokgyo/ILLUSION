<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<div class="filter-dropdown single-level-filter" id="salary-filter-group">
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn" 
          data-filter-type="salary" data-group-id="SALARY">
    급여별 <i class="bi bi-chevron-down"></i>
  </button>
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>급여 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      <div class="filter-options">
        <%-- JS가 /api/codes/SALARY 를 호출하여 이 영역을 채웁니다. --%>
      </div>
    </div>
  </div>
</div>

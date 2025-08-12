<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 모든 필터가 이 구조를 따릅니다. --%>
<div class="filter-dropdown" data-filter-type="degree" data-group-id="degree">
  <%-- 1. 공통 클래스 사용 --%>
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn">
    학력별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <%-- 2. 공통 클래스 사용 --%>
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>학력 선택</span>
        <%-- 3. 공통 클래스 사용 --%>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      <div class="filter-options" data-target="options-list">
      
      </div>
    </div>
  </div>
</div>


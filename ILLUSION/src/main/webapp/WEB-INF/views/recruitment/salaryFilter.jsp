<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 모든 필터가 이 구조를 따릅니다. --%>
<div class="filter-dropdown" data-filter-type="salary">
  <%-- 1. 공통 클래스 사용 --%>
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn">
    급여별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <%-- 2. 공통 클래스 사용 --%>
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>급여 선택</span>
        <%-- 3. 공통 클래스 사용 --%>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      <div class="filter-options">
      
        <%-- 4. 체크박스에 공통 클래스와 data-* 속성 추가 --%>
        
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="~2000" data-text="2천만원 이하"> 2천만원 이하
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="2000-3000" data-text="2천~3천만원"> 2천~3천만원
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="3000-4000" data-text="3천~4천만원"> 3천~4천만원
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="4000-5000" data-text="4천~5천만원"> 4천~5천만원
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="5000-6000" data-text="5천~6천만원"> 5천~6천만원
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="salary" value="6000~" data-text="6천만원 이상"> 6천만원 이상
        </label>    
        
        <%-- (이하 다른 옵션들) --%>
      </div>
    </div>
  </div>
</div>


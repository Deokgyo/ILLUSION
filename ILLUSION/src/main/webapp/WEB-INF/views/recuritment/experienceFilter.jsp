<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 모든 필터가 이 구조를 따릅니다. --%>
<div class="filter-dropdown" data-filter-type="salary">
  <%-- 1. 공통 클래스 사용 --%>
  <button type="button" class="btn btn-outline-secondary toggle-filter-btn">
    경력별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <%-- 2. 공통 클래스 사용 --%>
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>경력 선택</span>
        <%-- 3. 공통 클래스 사용 --%>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      <div class="filter-options">
      
        <%-- 4. 체크박스에 공통 클래스와 data-* 속성 추가 --%>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience1" data-text="신입"> 신입
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience2" data-text="1~3년차"> 1~3년차
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience3" data-text="4~7년차"> 4~7년차
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience4" data-text="8+년차"> 8+년차
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience5" data-text="경력무관"> 경력무관
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience6" data-text="인턴"> 인턴
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="experience" value="experience6" data-text="계약직"> 계약직
        </label>    
        <%-- (이하 다른 옵션들) --%>
      </div>
    </div>
  </div>
</div>


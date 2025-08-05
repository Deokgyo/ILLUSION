<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 모든 필터가 이 구조를 따릅니다. --%>
<div class="filter-dropdown" data-filter-type="salary">
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
      <div class="filter-options">
      
        <%-- 4. 체크박스에 공통 클래스와 data-* 속성 추가 --%>
        <label>
          <input type="checkbox" class="filter-checkbox" name="degree" value="degree1" data-text="고등학교 졸업"> 고등학교 졸업
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="degree" value="degree2" data-text="전문대 졸업"> 전문대 졸업
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="degree" value="degree3" data-text="대학교 졸업"> 대학교 졸업
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="degree" value="degree4" data-text="석사 학위"> 석사 학위
        </label>
        <label>
          <input type="checkbox" class="filter-checkbox" name="degree" value="degree5" data-text="박사 학위"> 박사 학위
        </label>     
        
        <%-- (이하 다른 옵션들) --%>
      </div>
    </div>
  </div>
</div>


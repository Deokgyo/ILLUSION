<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="salary-dropdown">
  <button type="button" class="btn btn-outline-secondary toggle-salary-btn">
    경력별 <i class="bi bi-chevron-down"></i>
  </button>
  <div class="salary-dropdown-menu hidden">
    <div class="salary-filter">
      <div class="salary-header">
        <span>경력 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger salary-reset-btn">초기화</button>
      </div>
      <div class="salary-options">
        <label><input type="checkbox" name="degree" value="degree1"> 신입</label>
        <label><input type="checkbox" name="degree" value="degree2"> 1~3년차</label>
        <label><input type="checkbox" name="degree" value="degree3"> 4~7년차</label>
        <label><input type="checkbox" name="degree" value="degree4"> 8+년차</label>
        <label><input type="checkbox" name="degree" value="degree5"> 경력무관</label>
        <label><input type="checkbox" name="degree" value="degree6"> 인턴</label>
        <label><input type="checkbox" name="degree" value="degree7"> 계약직</label>
      </div>
    </div>
  </div>
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="salary-dropdown">
  <button type="button" class="btn btn-outline-secondary toggle-salary-btn">
    학력별 <i class="bi bi-chevron-down"></i>
  </button>
  <div class="salary-dropdown-menu hidden">
    <div class="salary-filter">
      <div class="salary-header">
        <span>학력 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger salary-reset-btn">초기화</button>
      </div>
      <div class="salary-options">
        <label><input type="checkbox" name="experience" value="experience1"> 고등학교 졸업</label>
        <label><input type="checkbox" name="experience" value="experience2"> 전문대 졸업</label>
        <label><input type="checkbox" name="experience" value="experience3"> 대학교 졸업</label>
        <label><input type="checkbox" name="experience" value="experience4"> 석사 학위</label>
        <label><input type="checkbox" name="experience" value="experience5"> 박사 학위</label>
      </div>
    </div>
  </div>
</div>
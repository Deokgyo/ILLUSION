<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="salary-dropdown">
  <button type="button" class="btn btn-outline-secondary toggle-salary-btn">
    급여별 <i class="bi bi-chevron-down"></i>
  </button>
  <div class="salary-dropdown-menu hidden">
    <div class="salary-filter">
      <div class="salary-header">
        <span>급여 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger salary-reset-btn">초기화</button>
      </div>
      <div class="salary-options">
        <label><input type="checkbox" name="salary" value="~2000"> 2천만원 이하</label>
        <label><input type="checkbox" name="salary" value="2000-3000"> 2천~3천만원</label>
        <label><input type="checkbox" name="salary" value="3000-4000"> 3천~4천만원</label>
        <label><input type="checkbox" name="salary" value="4000-5000"> 4천~5천만원</label>
        <label><input type="checkbox" name="salary" value="5000-6000"> 5천~6천만원</label>
        <label><input type="checkbox" name="salary" value="6000~"> 6천만원 이상</label>
      </div>
    </div>
  </div>
</div>
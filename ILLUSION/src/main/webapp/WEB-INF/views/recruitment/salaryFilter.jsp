<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="filter-dropdown single-level-filter" id="salary-filter-group">
  
  <button type="button" class="toggle-filter-btn"
          data-filter-type="salary" data-group-id="SALARY">
    급여별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>급여 선택</span>
        <button type="button" class="filter-reset-btn">초기화</button>
      </div>
      
      <div class="filter-options">
        
        <c:forEach var="sal" items="${filterOptions.SALARY}">
            <label>
              <%-- name="experience"는 filterType(experience) DTO 필드와 일치해야 합니다. --%>
              <input type="checkbox" class="filter-checkbox" name="salary" 
                     value="${sal.code}" data-text="${sal.code_name}">
              ${sal.code_name}
            </label>
        </c:forEach>
        
      </div>
    </div>
  </div>
</div>
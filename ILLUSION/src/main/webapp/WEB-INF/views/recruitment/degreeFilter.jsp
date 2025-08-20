<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="filter-dropdown single-level-filter" id="experience-filter-group">
  
  <button type="button" class="toggle-filter-btn"
          data-filter-type="degree" data-group-id="DEGREE">
    학력별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>학력 선택</span>
        <button type="button" class="filter-reset-btn">초기화</button>
      </div>
      
      <div class="filter-options">
        
        <c:forEach var="deg" items="${filterOptions.DEGREE}">
            <label>
              <%-- name="experience"는 filterType(experience) DTO 필드와 일치해야 합니다. --%>
              <input type="checkbox" class="filter-checkbox" name="degree" 
                     value="${deg.code}" data-text="${deg.code_name}">
              ${deg.code_name}
            </label>
        </c:forEach>
        
      </div>
    </div>
  </div>
</div>
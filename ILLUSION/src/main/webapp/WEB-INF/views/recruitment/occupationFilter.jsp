<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<div class="filter-dropdown hierarchical-filter" id="occupation-filter-group">
  
  <button type="button" class="toggle-filter-btn">
    직무별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <div class="filter-dropdown-menu occupation-filter-menu hidden">
    <div class="occupation-panel-wrapper">
    
      <%-- 왼쪽 패널 (직무 대분류) --%>
      <div class="region-panel-left">
        <ul class="major-list major-region-list">
          <c:forEach var="occ_major" items="${filterOptions.OCCUPATION}" varStatus="status">
            <li class="major-item major-region-item" data-code="${occ_major.code}">
              ${occ_major.code_name}
            </li>
            
          </c:forEach>
          
        </ul>
      </div>

      <%-- 오른쪽 패널 (직무 소분류) --%>
      <div class="region-panel-right">
        <div class="filter-header">
          <label><input type="checkbox" class="check-all"> 전체</label>
          <button type="button" class="filter-reset-btn">초기화</button>
        </div>
        <div class="filter-options sub-list">
          <%-- 이 영역은 JavaScript가 AJAX로 채우므로 변경할 필요 없습니다. --%>
        </div>
      </div>
      
    </div>
  </div>
</div>
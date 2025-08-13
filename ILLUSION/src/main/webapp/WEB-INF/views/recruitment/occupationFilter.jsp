<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 
  [전체 구조]
  - 'location'과 관련된 모든 명칭을 'occupation'으로 변경합니다.
  - CSS 클래스는 filterEvent.css에 정의된 것을 따릅니다.
  - JavaScript 연동을 위한 공통 클래스와 고유 ID를 부여합니다.
--%>
<div class="filter-dropdown hierarchical-filter" id="occupation-filter-group">
  
  <button type="button" class="toggle-filter-btn">
    직무별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <%-- 
    [참고]
    - CSS에 .occupation-filter-menu 라는 별도 스타일이 없다면 .location-filter-menu를
      그대로 사용해도 레이아웃이 동일하게 적용됩니다. 여기서는 의미를 명확히 하기 위해 변경합니다.
  --%>
  <div class="filter-dropdown-menu occupation-filter-menu hidden"> <%-- CSS 클래스명 변경 --%>
    
    <%-- 2단 패널 전체를 감싸는 래퍼 --%>
    <div class="occupation-panel-wrapper"> <%-- CSS 클래스명 변경 --%>
    
      <%-- 왼쪽 패널 (직무 대분류) --%>
      <div class="region-panel-left"> <%-- CSS의 왼쪽 패널 스타일 재사용 --%>
        <%-- JS가 대분류 목록과 아이템을 식별하기 위한 공통 class 추가 --%>
        <ul class="major-list major-region-list"> <%-- CSS의 ul 스타일 재사용 --%>
          <%-- 
            - data-code 값을 실제 직무 대분류 공통 코드로 변경
            - 텍스트도 직무 대분류 이름으로 변경
          --%>
        <li class="major-item major-region-item active" data-code="JOB010">IT·인터넷·데이터</li>
        <li class="major-item major-region-item" data-code="JOB020">경영·사무·금융</li>
        <li class="major-item major-region-item" data-code="JOB030">마케팅·광고·홍보</li>
        <li class="major-item major-region-item" data-code="JOB040">디자인</li>
        <li class="major-item major-region-item" data-code="JOB050">영업·고객서비스·리테일</li>
        <li class="major-item major-region-item" data-code="JOB060">생산·제조·엔지니어링</li>
        <li class="major-item major-region-item" data-code="JOB070">미디어·문화·예술</li>
        <li class="major-item major-region-item" data-code="JOB080">전문직·특수직</li>
        <li class="major-item major-region-item" data-code="JOB090">교육</li>
        <li class="major-item major-region-item" data-code="JOB100">의료·바이오</li>
        <li class="major-item major-region-item" data-code="JOB110">건설·건축</li>
          <%-- (기타 직무 대분류) --%>
        </ul>
      </div>

      <%-- 오른쪽 패널 (직무 소분류) --%>
      <div class="region-panel-right"> <%-- CSS의 오른쪽 패널 스타일 재사용 --%>
        <div class="filter-header">
          <%-- JS가 '전체 선택' 체크박스를 식별하기 위한 공통 class 추가 --%>
          <label><input type="checkbox" class="check-all"> 전체</label>
          <button type="button" class="filter-reset-btn">초기화</button>
        </div>
        
        <%-- JS가 이 영역을 소분류 목록 영역으로 식별 & CSS 스타일 적용 --%>
        <div class="filter-options sub-list">
          <%-- 이 영역은 비어있으며, JavaScript가 AJAX로 데이터를 받아 동적으로 채웁니다. --%>
        </div>
      </div>
      
    </div>
  </div>
</div>
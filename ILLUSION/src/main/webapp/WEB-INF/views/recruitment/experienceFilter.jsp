<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%-- 
  [1. 필터 그룹 식별자 설정]
  - class="single-level-filter": JS가 '단일 목록 필터'임을 인식하는 공통 클래스
  - id="experience-filter-group": 이 필터 그룹의 고유 ID
--%>
<div class="filter-dropdown single-level-filter" id="experience-filter-group">
  
  <%-- 
    [2. data-* 속성 설정]
    - data-filter-type="experience": JS가 체크박스의 name="experience"를 만드는 데 사용
    - data-group-id="EXPERIENCE": JS가 API 호출 시 /api/codes/EXPERIENCE URL을 만드는 데 사용
  --%>
  <button type-="button" class="btn btn-outline-secondary toggle-filter-btn" 
          data-filter-type="experience" data-group-id="EXPERIENCE">
    경력별 <i class="bi bi-chevron-down"></i>
  </button>
  
  <div class="filter-dropdown-menu hidden">
    <div class="filter-inner">
      <div class="filter-header">
        <span>경력 선택</span>
        <button type="button" class="btn btn-sm btn-outline-danger filter-reset-btn">초기화</button>
      </div>
      
      <%-- 
        [3. 옵션 목록 영역]
        - class="filter-options": 체크박스가 들어갈 영역을 지정하는 공통 클래스
        - 이 영역은 처음에는 비어있습니다. JavaScript가 AJAX로 데이터를 가져와 동적으로 채웁니다.
      --%>
      <div class="filter-options">
        <%-- JavaScript가 이 곳에 DB에서 가져온 경력 목록 체크박스를 생성합니다. --%>
      </div>
    </div>
  </div>
</div>
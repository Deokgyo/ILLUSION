<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이 파일은 일반적으로 body 태그 맨 아래, </body> 바로 위에 위치시킵니다. --%>

<%-- 1. 모달 배경(오버레이) --%>
<div class="modal-overlay hidden" id="apply-modal-overlay">

  <%-- 2. 모달 컨텐츠 --%>
  <div class="modal-content">

    <%-- 3. 닫기 버튼 --%>
    <button class="modal-close-btn" aria-label="닫기">×</button>
    
    <h2 class="modal-title">입사지원</h2>

    <%-- 4. 이력서 선택 섹션 --%>
    <section class="modal-section">
      <h3>이력서 선택 (필수)</h3>
      <div class="options-wrapper">
        <label class="option-label">
          <input type="checkbox" name="resume" value="1"> 성실한 개발자
        </label>
        <label class="option-label">
          <input type="checkbox" name="resume" value="2"> 능력있는 개발자
        </label>
      </div>
    </section>

    <%-- 5. 자기소개서 선택 섹션 --%>
    <section class="modal-section">
      <h3>자기소개서 선택 (선택)</h3>
      <div class="options-wrapper">
        <label class="option-label">
          <input type="checkbox" name="cover_letter" value="1"> 항상 노력하는 개발자가 되겠습니다
        </label>
        <label class="option-label">
          <input type="checkbox" name="cover_letter" value="2"> 능력있는 개발자가 되겠습니다
        </label>
      </div>
    </section>

    <%-- 6. 첨부파일 섹션 --%>
    <section class="modal-section">
      <h3>첨부파일 (선택)</h3>
      <label class="file-drop-area" for="file-upload">
        <div class="file-info-text">
          <i class="bi bi-folder2-open"></i> <%-- 부트스트랩 아이콘 예시 --%>
          <p>파일을 끌어다 놓거나 클릭하여 업로드 하세요<br><span>(10MB 이하의 파일만 업로드 가능)</span></p>
        </div>
        <div class="file-name-display"></div>
      </label>
      <input type="file" id="file-upload" class="hidden">
      
      <%-- 업로드된 파일 표시 (JS로 제어) --%>
      <div class="uploaded-file-list">
        <!-- 예시: <div class="file-item">포트폴리오.pdf <button>x</button></div> -->
      </div>
    </section>

    <%-- 7. 최종 지원 버튼 --%>
    <button class="modal-submit-btn">입사지원</button>

  </div>
</div>
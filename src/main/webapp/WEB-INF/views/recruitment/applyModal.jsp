<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 이 파일은 일반적으로 body 태그 맨 아래, </body> 바로 위에 위치시킵니다. --%>

<%-- 1. 모달 배경(오버레이) --%>
<div class="modal-overlay hidden" id="apply-modal-overlay">

  <%-- 2. 모달 컨텐츠 --%>
  <div class="modal-content">

    <%-- 3. 닫기 버튼 --%>
    <button class="modal-close-btn" aria-label="닫기">×</button>
    
    <h2 class="modal-title">입사지원</h2>

    <%-- 4. 이력서 선택 섹션 --%>
    <form action="apply" method="post" enctype="multipart/form-data">
		    <section class="modal-section">
		      <h3>이력서 선택 (필수)</h3>
		      <div class="options-wrapper">
	    		<c:forEach var="a" items="${resumeList}">
			        <label class="option-label">
			        	<input type="radio" name="resume_idx" value="${a.resume_idx }" style="display:none;">${a.resume_title }
			        </label>
		        </c:forEach>
		      </div>
		    </section>
	
		    <%-- 5. 자기소개서 선택 섹션 --%>
		    <section class="modal-section">
		      <h3>자기소개서 선택 (선택)</h3>
		      <div class="options-wrapper">
		      <c:forEach var="a" items="${clList}">
		        <label class="option-label">
		          <input type="checkbox" name="cl_idx" value="${a.cl_idx }" style="display:none;"> ${a.cl_title }
		        </label>
			  </c:forEach>	        
		      </div>
		    </section>
	
	    <%-- 6. 첨부파일 섹션 --%>
		    <section class="modal-section">
		      <h3>첨부파일 (선택)</h3>
		      <label class="file-drop-area" for="file-upload">
		        <div class="file-info-text">
		          <i class="bi bi-folder2-open"></i> 
		          <p>파일을 업로드 하세요</p>
		        </div>
<!-- 			    업로드된 파일 표시 (JS로 제어) -->
			    <div class="uploaded-file-list">
			    </div>
		      </label>
		      <input type="file" name="apply_file" id="file-upload" class="hidden">
	      
		    </section>
		    
		    
		    <input type="hidden" name="member_idx" value="${memberIdx}">
		    <input type="hidden" name="is_viewed" value="BOL002">
		    <input type="hidden" name="apply_status" value="APS001">
		    <input type="hidden" name="recruit_idx" value="${param.recruit_idx}">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	    <%-- 7. 최종 지원 버튼 --%>
	    <button type="submit" class="modal-submit-btn">입사지원</button>
    </form>

  </div>
</div>
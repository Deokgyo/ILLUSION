<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======================================
     회원 상태 변경 모달 프래그먼트(조각)
    ======================================= --%>

<!-- 모달 배경 (어두운 반투명 배경) -->
<div class="modal-backdrop hidden" id="edit-modal-backdrop">

    <!-- 실제 모달 창 -->
    <div class="modal-window">
        <form action="updateMemberStatusAndType" method="POST">
	        <!-- 모달 헤더 -->
	        <div class="modal-header">
	            <h3 class="modal-title">회원 상태 변경</h3>
	            <button class="close-btn" type="button" title="닫기">×</button>
	        </div>
	
	        <!-- 모달 본문 (폼) -->
	        <div class="modal-body">
	            <div class="form-group">
	                <label for="modal-user-id">변경 대상 아이디</label>
	                <input type="text" id="modal-user-id" value="현재 아이디" disabled>
	            </div>
	            <div class="form-group">
	                <label for="modal-user-type" name="member_type_code">회원유형</label>
	                <select id="modal-user-type">
	                	<c:forEach var="mt" items="${memberType }">
	                		<option value="${mt.code }">${mt.code_name }</option>
	                	</c:forEach>
	                </select>
	            </div>
	            <div class="form-group">
	                <label for="modal-user-status" name="member_status_code">회원 상태</label>
	                <select id="modal-user-status">
	                	<c:forEach var="ms" items="${memberStatus }">
		                    <option value="${ms.code }">${ms.code_name }</option>
	                	</c:forEach>
	                </select>
	            </div>
	        </div>
	
	        <!-- 모달 푸터 (액션 버튼) -->
	        <div class="modal-footer">
	            <button class="btn btn-cancel" type="button">취소</button>
	            <button type="submit" class="btn btn-yellow" type="button">저장</button>
	        </div>
        	
        	<input type="hidden" id="modal-member-idx" name="member_idx">
        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
        
    </div>
</div>
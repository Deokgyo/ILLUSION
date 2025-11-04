<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 공통코드 수정 모달 -->
<div class="modal-backdrop hidden" id="editModal">
    <div class="modal-window">
        <div class="modal-header">
            <h2 class="modal-title">공통코드 수정</h2>
            <button class="close-btn" onclick="closeModal()">&times;</button>
        </div>
        <form id="editForm" action="comcodeModify" method="post">
            <div class="form-group">
                <label for="codeGroupId">코드그룹 ID</label>
                <input type="text" id="codeGroupId" name="code_group_id" readonly>
            </div>
            <div class="form-group">
                <label for="groupName">그룹명</label>
                <input type="text" id="groupName" name="group_name" required>
            </div>
            <div class="form-group">
                <label for="code">공통코드</label>
                <input type="text" id="code" name="code" required>
            </div>
            <div class="form-group">
                <label for="codeName">공통코드명</label>
                <input type="text" id="codeName" name="code_name" required>
            </div>
            <div class="form-group">
                <label for="description">설명</label>
                <input type="text" id="description" name="description" required>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-cancel" onclick="closeModal()">취소</button>
                <button type="submit" class="btn btn-save">수정 완료</button>
            </div>
            <input type="hidden" id="original_code" name="original_code">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
    </div>
</div>
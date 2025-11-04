<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="confirm-modal" class="modal-overlay">
    <div class="modal-content">
        <button class="close-modal-btn btn-no">×</button>
        <div class="modal-header">
            <h4><i class='far fa-gem' style= "color : var(--main-color)"></i> 토큰 30개 차감!</h4>
        </div>
        <p>면접 예상 질문을 생성하시겠습니까?</p>
        <div class="modal-buttons">
            <button class="btn btn-yellow btn-no">아니요</button>
            <button id="confirm-yes-btn" class="btn btn-yellow">네</button>
        </div>
    </div>
</div>
   
<!-- '토큰 부족' 모달 (이미 표준 구조) -->
<div id="token-modal" class="modal-overlay">
    <div class="modal-content">
        <button class="close-modal-btn btn-no">×</button>
        <div class="modal-header">
            <div class="icon"><i class="fa-solid fa-circle-info"></i></div>
            <h4>토큰이 부족합니다</h4>
        </div>
        <p>결제페이지로 이동하시겠습니까?</p>
        <div class="modal-buttons">
            <button class="btn btn-yellow btn-no">아니요</button>
            <a href="tokenpay" class="btn btn-yellow">네</a>
        </div>
    </div>
</div>
   
<!-- '로딩' 모달 -->
<div id="loading-overlay" class="modal-overlay">
    <div class="modal-content text-center">
        <div class="spinner-border text-warning mb-3"></div>
        <h4>면접 예상 질문을 생성 중 입니다</h4>
        <p>AI가 예리한 질문을 만들기 위해 노력하고 있어요!</p>
    </div>
</div>
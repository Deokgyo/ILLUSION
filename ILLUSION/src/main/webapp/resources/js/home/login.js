/*===========================================================
			함수 실행 부 
============================================================*/
$(function() {
	// 함수 선언부 [1] 참고, 회원 타입 선택
	$('.type').on('click', addActive);
	

}); // 도큐먼트 레디 

/*===========================================================
			함수 선언 부
============================================================*/	
	
	//[1] tab 클릭시  active 클래스 추가 + 소셜 로그인 제거 및 추가 
	function addActive() {
		$('li').removeClass('active');
		$(this).addClass('active');
		 
		if ($(this).html().trim() == '기업 회원') {// 기업 회원인지 판단
			removeSocalLogin();
		} else {
			addSocialLogin();
		}
	}
	
	// 1-1) 소셜 로그인 제거 
	function removeSocalLogin() {
		$('.social-login').remove();
		$('.social-logo').remove();
	}
	
	// 1-2) 소셜 로그인 추가 
	function addSocialLogin() {
  		const socialHTML = 
			`<div class="social-login">
		      <div class="mini-divider"></div>
		      <span>소셜 계정으로 로그인</span>
		      <div class="mini-divider"></div>
		    </div>
		    <ul class="social-logo">
		      <li><a href="naver"><img src="./resources/image/naverLogin.png" alt=""></a></li>
		      <li><a href="kakao"><img src="./resources/image/kakaoLogin.png" alt=""></a></li>
		      <li><a href="google"><img src="./resources/image/googleLogin.png" alt=""></a></li>
		    </ul>`;

	 	 $('.box-right').append(socialHTML);
	}
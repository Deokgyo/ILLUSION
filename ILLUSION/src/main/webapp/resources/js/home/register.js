$(document).ready(function() {
	// 이용약관 전체 동의
	$('.tab-btn').on('click', function() {
		$('.tab-btn').removeClass('active');  // 모든 탭에서 active 제거
		$(this).addClass('active');          // 클릭한 탭에 active 추가
	});

	// DOM이 준비된 후 실행
	$(function() {
		var $agreeAll = $('#agree-all');
		var $checkboxes = $('.agree-each');

		// 전체 동의 클릭 시, 하위 약관 모두 체크/해제
		$agreeAll.on('change', function() {
			$checkboxes.prop('checked', this.checked);
		});

		// 개별 약관 체크 시, 모두 체크됐으면 전체 동의도 체크
		$checkboxes.on('change', function() {
			$agreeAll.prop('checked', $checkboxes.length === $checkboxes.filter(':checked').length);
		});
	});

	// 기업회원 클릭 시 사업자등록번호 띄우기
	$(function() {
		$('#companyTab').on('click', function() {
			$('#personalTab').removeClass('selected');
			$(this).addClass('selected');
			$('#companyBox').fadeIn(120);
		});

		$('#personalTab').on('click', function() {
			$('#companyTab').removeClass('selected');
			$(this).addClass('selected');
			$('#companyBox').fadeOut(120);
		});
	});

	// 아이디 유효성 체크
	$(function() {

		let isCheckId = false;
		let isCheckPass = false;
		let isCheckPass2 = false;

		// 아이디 체크
		$("#userid").on('keyup', checkUserId);

		// 비밀번호 유효성
		$("#userpw").on('keyup', checkUserPass);
		$("#userpw2").on('keyup', checkUserPass2);

//		$('form').on('submit', checkSubmit);   // 최종 가입 버튼 클릭 이벤트

		function checkUserId() {
			let id = $("#userid").val().trim()
			if (id == "") {
				// 입력값이 없으면 메시지 초기화
				$("#UserIdSuccess").text("");
				isCheckId = false;
				return;
			}
			const regex = /^[A-Za-z](?=.*[0-9])(?=.*[?!@])(?=.*[A-Za-z])[A-Za-z0-9?!@]{3,19}$/; // 영문, 숫자, 특수문자 모두 포함
			///^[A-Za-z](?=.*[0-9?!@])[A-Za-z0-9?!@]{3,19}$/; //숫자 or 특수문자가 무조건 들어가야함
			// /^[A-Za-z][A-Za-z0-9?!@]{3,19}$/; // 꼭 포함은 아니고 허용

			if (regex.exec(id)) {
				$("#UserIdSuccess").text('사용 가능한 아이디');
				$("#UserIdSuccess").css('color', 'blue');
				isCheckId = true;

				duplicateId();

			} else {
				$("#UserIdSuccess").text('사용 불가능한 아이디');
				$("#UserIdSuccess").css('color', 'red');
				isCheckId = false;
			}

		}

		//비밀번호 유효성
		function checkUserPass() {
			let passwd = $("#userpw").val();


			if (passwd == null || passwd == "") {
				//alert(passwd);
				$("#userPwSuccess").text("");
			} else {
				// 패스워드 조합 및 길이 규칙: 영문자, 숫자, 특수문자(!@#$%) 8 ~ 16자
				let lengthRegex = /^[A-Za-z0-9!@#$%]{7,15}$/;
				if (lengthRegex.exec(passwd)) {

					let count = 0;
					let engUpperRegex = /[A-Z]/;
					let engLowerRegex = /[a-z]/;
					//         let numRegex = /[0-9]/;
					let numRegex = /[\d]/;
					let specRegex = /[!@#$%]/;

					if (engUpperRegex.exec(passwd)) count++;
					if (engLowerRegex.exec(passwd)) count++;
					if (numRegex.exec(passwd)) count++;
					if (specRegex.exec(passwd)) count++;

					switch (count) {
						case 4:
							$("#userPwSuccess").text("안전").css("color", "blue");
							isCheckPass = true;
							break;
						case 3:
							$("#userPwSuccess").text("보통").css("color", "green");
							isCheckPass = true;
							break;
						case 2:
							$("#userPwSuccess").text("위험").css("color", "orange");
							isCheckPass = true;
							break;
						case 1:
							$("#userPwSuccess").text("사용불가").css("color", "red");
							isCheckPass = false;
							break;
					}

				} else {
					$("#userPwSuccess")
						.text("영문자, 숫자, 특수문자(!@#$%) 필수!")
						.css("color", "red");
					isCheckPass = false;
				}

				checkUserPass2();
			}
		}

		function checkUserPass2() {
			let passwd = $("#userpw").val();
			let passwd2 = $("#userpw2").val();

			if (passwd2 == null || passwd2 == "") {
				$("#userPwSuccess2").text("");
			} else {
				if (passwd == passwd2) {
					$("#userPwSuccess2").text("비밀번호 일치").css("color", "blue");
					isCheckPass2 = true;
				} else {
					$("#userPwSuccess2").text("비밀번호 불일치").css("color", "red");
					isCheckPass2 = false;
				}
			}
		}
	}); // 유효성

	$(document).ready(function() {

		let isEmailVerified = false; // 이메일 인증 성공 여부 저장 변수

		// [1] 인증번호 발송 버튼 클릭 시 이벤트
		$("#email-btn").click(function() {
			const emailVal = $("#email").val().trim();
			if (emailVal === "") {
				alert("이메일을 입력하세요.");
				return;
			}

			// 이메일 인증번호 발송 요청
			$.ajax({
				type: "POST",
				url: "/member/email-auth",
				data: JSON.stringify({ member_email: emailVal }),
				contentType: "application/json",
				success: function(res) {
					if (res.result) {
						alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
					} else {
						alert("인증번호 발송에 실패했습니다.");
					}
				},
				error: function() {
					alert("서버와 통신 중 오류가 발생했습니다.");
				}
			});
		});

		// [2] 인증번호 확인 버튼 클릭 시 이벤트
		$("#checkAuthBtn").click(function() {
			const emailVal = $("#email").val().trim();
			const codeVal = $("#emailcode").val().trim();

			if (emailVal === "" || codeVal === "") {
				alert("이메일과 인증번호를 모두 입력하세요.");
				return;
			}

			// 인증번호 검증 요청
			$.ajax({
				type: "POST",
				url: "/member/email-auth-check",
				data: JSON.stringify({ email: emailVal, auth_code: codeVal }),
				contentType: "application/json",
				success: function(res) {
					if (res.result) {
						alert("이메일 인증 성공!");
						isEmailVerified = true;
					} else {
						alert("인증번호가 맞지 않거나 만료되었습니다.");
						isEmailVerified = false;
					}
				},
				error: function() {
					alert("서버와 통신 중 오류가 발생했습니다.");
				}
			});
		});
	});

});

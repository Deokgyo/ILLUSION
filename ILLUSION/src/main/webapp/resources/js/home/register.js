$(document).ready(function() {
	
	
	let isCheckId = false;
	let isCheckPass = false;
	let isCheckPass2 = false;
	let isEmailVerified = false; // 이메일 인증 성공 여부 저장 변수
	var isBusinessNumberVerified = false;
	
	// 이용약관 전체 동의
	$('.tab-btn').on('click', function() {
		$('.tab-btn').removeClass('active');  // 모든 탭에서 active 제거
		$(this).addClass('active');          // 클릭한 탭에 active 추가
	});
	// DOM이 준비된 후 실행
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

	// 회원가입 유효성 체크
	const $input = $('#userid');
	const $msg = $('#UserIdSuccess');
	let debounceTimeout;

	// 아이디 유효성 체크
	$("#userid").on('keyup', UserIdSuccess);

	function UserIdSuccess() {
		clearTimeout(debounceTimeout);
		const memberId = $input.val().trim();

		debounceTimeout = setTimeout(function() {
			if (memberId === "") {
				$msg.text('');
				isCheckId = false;
				return;
			}
			const regex = /^[A-Za-z](?=.*[0-9_])[A-Za-z0-9_]{3,19}$/;
			///^[A-Za-z](?=.*[0-9])(?=.*[?!@])(?=.*[A-Za-z])[A-Za-z0-9?!@]{3,19}$/;  영문, 숫자, 특수문자 모두 포함
			// /^[A-Za-z][A-Za-z0-9?!@]{3,19}$/; // 꼭 포함은 아니고 허용

			if (memberId.length < 4) {
				$msg.text('4자 이상 입력하세요.').css('color', 'gray');
				isCheckId = false;
				return;
			} if (!regex.test(memberId)) {
				$msg.text('사용 불가능한 아이디').css('color', 'red');
				isCheckId = false;
				return;
			}

			$.ajax({
				url: 'checkIdCount',
				type: 'GET',
				data: { member_id: memberId },
				success: function(data) {
					if (data.duplicate) {
						$msg.text('이미 존재하는 아이디입니다.').css('color', 'red');
						isCheckId = false;
					} else {
						$msg.text('사용 가능한 아이디입니다.').css('color', 'blue');
						isCheckId = true;
					}
				},
				error: function() {
					$msg.text('오류가 발생했습니다.').css('color', 'gray');
					isCheckId = false;
				}
			});

		}, 300); // 300ms 딜레이
	};

	// 비밀번호 유효성
	$("#userpw").on('keyup', checkUserPass);// 비밀번호 유효성
	$("#userpw2").on('keyup', checkUserPass2);// 비밀번호 확인

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


	// 이메일 인증
	$("#email-btn").click(function() {
		const emailVal = $("#email").val().trim();
		const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // 이메일 정규식
		
		if (emailVal === "") {
	        alert("이메일을 입력하세요.");
	        return;
   		}
   		if (!emailRegex.test(emailVal)) {
	        alert("올바른 이메일 형식이 아닙니다.");
	        return;
   		}
   		
   		$("#email-btn").prop("disabled", true); // 버튼 비활성화

		$.ajax({
			type: "POST",
			url: "email-auth",
			data: JSON.stringify({ member_email: emailVal }),
			contentType: "application/json",
			success: function(res) {
				if (res.result) {
					alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
				} else {
					alert("인증번호 발송에 실패했습니다.");
				}
				 $("#email-btn").prop("disabled", false);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				alert("서버와 통신 중 오류가 발생했습니다.");
			}
		});
	});

	$("#checkAuthBtn").click(function() {
		const emailVal = $("#email").val().trim();
		const codeVal = $("#emailcode").val().trim();

		if (emailVal === "" || codeVal === "") {
			alert("이메일과 인증번호를 모두 입력하세요.");
			return;
		}

		$.ajax({
			type: "POST",
			url: "email-auth-check",
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
	
	//이메일 중복 체크
	function checkEmailDuplicate(email) {
	    return $.ajax({
	        url: 'email-check',
	        type: 'GET',
	        data: { email: email },
	        dataType: 'json'
	    });
	}
	
	$('#email').on('blur', function() {
		var email = $(this).val().trim();
		if (email === '') return;  // 빈값일 경우 검사 스킵

		checkEmailDuplicate(email).done(function(response) {
			if (response.exists) {
				alert('이미 등록된 이메일입니다.');
				// 아이디 중복 등 처리 (예: 입력란 강조, 제출 버튼 비활성화 등)
				$('#register-btn').prop('disabled', true);
			} else {
				// 중복 아니면 버튼 활성화
				$('#register-btn').prop('disabled', false);
			}
		}).fail(function() {
			alert('서버와 통신 중 오류가 발생했습니다.');
		});
	});
	
	// 입력값 초기화 함수
	function resetFormInputs() {
		// .signup-form 내부의 모든 input/select/textarea 초기화
		$('.signup-form').find('input[type="text"], input[type="password"], input[type="date"], select, textarea').each(function() {
			$(this).val('');
		});

		 // 유효성 메시지 초기화
		$('#UserIdSuccess, #userPwSuccess, #userPwSuccess2').text('');
	}
	
	// 생년월일 미래x
	$('#birth').on('input change blur', function() {
		var val = $(this).val();
		if (!val) return;

		// YYYY-MM-DD 정규표현식 검사: 연도는 1900~2099 사이 4자리
		var dateRegex = /^(19|20)\d{2}-\d{2}-\d{2}$/;
		if (!dateRegex.test(val)) {
			alert('생년월일 형식에 맞게 입력해 주세요.');
			$(this).val('');
			$(this).focus();
			return;
		}

		// 날짜 객체 생성
		var date = new Date(val);
		var today = new Date();
		today.setHours(0, 0, 0, 0); // 오늘 0시 기준

		// 미래 날짜 체크
		if (date > today) {
			alert('생년월일을 바르게 입력해 주세요.');
			$(this).val('');
			$(this).focus();
			return;
		}
	});
	// 참조
	$('#member_status').val('MES001'); // 회원상태는 항상 '정상'

	$('#member_type').val('MEM002'); // 기본 회원유형은 '개인회원'

	// 개인회원 기본값 세팅
	$('#company').hide().removeAttr('required');
	$('#companyname').val('').removeAttr('required');
	$('#compdate').hide();
	$('#company_date').val('').removeAttr('required');
	$('#companytypes').hide();
	$('#cotypes').val('').removeAttr('required');

	// 개인회원 클릭 시
	$('#personalTab').on('click', function() {
		$('#member_type').val('MEM002');
		$('#companyTab').removeClass('selected');
		$(this).addClass('selected');
		$('#companyBox').fadeOut(120);
		
		$('.form-row').addClass('personal').removeClass('corporate');
		// 성별, 생년월일 보이기
		$('#gender').show();
		$('#birthHide').show();

		// 기업명 -> 이름으로 라벨 및 placeholder 원복
		$('label[for="username"]').text('이름');
		$('#username').attr('placeholder', '이름을 입력해주세요');

		// 대표자명 숨기기 및 입력란 초기화
		$('#company').hide();
		$('#companyname').val('');

		// 설립일 숨기기 및 입력란 초기화
		$('#compdate').hide();
		$('#comdates').val('');

		// 기업형태 숨기기 및 required 제거
		$('#companytypes').hide();
	});
	
	// 기업회원 클릭 시
	$('#companyTab').on('click', function() {
		$('#member_type').val('MEM003');
		$('#username').attr('name', 'company_name');
		$('#personalTab').removeClass('selected');
		$(this).addClass('selected');
		$('#companyBox').fadeIn(120);
		resetFormInputs();

		$('.form-row').addClass('corporate').removeClass('personal');
		// 생년월일 숨김
		$('#birthHide').hide();
		$('#birth').val('').removeAttr('required');		

		// 이름(개인명) -> 기업명으로 라벨 및 placeholder 변경
		$('label[for="username"]').text('기업명');
		$('#username').attr('placeholder', '기업명을 입력해 주세요').attr('required', 'required');

		// 대표자명 입력란 보이기 및 placeholder 설정
		$('#company').show();
		$('label[for="compname"]').text('대표자명');
		$('#companyname').attr('placeholder', '대표자명을 입력해 주세요').attr('required', 'required');

		// 설립일(ddl) 보이기 및 required 설정
		$('#compdate').show();
		$('#company_date').attr('required', 'required');

		// 기업형태(ddl) 보이기 및 required 설정
		$('#companytypes').show();
		$('#cotypes').attr('required', 'required');
	});


	// 사업자등록번호 인증
	$('#btncompany').click(function() {
		const reg_num = $("#companyNumber").val();
		const regNumRegex = /^\d{10}$/; // 숫자 10자리 정규식[4]

		if (!reg_num) {
			alert('사업자등록번호를 입력해주세요.');
			return false;
		}
		if (!regNumRegex.test(reg_num)) {
	        alert('사업자등록번호는 숫자 10자리를 입력해주세요.');
	        $('#companyNumber').focus();
        	return false;
    }

		$.ajax({
			url: 'checkRecruiterNumber',
			type: 'GET',
			data: { recruiter_number: reg_num }, 
			dataType: 'json', 
			success: function(data) {
				if (data.duplicate) { 
					alert('이미 등록된 사업자등록번호입니다.');
					$('#companyNumber').focus();
					isBusinessNumberVerified = false;
				} else {
					isBusinessNumberVerified = true;
					alert('사업자번호 인증 성공');
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert('서버 오류가 발생했습니다.');
			}
		});
	});


	$('#register-btn').click(function(e) {
	    e.preventDefault();
	    $('#registerForm').submit(); // 폼 submit 이벤트 트리거
	  });
	  
	$("#registerForm").on('submit', function(e) {
		var form = document.getElementById("registerForm");
		
		
		var member_type = $("#member_type").val();
		if (member_type === 'MEM003' && !isBusinessNumberVerified ) {
			alert("사업자등록번호를 인증해주세요");
			return false;
		}

		if (!isCheckId) {
			alert("아이디를 입력해주세요.");
			return false;
		}
		if (!isCheckPass) {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		if (!isCheckPass2) {
			alert("비밀번호 불일치.");
			return false;
		}
		    // HTML5 폼 기본 유효성 검사 수행
		if (!form.checkValidity()) {
			form.reportValidity();
			return false; // 유효하지 않으면 제출 중단
		}
		
		if (!isEmailVerified) {
			alert("이메일 인증을 해주세요.");
			return false;
		}
		
		var $checkbox = $(this).find('input[type="checkbox"][name="member_marketing_agreed"]');
		var $hidden = $(this).find('input[type="hidden"][name="member_marketing_agreed"]');

		if ($checkbox.is(':checked')) {
			// 체크박스 체크 시 hidden input 제거 (중복 전송 방지)
			$hidden.prop('disabled', true);
		} else {
			// 체크 안 할 시 체크박스 value 빈값 처리 (중복 방지)
			$checkbox.prop('disabled', true);
			$hidden.prop('disabled', false);
		}
		 return true;
	});
	
}); //ready


$(document).ready(function() {
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

	// 마케팅 동의
	$('.signup-form').on('submit', function(e) {
		// 체크박스 체크 여부에 따라 히든 필드 제거 또는 유지
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
	});
	// 유효성 체크

	let isCheckId = false;
	let isCheckPass = false;
	let isCheckPass2 = false;

	// 아이디 체크
	$("#userid").on('keyup', checkUserId);

	// 비밀번호 유효성
	$("#userpw").on('keyup', checkUserPass);
	$("#userpw2").on('keyup', checkUserPass2);

	//      $('form').on('submit', checkSubmit);   // 최종 가입 버튼 클릭 이벤트


		function checkUserId() {
			let id = $("#userid").val().trim()
			if (id == "") {
				// 입력값이 없으면 메시지 초기화
				$("#UserIdSuccess").text("");
				isCheckId = false;
				return;
			}
			const regex = /^[A-Za-z](?=.*[0-9?!@])[A-Za-z0-9?!@]{3,19}$/; //숫자 or 특수문자가 무조건 들어가야함
							///^[A-Za-z](?=.*[0-9])(?=.*[?!@])(?=.*[A-Za-z])[A-Za-z0-9?!@]{3,19}$/;  영문, 숫자, 특수문자 모두 포함
							///^[A-Za-z](?=.*[0-9?!@])[A-Za-z0-9?!@]{3,19}$/; //숫자 or 특수문자가 무조건 들어가야함
							// /^[A-Za-z][A-Za-z0-9?!@]{3,19}$/; // 꼭 포함은 아니고 허용
	
			if (regex.exec(id)) {
				$("#UserIdSuccess").text('사용 가능한 아이디');
				$("#UserIdSuccess").css('color', 'blue');
				isCheckId = true;
	
				//				duplicateId();
	
			} else {
				$("#UserIdSuccess").text('사용 불가능한 아이디');
				$("#UserIdSuccess").css('color', 'red');
				isCheckId = false;
			}
	
		}
		
		function duplicateId(){
				
				$.ajax({
					type: "GET",
					url: "checkId",
					dataType: "json",
					data: {
						id: $("#id").val()
					},			
					success: function(res){
						
						$("#UserIdSuccess").text(res.msg);
						$("#UserIdSuccess").css('color', res.color);
						
						if (res == 0) { // 사용가능
							$("#checkIdResult").text('사용 가능한 아이디');
							$("#checkIdResult").css('color', 'blue');
						} else { // 사용불가
							$("#checkIdResult").text('사용 불가능한 아이디(아이디 중복)');
							$("#checkIdResult").css('color', 'red');
						}
								},
					error: function(xhr, textStatus, errorThrown){
						debugger;
					}
				})
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
	//
	//      function checkSubmit() {
	//
	//         if (!checkUserId) {
	//            alert("아이디를 입력해주세요");
	//            return false;
	//         }
	//
	//         if (!checkUserPass) {
	//            alert("비밀번호 똑디 안하나?");
	//            return false;
	//         }
	//
	//         if (!checkUserPass2) {
	//            alert("비밀번호 확인 단디 안하나?");
	//            return false;
	//         }
	//
	//         return true;
	//      }


	// 이메일 인증
	let isEmailVerified = false; // 이메일 인증 성공 여부 저장 변수

	$("#email-btn").click(function() {
		const emailVal = $("#email").val().trim();
		if (emailVal === "") {
			alert("이메일을 입력하세요.");
			return;
		}

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
			},
			error: function(jqXHR, textStatus, errorThrown) {
				console.error('Error Details:', jqXHR, textStatus, errorThrown);
				alert("서버와 통신 중 오류가 발생했습니다.");
			}
		});
	});

	$("#checkAuthBtn").click(function() {
		console.log("이메일 인증버튼 클릭됨");

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



	// 참조
	$('#member_status').val('MES001'); // 회원상태는 항상 '정상'

	$('#member_type').val('MEM001'); // 기본 회원유형은 '개인회원'

	$('#companyTab').click(function() {
		$('#member_type').val('MEM003');
	});

	// 개인 회원가입
	$('#registerForm').on('submit', function(e) {
		e.preventDefault();

		const userid = $('#userid').val().trim();
		const userpw = $('#userpw').val().trim();
		const email = $('#email').val().trim();

		if (!userid || !userpw || !email) {
			alert('모든 필드를 입력해주세요.');
			return;
		}

		$.ajax({
			url: 'register', // 절대 경로 혹은 서버에 맞게 수정
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({
				member_id: userid,
				member_pw: userpw,
				member_email: email
			}),
			success: function(response, textStatus, xhr) {
				const redirectUrl = xhr.getResponseHeader('Location');
				if (redirectUrl) {
					alert('회원가입 성공!');
					window.location.href = redirectUrl;
				} else {
					alert('회원가입 성공!');
				}
			},
			error: function(xhr, textStatus, errorThrown) {
				alert('회원가입 실패 또는 서버 오류 발생');
				console.error('Ajax 오류:', errorThrown);
			}
		});
	});

	// 개인회원 기본값 세팅
	$('#company').hide();
	$('#compdate').hide();
	$('#companytypes').hide();
	$('#companytype').removeAttr('required');

	// required 제거
	$('#companyname').removeAttr('required');
	$('#company_date').removeAttr('required');
	$('#compantypes').removeAttr('required');

	// 기업회원 클릭 시
	$('#companyTab').on('click', function() {
		$('#personalTab').removeClass('selected');
		$(this).addClass('selected');
		$('#companyBox').fadeIn(120);

		// 성별, 생년월일 숨김
		$('#gender').hide();
		$('#birth_user').hide();

		// 이름(개인명) -> 기업명으로 라벨 및 placeholder 변경
		$('label[for="username"]').text('기업명');
		$('#username').attr('placeholder', '기업명을 입력해 주세요');

		// 대표자명 입력란 보이기 및 placeholder 설정
		$('#company').show();
		$('label[for="compname"]').text('대표자명');
		$('#companyname').attr('placeholder', '대표자명을 입력해 주세요');

		// 설립일(ddl) 보이기 및 required 설정
		$('#compdate').show();
		$('#comdates').attr('required', 'required');

		// 기업형태(ddl) 보이기 및 required 설정
		$('#companytypes').show();
		$('#compantype').attr('required', 'required');
	});

	// 개인회원 클릭 시
	$('#personalTab').on('click', function() {
		$('#companyTab').removeClass('selected');
		$(this).addClass('selected');
		$('#companyBox').fadeOut(120);

		// 성별, 생년월일 보이기
		$('#gender').show();
		$('#birth_user').show();

		// 기업명 -> 이름으로 라벨 및 placeholder 원복
		$('label[for="username"]').text('이름');
		$('#username').attr('placeholder', '이름을 입력해주세요');

		// 대표자명 숨기기 및 입력란 초기화
		$('#company').hide();
		$('#companyname').removeAttr('required');
		$('#companyname').val('');

		// 설립일 숨기기 및 입력란 초기화
		$('#compdate').hide();
		$('#comdates').removeAttr('required');
		$('#comdates').val('');

		// 기업형태 숨기기 및 required 제거
		$('#companytypes').hide();
		$('#compantype').removeAttr('required');
	});


	// 사업자등록번호 인증
	$('#btncompany').click(function() {
		// 입력된 사업자등록번호에서 숫자만 추출
		reg_num = $("#companyNumber").val(); // 사업자등록번호 변수 저장 

		if (!reg_num) {
			alert('사업자등록번호를 입력해주세요.');
			return false;
		}

		var requestData = {
			"b_no": [reg_num]
		};

		$.ajax({
			url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=m1dPvNAE5sTVzx0%2BBHImtbzvIQt1fB3B%2BkxVM07pZ2BONuAEetIm6niLBMc%2F3rwJ8bUU1bnZFmTcxl8z1stqeQ%3D%3D",  // 서비스키 교체
			type: "POST",
			data: JSON.stringify(requestData),
			dataType: "json",
			contentType: "application/json; charset=UTF-8",
			success: function(result) {
				if (result.match_cnt == "1") {

					var data = result.data[0];

					// 예시 필드명 - 실제 API 문서 확인 필수
					var companyName = data.bizrNm || "";  // 기업명
					var zipcode = data.zip || "";          // 우편번호 (있다면)
					var address1 = data.address || "";     // 주소 예: 도로명 주소
					var address2 = "";                     // 상세주소는 수동 입력 받거나 다른 필드 사용

					// 입력란에 값 채우기
					$('#username').val(companyName);
					$('#zipcode').val(zipcode);
					$('#address1').val(address1);
					$('#address2').val(address2);

					alert('사업자등록번호 인증 성공, 정보가 입력되었습니다.');

				} else {
					alert('등록된 사업자정보가 없습니다.');
				}
			},
			error: function(xhr, status, error) {
				alert('사업자등록번호 조회 중 오류가 발생했습니다.');
				console.error(error);
			}

		});
	});


















}); //ready

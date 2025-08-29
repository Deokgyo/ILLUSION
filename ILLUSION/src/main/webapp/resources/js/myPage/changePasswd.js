	$(document).ready(function() {
	    let isCheckPass = false;
	    let isCheckPass2 = false;

	    $("#userpw").on('keyup', checkUserPass);
	    $("#userpw2").on('keyup', checkUserPass2);

	    function checkUserPass() {
	        let passwd = $("#userpw").val();

	        if (!passwd) {
	            $("#userPwSuccess").text("");
	            isCheckPass = false;
	            checkUserPass2();
	            return;
	        }

	        // 8~16자리, 영문 대소문자, 숫자, 특수문자(!@#$%)
	        let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;

	        if (lengthRegex.test(passwd)) {
	            let count = 0;
	            if (/[A-Z]/.test(passwd)) count++;
	            if (/[a-z]/.test(passwd)) count++;
	            if (/\d/.test(passwd)) count++;
	            if (/[!@#$%]/.test(passwd)) count++;

	            switch (count) {
	                case 4:
	                    $("#userPwSuccess").text("안전").css("color","blue");
	                    isCheckPass = true; break;
	                case 3:
	                    $("#userPwSuccess").text("보통").css("color","green");
	                    isCheckPass = true; break;
	                case 2:
	                    $("#userPwSuccess").text("위험").css("color","orange");
	                    isCheckPass = true; break;
	                default:
	                    $("#userPwSuccess").text("사용불가").css("color","red");
	                    isCheckPass = false; break;
	            }
	        } else {
	            $("#userPwSuccess").text("영문자, 숫자, 특수문자(!@#$%) 필수!").css("color","red");
	            isCheckPass = false;
	        }

	        checkUserPass2(); // 일치 여부 갱신
	    }

	    function checkUserPass2() {
	        let passwd = $("#userpw").val();
	        let passwd2 = $("#userpw2").val();

	        if (!passwd2) {
	            $("#userPwSuccess2").text("");
	            isCheckPass2 = false;
	            return;
	        }

	        if (passwd === passwd2) {
	            $("#userPwSuccess2").text("비밀번호 일치").css("color","blue");
	            isCheckPass2 = true;
	        } else {
	            $("#userPwSuccess2").text("비밀번호 불일치").css("color","red");
	            isCheckPass2 = false;
	        }
	    }

	    // 폼 제출 시 유효성 체크
	    $(".password-form").on("submit", function(e){
	        if (!isCheckPass || !isCheckPass2) {
	            alert("비밀번호 조건을 확인하세요.");
	            e.preventDefault();
	        }
	       
	        
	       
	    });
	});
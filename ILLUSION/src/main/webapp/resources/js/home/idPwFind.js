$(function() {
	console.log("js불러옴")
	$('#finding-id').on('click', function() {
		$('#id-divider').show();
		$('.result').show();		
	});
		
		
	
	// 아이디 찾기 폼 제출 시 
	$("#idFindForm").on('submit', function(e) {
		e.preventDefault(); 
		
		const formData = $(this).serialize();
		console.log(formData);
		
		$.ajax({
			url: 'idFind',
	            type: 'POST',
	            dataType: 'json',
	            data: formData,
	            success: function(res) {
					alert('ㅇㅇ');
	                
	            },
	            error: function(xhr, status, error) {
	                alert('오류가 발생했습니다. 다시 시도해주세요.');
	            }
		})
	});
	
	// 이메일 인증
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
		
});



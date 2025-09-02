function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 도로명 주소
            document.getElementById("roadAddress").value = data.roadAddress;
            // 우편번호
            document.getElementById("postcode").value = data.zonecode;
        }
    }).open();
}
	const fileInput = document.getElementById('profileFileInput');
	const previewImg = document.getElementById('profilePreview');
 
	fileInput.addEventListener('change', function() {
	    const file = this.files[0];
	    if (file) {
	        const reader = new FileReader();
	        reader.onload = function(e) {
	            previewImg.src = e.target.result; // 선택한 이미지로 바로 변경
	        }
	        reader.readAsDataURL(file);
	    }
	});


function confirmSubmit() {
    const name = document.querySelector("input[name='member_name']").value.trim();
    const postcode = document.getElementById("postcode").value.trim();
    const roadAddress = document.getElementById("roadAddress").value.trim();
    const email = document.getElementById("email").value.trim();
	
    if(name === "") {
        alert("이름을 입력해주세요.");
        return false;
    }
    if(postcode === "" || roadAddress === "") {
        alert("주소를 입력해주세요.");
        return false;
    }
    if(email === "") {
        alert("이메일을 입력해주세요.");
        return false;
    }

    // 이메일 형식 체크
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if(!regex.test(email)) {
        alert("올바른 이메일 형식이 아닙니다.");
        return false;
    }
        // 이메일 중복 체크


    return confirm("수정하시겠습니까?");
}
function clearAddress() {
    document.getElementById("postcode").value = "";
    document.getElementById("roadAddress").value = "";
    const jibun = document.getElementById("jibunAddress");
    if(jibun) jibun.value = "";
}

let emailValid = false;	
function validateEmail(input) {
    const email = input.value.trim();
    const msg = document.getElementById("emailMsg");

    if(email === "") {
        msg.textContent = "";
        emailValid = false;
        return;
    }
        // 1. 이메일 형식 체크
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if(!regex.test(email)) {
        msg.textContent = "올바른 이메일 형식이 아닙니다.";
        msg.style.color = "red";
        emailValid = false;
        return;
    }

    fetch("/illusion/checkEmail?email=" + encodeURIComponent(email))
        .then(res => res.text())
        .then(data => {
            if(data.trim() === "duplicate") {
                msg.textContent = "이미 사용중인 이메일입니다.";
                msg.style.color = "red";
                emailValid = false;
            } else {
                msg.textContent = "사용 가능한 이메일입니다.";
                msg.style.color = "green";
                emailValid = true;
            }
        });
}
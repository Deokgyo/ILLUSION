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
    return confirm("수정하시겠습니까?");
}
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 도로명 주소
            document.getElementById("roadAddress").value = data.roadAddress;
            // 지번 주소
            document.getElementById("jibunAddress").value = data.jibunAddress;
            // 우편번호
            document.getElementById("postcode").value = data.zonecode;
        }
    }).open();
}
function clearAddress() {
    document.getElementById("postcode").value = "";
    document.getElementById("roadAddress").value = "";
    const jibun = document.getElementById("jibunAddress");
    if(jibun) jibun.value = "";
}
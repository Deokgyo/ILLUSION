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
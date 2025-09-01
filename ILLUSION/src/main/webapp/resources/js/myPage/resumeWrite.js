// 파일 채인지시 미리보기 구현
$("#file1").on("change", function(e) {
	    const file = e.target.files[0];
	    if (file) {
	        const imageUrl = URL.createObjectURL(file);
	        $("#avatarPreview img").attr("src", imageUrl); // <img> src 변경
	    }
	});
flatpickr("#enroll_date", {
    dateFormat: "Y-m-d",
    locale: "ko",
    clickOpens: true,
    allowInput: false,
    defaultDate: null,
    onChange: function(selectedDates, dateStr, instance) {
        instance.input.value = dateStr; // 선택된 날짜를 input.value에 반영
        console.log("입학일 선택:", dateStr);
    }
});
flatpickr("#graduation_date", {
    dateFormat: "Y-m-d",
    locale: "ko",
    clickOpens: true,
    allowInput: true,
    defaultDate: null,
    onChange: function(selectedDates, dateStr, instance) {
        instance.input.value = dateStr;
        console.log("졸업일 선택:", dateStr);
    }
});
	
	// 학점 입력 제어
	const gradeInput = document.getElementById("gradeInput");
	const gradeSelect = document.getElementById("gradeSelect");

	// 초기 최대값 설정
	let maxGrade = parseFloat(gradeSelect.value) || 4.5;

	// select 변경 시 최대값 업데이트
	gradeSelect.addEventListener("change", function() {
	    maxGrade = parseFloat(this.value) || 4.5;

	    // input 값이 새 maxGrade보다 크면 자동 조정
	    if (gradeInput.value && !isNaN(parseFloat(gradeInput.value)) && parseFloat(gradeInput.value) > maxGrade) {
	        gradeInput.value = maxGrade;
	    }
	});

	// input 입력 제한
	gradeInput.addEventListener("input", function() {
	    // 숫자와 소수점만 허용
	    this.value = this.value.replace(/[^0-9.]/g, '');

	    // 소수점 두 자리까지만 허용
	    const parts = this.value.split('.');
	    if (parts.length > 2) this.value = parts[0] + '.' + parts[1];
	    if (parts[1] && parts[1].length > 2) this.value = parts[0] + '.' + parts[1].substring(0, 2);

	    // maxGrade보다 크면 강제로 maxGrade로 설정
	    if (this.value && !isNaN(parseFloat(this.value)) && parseFloat(this.value) > maxGrade) {
	        this.value = maxGrade;
	    }
	});

	// 초기값 동기화 (input에 값이 이미 있을 경우)
	if (gradeInput.value && !isNaN(parseFloat(gradeInput.value)) && parseFloat(gradeInput.value) > maxGrade) {
	    gradeInput.value = maxGrade;
	}
	
	
	//submit하기전 폼안에서의 유효성검사
	function validateForm() {
		const form = document.forms["resumeForm"];

		// 제목 검사
		if (form["resume_title"].value.trim() === "") {
			alert("제목을 입력해주세요!");
			form["resume_title"].focus();
			return false;
		}

		// 학교 이름 검사
		if (form["school_name"].value.trim() === "") {
			alert("학교 이름을 입력해주세요!");
			form["school_name"].focus();
			return false;
		}

		// 전공 검사
		if (form["major"].value.trim() === "") {
			alert("전공을 입력해주세요!");
			form["major"].focus();
			return false;
		}

		// 학위 선택 검사 (첫 번째 select는 name 없음 -> name 추가 필요)
		if (!form["degree"].value) {
		    alert("학위를 선택해주세요!");
		    form["degree"].focus();
		    return false;
		}
		
		// 상태 검사
		if (!form["degreetype"].value) {
		    alert("상태를 선택해주세요!");
		    form["degreetype"].focus();
		    return false;
		}
		// 학점 검사
		if (!form["grade"].value) {
			alert("학점을 입력해주세요!");
			form["grade"].focus();
			return false;
		}
		// 입학날짜 검사
		if (!form["enroll_date"].value) {
			alert("입학 날짜를 선택해주세요!");
			form["enroll_date"].focus();
			return false;
		}
		// 졸업날짜 검사
		if (!form["graduation_date"].value) {
			alert("졸업 날짜를 선택해주세요!");
			form["graduation_date"].focus();
			return false;
		}
	    // 날짜 비교
	    const enrollDate = new Date(form["enroll_date"].value);
	    const graduationDate = new Date(form["graduation_date"].value);
	    if (graduationDate < enrollDate) {
	        alert("졸업 날짜는 입학 날짜보다 이전일 수 없습니다!");
	        form["graduation_date"].focus();
	        return false;
	    }
	    
		return true; // 모든 체크 통과하면 제출
	}


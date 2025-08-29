$(document).ready(function() {
    $("#withdrawForm").on("submit", function(e) {
        // 체크박스 확인
        if (!$("#agree").is(":checked")) {
            alert("탈퇴 정책에 동의해야 합니다.");
            e.preventDefault();
            return;
        }

        // 아이디와 비밀번호 입력 확인
        const memberId = $("input[name='member_id']").val().trim();
        const memberPw = $("input[name='member_pw']").val().trim();

        if (memberId === "") {
            alert("아이디를 입력하세요.");
            e.preventDefault();
            return;
        }

        if (memberPw === "") {
            alert("비밀번호를 입력하세요.");
            e.preventDefault();
            return;
        }
        // ✅ 최종 확인
        const confirmed = confirm("정말로 탈퇴하시겠습니까?");
        if (!confirmed) {
            e.preventDefault(); // 취소 시 제출 중단
            return;
        }
    });
});
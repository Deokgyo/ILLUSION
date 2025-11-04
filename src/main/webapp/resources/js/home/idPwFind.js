$(function () {
  // 아이디 찾기 - 인증번호 발송 버튼 클릭
  $("#id-send-auth-btn").on("click", function () {
    const member_name = $("#id-member-name").val();
    const member_email = $("#id-member-email").val();

    if (!member_name || !member_email) {
      alert("이름과 이메일을 모두 입력해주세요.");
      return;
    }

    $(this).prop("disabled", true).val("전송중!");

    $.ajax({
      url: "idFind/sendAuthCode",
      type: "POST",
      data: {
        member_name: member_name,
        member_email: member_email,
      },
      success: function (res) {
        if (res.success) {
          alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
          $("#id-auth-code-item").show();
          $("#id-verify-btn").show();
          $("#id-send-auth-btn").hide();
          $("#id-member-name, #id-member-email").prop("readonly", true);
        } else {
          // 탈퇴된 회원인 경우 특별한 메시지 표시
          if (res.message && res.message === "탈퇴된 회원입니다.") {
            alert("탈퇴된 회원입니다.");
          } else {
            alert("일치하는 회원 정보가 없습니다.");
          }
          $("#id-send-auth-btn").prop("disabled", false).val("인증번호 발송");
        }
      },
      error: function () {
        alert("인증번호 발송 중 오류가 발생했습니다.");
        $("#id-send-auth-btn").prop("disabled", false).val("인증번호 발송");
      },
    });
  });

  // 아이디 찾기 - 인증 확인 버튼 클릭
  $("#id-verify-btn").on("click", function () {
    const member_email = $("#id-member-email").val();
    const auth_code = $("#id-auth-code-input").val();
    const member_name = $("#id-member-name").val();

    if (!auth_code) {
      alert("인증번호를 입력해주세요.");
      return;
    }

    $.ajax({
      url: "idFind/verify",
      type: "POST",
      data: {
        member_email: member_email,
        auth_code: auth_code,
        member_name: member_name,
      },
      success: function (res) {
        $("#id-result-text").text(res.msg);
        $("#id-result-text").parent(".result").show();
        $("#id-divider").show();
      },
      error: function () {
        alert("아이디 확인 중 오류가 발생했습니다.");
      },
    });
  });

  // 비밀번호 찾기 - 인증번호 발송 버튼 클릭
  $("#pw-send-auth-btn").on("click", function () {
    const member_id = $("#pw-member-id").val();
    const member_email = $("#pw-member-email").val();

    if (!member_id || !member_email) {
      alert("아이디와 이메일을 모두 입력해주세요.");
      return;
    }

    $(this).prop("disabled", true).val("전송중!");

    $.ajax({
      url: "pwFind/sendAuthCode",
      type: "POST",
      data: {
        member_id: member_id,
        member_email: member_email,
      },
      success: function (res) {
        if (res.success) {
          alert("인증번호가 발송되었습니다. 이메일을 확인해주세요.");
          $("#pw-auth-code-item").show();
          $("#pw-verify-btn").show();
          $("#pw-send-auth-btn").hide();
          $("#pw-member-id, #pw-member-email").prop("readonly", true);
        } else {
          // 탈퇴된 회원인 경우 특별한 메시지 표시
          if (res.message && res.message === "탈퇴된 회원입니다.") {
            alert("탈퇴된 회원입니다.");
          } else {
            alert("일치하는 회원 정보가 없습니다.");
          }
          $("#pw-send-auth-btn").prop("disabled", false).val("인증번호 발송");
        }
      },
      error: function () {
        alert("인증번호 발송 중 오류가 발생했습니다.");
        $("#pw-send-auth-btn").prop("disabled", false).val("인증번호 발송");
      },
    });
  });

  // 비밀번호 찾기 - 인증 확인 버튼 클릭
  $("#pw-verify-btn").on("click", function () {
    const member_id = $("#pw-member-id").val();
    const member_email = $("#pw-member-email").val();
    const auth_code = $("#pw-auth-code-input").val();

    if (!auth_code) {
      alert("인증번호를 입력해주세요.");
      return;
    }

    $.ajax({
      url: "pwFind/verifyAndReset",
      type: "POST",
      data: {
        member_id: member_id,
        member_email: member_email,
        auth_code: auth_code,
      },
      success: function (res) {
        $("#pw-result-text").text(res.msg);
        $("#pw-result-text").parent(".result").show();
        $("#pw-divider").show();
      },
      error: function () {
        alert("비밀번호 재설정 중 오류가 발생했습니다.");
      },
    });
  });
});

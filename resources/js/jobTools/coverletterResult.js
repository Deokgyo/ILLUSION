$(function () {
  // 복사 버튼
  $("#copyBtn").click(function () {
    let content = $("#generated-text").val();

    // 클립보드 복사
    navigator.clipboard
      .writeText(content)
      .then(function () {
        alert("자기소개서 내용이 클립보드에 복사되었습니다!");
      })
      .catch(function (err) {
        console.error("복사 실패:", err);
        alert("복사에 실패했습니다.");
      });
  });

  // CL002(첨삭된 자소서)인 경우 원본 자소서 복사 버튼도 추가
  if ($("#original-text").length > 0) {
    $(
      '<button id="copyOriginalBtn" class="btn btn-outline-secondary" style="margin-right: 10px;">원본 복사</button>'
    ).insertBefore("#copyBtn");

    $("#copyOriginalBtn").click(function () {
      let content = $("#original-text").val();
      navigator.clipboard
        .writeText(content)
        .then(function () {
          alert("원본 자소서 내용이 클립보드에 복사되었습니다!");
        })
        .catch(function (err) {
          console.error("복사 실패:", err);
          alert("복사에 실패했습니다.");
        });
    });
  }

  // 저장 버튼
  $("#saveBtn").click(function () {
    var cl_idx = $(this).data("cl-idx");
    $.ajax({
      type: "POST",
      url: "saveToMypage",
      data: { cl_idx: cl_idx },
      success: function (res) {
        alert(res.message);
        $("#saveBtn").text(res.btnMsg);
      },
      error: function () {
        alert("저장 중 오류가 발생했습니다.");
      },
    });
  });
});

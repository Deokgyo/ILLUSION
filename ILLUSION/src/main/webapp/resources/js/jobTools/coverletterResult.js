$(function(){
	 $("#copyBtn").click(function() {
        // textarea 내용 가져오기
        var content = $("#generated-text").val();

        // 클립보드 복사
        navigator.clipboard.writeText(content)
            .then(function() {
                alert("자기소개서 내용이 클립보드에 복사되었습니다!");
            })
            .catch(function(err) {
                console.error("복사 실패:", err);
                alert("복사에 실패했습니다.");
            });
    });
});
function checkIdentity() {
    const pw = document.getElementById("member_pw").value;
    const member_idx = document.getElementById("member_idx").value;
    const member_id = document.getElementById("member_id").value;

    if(pw.trim() === "") {
        alert("비밀번호를 입력하세요.");
        return;
    }

    // CSRF 토큰 가져오기
    const token = document.getElementById("_csrf").value;
    const headerName = document.getElementById("_csrf_header").value; // headerName 변수 사용

    fetch('/illusion/identityCheck1', {
        method: 'POST',
        headers: { 
            'Content-Type': 'application/x-www-form-urlencoded',
            [headerName]: token // 이 부분이 중요
        },
        body: new URLSearchParams({
            member_idx: member_idx,
            member_id: member_id,
            member_pw: pw
        })
    })
    .then(res => res.text())
    .then(data => {
        if(data === 'ok') {
            alert('인증 성공');
            window.location.href = 'userInfoEdit';
            
        } else {
            alert('비밀번호가 일치하지 않습니다.');
        }
    })
    .catch(err => {
        console.error('서버 요청 실패:', err);
        alert('서버와 연결할 수 없습니다.');
    });
}
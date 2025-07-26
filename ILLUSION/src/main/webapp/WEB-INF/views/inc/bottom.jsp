<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

.site-footer-v2 {
    width: 100%;
    padding: 40px 0;
    background: linear-gradient(to bottom, #FEF9E0, #FFEBEE);
    color: #555;
    font-size: 13px;
    line-height: 1.8;
}

.footer-container-v2 {
    width: 100%;
    max-width: 1280px;
    margin: 0 auto;
    padding: 0 25px;
}

/* 푸터 상단 (고객센터, 제휴문의) */
.footer-top-v2 {
    display: flex;
    justify-content: space-between;
    gap: 40px;
    padding-bottom: 30px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

.footer-title-v2 {
    font-size: 15px;
    font-weight: 500;
    color: #333;
    margin-bottom: 12px;
}

.footer-top-v2 a {
    color: #555;
    text-decoration: none;
}
.footer-top-v2 a:hover {
    text-decoration: underline;
}

/* 푸터 하단 (로고, 법적고지, 소셜) */
.footer-bottom-v2 {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-top: 30px;
}

/* 하단 왼쪽: 로고 + 주소 */
.footer-info-v2 {
    display: flex;
    align-items: center;
    gap: 20px;
}

.footer-logo-v2 img {
    height: 40px; /* 로고 이미지 높이 고정 */
}

.footer-address p {
    margin: 0;
    padding: 0;
    font-size: 13px;
    color: #666;
}


/* 하단 중앙: 법적 고지 */
.footer-legal-v2 {
    text-align: center; /* 내부 요소를 중앙 정렬합니다. */
    padding-top: 30px; /* 위쪽 콘텐츠와의 간격을 위해 패딩 추가 */
    margin-top: 30px; /* 위쪽 콘텐츠와의 간격을 위해 마진 추가 */
}

.footer-legal-v2 ul {
    display: inline-flex; /* ul을 인라인 요소처럼 만들어 중앙 정렬이 적용되게 함 */
    gap: 8px; /* 링크 사이 간격 */
    margin: 0;
    padding: 0;
    list-style: none;
}

.footer-legal-v2 li + li::before {
    content: '|';
    margin-right: 8px;
    color: #ccc;
}

.footer-legal-v2 a {
    color: #666;
    text-decoration: none;
}

.footer-legal-v2 a:hover {
    color: #000;
}


/* 하단 오른쪽: 소셜 아이콘 */
.social-links-v2 {
    display: flex;
    align-items: center;
    gap: 12px;
}

.social-links-v2 img {
    height: 28px; /* 아이콘 높이 통일 */
    transition: opacity 0.3s ease;
}

.social-links-v2 a:hover img {
    opacity: 0.7;
}
</style>

<footer class="site-footer-v2">
    <div class="footer-container-v2">
        <!-- 푸터 상단: 고객센터, 제휴문의 -->
        <div class="footer-top-v2">
            <div class="footer-column-v2">
                <h3 class="footer-title-v2">고객센터</h3>
                <p>운영시간 10 : 00 ~ 18 : 00</p>
                <p>점심시간 12 : 00 ~ 13 : 00</p>
                <p>휴무일 주말, 공휴일</p>
                <p>이메일 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
            </div>
            <div class="footer-column-v2">
                <h3 class="footer-title-v2">제휴 및 채용문의</h3>
                <p>일반 채용문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
                <p>기업 서비스 문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
                <p>사업 제휴 문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
            </div>
        </div>

         <!-- 푸터 중간: 로고/회사정보, 소셜 링크 -->
        <div class="footer-bottom-v2">
            <div class="footer-info-v2">
                <div class="footer-logo-v2">
                    <img src="https://i.ibb.co/L8y2wG3/illusion-logo-footer.png" alt="ILLUSION FIND YOUR JOB THE SMART WAY">
                </div>
                <div class="footer-address">
                    <p>주식회사 일루션</p>
                    <p>부산시 부산진구 삼한골든게이트 7층</p>
                    <p>사업자번호 : 123456</p>
                </div>
            </div>

            <div class="social-links-v2">
                <a href="#" aria-label="Instagram"><i class="bi bi-instagram"></i></a>
                <a href="#" aria-label="Facebook"><i class="bi bi-facebook"></i></a>
                <a href="#" aria-label="YouTube"><i class="bi bi-youtube"></i></a>
                <a href="#" aria-label="KakaoTalk"><img src="https://i.ibb.co/hL41YhH/kakao.png" alt="kakaotalk channel"></a>
            </div>
        </div>
        
        <nav class="footer-legal-v2">
            <ul>
                <li><a href="#">이용약관</a></li>
                <li><a href="#">개인정보 처리방침</a></li>
                <li><a href="#">문의하기</a></li>
            </ul>
        </nav>

    </div>
</footer>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">
.footer {
  background: linear-gradient(to bottom, #fef0c4, #f5f5f5, #fce5f1);
  padding: 10px 40px;
  font-family: sans-serif;
  font-size: 14px;
  color: #444;
}

.footer-top {
  display: flex;
  justify-content: space-between;
  flex-wrap: wrap;
  margin-bottom: 30px;
}

.footer-left{
 width: 45%;
 line-height: 1;}
.footer-right{
	
  line-height: 1;
}

.footer a {
  color: #444;
  text-decoration: none;
}

.footer a:hover {
  text-decoration: underline;
}

.footer-middle {
  text-align: left;
  margin-bottom: 20px;
  color: #444;
}

.footer-middle h3 {
  font-size: 20px;
  margin-bottom: 5px;
}

.footer-bottom {
  text-align: center;
  font-size: 13px;
  color: #666;
}

.footer-bottom a {
  margin: 0 5px;
}

.social-icons {
  display: flex;
  justify-content: flex-end;
  align-items: center; /* 수직 정렬 원할 경우 */
  gap: 10px; /* 아이콘 간 간격 */
}

.social-icons img {
  width: 24px;
  height: 24px;
  margin-right: 10px;
  vertical-align: middle;
}



</style>


<footer class="footer">
  <div class="footer-top">
    <div class="footer-left">
      <h4>고객센터</h4>
      <p>운영시간 10 : 00 ~ 18 : 00</p>
      <p>점심시간 12 : 00 ~ 13 : 00</p>
      <p>휴무일 주말, 공휴일</p>
      <p>이메일 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
    </div>
    <div class="footer-right">
      <h4>제휴 및 채용문의</h4>
      <p>일반 채용문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
      <p>기업 서비스 문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
      <p>사업 제휴 문의 : <a href="mailto:illusion@naver.com">illusion@naver.com</a></p>
      
    </div>
  </div>

  <div class="footer-middle">
  <div class="social-icons">
        <a href="#"><img src="instagram.png" alt="Instagram"></a>
        <a href="#"><img src="facebook.png" alt="Facebook"></a>
        <a href="#"><img src="youtube.png" alt="YouTube"></a>
        <a href="#"><img src="kakao.png" alt="KakaoTalk"></a>
      </div>	
    <img src="img/logo.png" alt="ILLUSION 로고">
    <p>주식회사 일루션<br>부산시 부산진구 삼한골든게이트 7층<br>사업자번호 : 123456</p>
    
  </div>

  <div class="footer-bottom">
    <a href="#">이용약관</a> |
    <a href="#">개인정보 처리방침</a> |
    <a href="#">문의하기</a>
  </div>
</footer>

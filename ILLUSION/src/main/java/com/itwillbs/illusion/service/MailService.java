package com.itwillbs.illusion.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.handler.home.GenerateRandomCode;
import com.itwillbs.illusion.handler.home.MailClient;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Service
public class MailService {

	@Autowired
	private MailClient mailClient;

	public MailAuthInfo sendAuthMail(MemberVO member) {

		// 인증 메일에 포함시킬 인증코드(난수) 생성
		String auth_code = GenerateRandomCode.getRandomCode(4);

		// ==========================================
		// [ 인증 메일 발송 요청 ]
		String subject = "[illusion] 가입 인증 메일입니다.";
		String url = "http://localhost:8080/illusion/verify?";
		// 난수(auth_code) 표시
		String content = "<p>아래의 이메일 인증번호를 입력해주세요.</p>" + "<h2>" + auth_code + "</h2>"
				+ "<p>인증번호를 입력란에 입력하시면 가입이 완료됩니다.</p>";

		mailClient.sendMail(member.getMember_email(), subject, content);
		MailAuthInfo mailAuthInfo = new MailAuthInfo(member.getMember_email(), auth_code);
		return mailAuthInfo;
	}

}

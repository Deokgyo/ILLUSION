package com.itwillbs.illusion.controller.home;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import com.itwillbs.illusion.service.MailService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@RestController
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private MailService mailService;

	/* 이메일 인증번호 발송 요청 API 클라이언트에서 이메일을 JSON으로 보내면 해당 이메일로 인증번호를 생성해 메일 전송 후 DB 저장 */
	@PostMapping("email-auth")
	public Map<String, Object> sendAuthMail(@RequestBody MemberVO member) {
		// 인증 메일을 발송하고 인증 정보 반환
		MailAuthInfo mailAuthInfo = mailService.sendAuthMail(member);
		// DB에 인증정보 등록
		memberService.insertMailAuthInfo(mailAuthInfo);

		// 발송 성공 여부를 JSON으로 반환
		return Map.of("result", true);
	}

	// 이메일 인증번호 확인 요청 API 사용자가 입력한 인증번호가 DB에 저장된 번호와 일치하는지 및 유효시간 내인지 검사 후 결과 반환
	@PostMapping("email-auth-check")
	public Map<String, Object> checkAuthMail(@RequestBody MailAuthInfo mailAuthInfo) {
		// 인증번호 검사 처리
		boolean isValid = memberService.requestEmailAuth(mailAuthInfo);
		return Map.of("result", isValid);
	}

 
    



} // 컨트롤러

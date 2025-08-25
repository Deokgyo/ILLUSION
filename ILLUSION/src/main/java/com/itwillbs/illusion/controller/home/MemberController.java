package com.itwillbs.illusion.controller.home;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
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

	@ResponseBody // 리턴되는 문자열이 데이터가 되도록 변경
	@GetMapping("checkIdCount")
	public Map<String, Object> checkIdCount(@RequestParam String member_id) {
		boolean checkIdCount = memberService.checkIdCount(member_id) > 0;
		return Collections.singletonMap("duplicate", checkIdCount);
	}

	/* 이메일 인증번호 발송 요청 API 클라이언트에서 이메일을 JSON으로 보내면 해당 이메일로 인증번호를 생성해 메일 전송 후 DB 저장 */
	@PostMapping("email-auth")
	public Map<String, Object> sendAuthMail(@RequestBody MemberVO member) {
		System.out.println("sendAuthMail 호출됨, 이메일: " + member.getMember_email());
		MailAuthInfo mailAuthInfo = mailService.sendAuthMail(member);
		memberService.insertMailAuthInfo(mailAuthInfo);
		return Map.of("result", true);
	}

	@PostMapping("email-auth-check")
	public Map<String, Object> checkAuthMail(@RequestBody MailAuthInfo mailAuthInfo) {
		boolean isValid = memberService.requestEmailAuth(mailAuthInfo);
		return Map.of("result", isValid);
	}

	
	
} // 컨트롤러

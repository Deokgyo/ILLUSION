package com.itwillbs.illusion.controller.home;

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
		MailAuthInfo mailAuthInfo = mailService.sendAuthMail(member);
		memberService.insertMailAuthInfo(mailAuthInfo);
		return Map.of("result", true);
	}

	@PostMapping("email-auth-check")
	public Map<String, Object> checkAuthMail(@RequestBody MailAuthInfo mailAuthInfo) {
		boolean isValid = memberService.requestEmailAuth(mailAuthInfo);
		return Map.of("result", isValid);
	}
	
	@GetMapping("email-check")
	public Map<String, Object> checkEmailDuplicate(@RequestParam String email) {
	    boolean exists = memberService.isEmailExist(email); // 이메일 중복 여부 확인 서비스 호출
	    return Map.of("exists", exists);
	}
	//사업자등록번호 인증 
	@GetMapping("checkRecruiterNumber")
	@ResponseBody
	public Map<String, Object> checkRecruiterNumber(@RequestParam String recruiter_number) {
	    int count = memberService.checkRecruiterNumber(recruiter_number);
	    Map<String, Object> result = new HashMap<>();
	    result.put("duplicate", count > 0);
	    result.put("message", count > 0 ? "중복된 사업자등록번호입니다." : "인증 성공");
	    return result;
	}
	
	
} // 컨트롤러

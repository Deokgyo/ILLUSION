package com.itwillbs.illusion.controller.recruiter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Recruiter {

	
	// 기업 메인 페이지로 이동 
	@GetMapping("recruiterMain") 
	public String recruiterMain() {
		return "recruiter/recruiterMain"; 
	}
	
	// 공고 등록 페이지로 이동
	@GetMapping("recruiterRegistForm")
	public String recruiterRegistForm() {
		return "recruiter/recruiterRegistForm";
	}
	
	// 기업 회원이 작성한 목록 페이지로 이동
	@GetMapping("recruiterList")
	public String recruiterList() {
		return "recruiter/recruiterList";
	}
}

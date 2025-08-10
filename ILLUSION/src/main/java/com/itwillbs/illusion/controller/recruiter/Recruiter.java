package com.itwillbs.illusion.controller.recruiter;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class Recruiter {

	
	// 기업 메인 페이지로 이동 
	@GetMapping("recruiterMain") 
	public String recruiterMain() {
		return "recruiter/recruiterMain"; 
	}
	
	// 기업 정보 수정으로 이동 
	@GetMapping("recruiterInfo")
	public String recruiterInfo() {
		return "recruiter/recruiterInfo";
	}
	
	
	
	// =======================================================================
	// 							공고 등록 관련
	// =======================================================================
	
	// 공고 등록 페이지로 이동함 
	@GetMapping("recruiterRegistForm")
	public String recruiterRegistForm() {
		return "recruiter/recruiterRegistForm";
	}
	
	// 공고 등록 폼 제출 
	@PostMapping("recruiterRegistForm")
	public String recruiterRegistForm(RecruitVO recruit) {
		System.out.println("여기다 이놈아 ~~~~~~~~~~~~~~");
		System.out.println(recruit.getEnd_date());
		return "redirect:/recruiterList";
	}
	
	// 기업 회원이 작성한 목록 페이지로 이동
	@GetMapping("recruiterList")
	public String recruiterList() {
		return "recruiter/recruiterList";
	}
}

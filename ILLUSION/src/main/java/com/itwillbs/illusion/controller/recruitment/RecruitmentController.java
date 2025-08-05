package com.itwillbs.illusion.controller.recruitment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RecruitmentController {
	
	// 채용정보 페이지 이동
	@GetMapping("recruitmentInfo")
	public String recruitmentInfo() {
		return "recruitment/recruitmentInfo";
	}
	
	// 채용공고 상세페이지 이동
	@GetMapping("recruitmentDetail")
	public String recruitmentDetail() {
		return "recruitment/recruitmentDetail";
	}
}

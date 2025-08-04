package com.itwillbs.illusion.controller.recruitment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class recruitment {

	@GetMapping("recruitmentInfo")
	public String recruitmentInfo() {
		return "recruitment/recruitmentInfo";
	}
	
	@GetMapping("recruitmentDetail")
	public String recruitmentDetail() {
		return "recruitment/recruitmentDetail";
	}
}

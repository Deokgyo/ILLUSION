package com.itwillbs.illusion.controller.recruitment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class Recuritment {

	@GetMapping("recuritmentInfo")
	public String recuritmentInfo() {
		return "recuritment/recuritmentInfo";
	}
	
	@GetMapping("recuritmentDetail")
	public String recuritmentDetail() {
		return "recuritment/recuritmentDetail";
	}


}

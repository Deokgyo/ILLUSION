package com.itwillbs.illusion.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JobTools {

	
	@GetMapping("coverletterCreate")
	public String coverletterCreate() {
		return "jobTools/coverletterCreate";
	}
	
	@GetMapping("coverletterResult")
	public String coverletterResult() {
		return "jobTools/coverletterResult";
	}
}
       
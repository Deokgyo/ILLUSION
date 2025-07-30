package com.itwillbs.illusion.controller.jobTools;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class JobToolsController {

	
	@GetMapping("coverletterCreate")
	public String coverletterCreate() {
		return "jobTools/coverletterCreate";
	}
	
	@GetMapping("coverletterResult")
	public String coverletterResult() {
		return "jobTools/coverletterResult";
	}
	
	@GetMapping("coverletterRefiner")
	public String coverletterRefiner() {
		return "jobTools/coverletterRefiner";
	}
	
	@GetMapping("interviewCreate")
	public String interviewCreate() {
		return "jobTools/interviewCreate";
	}
	
	@GetMapping("interviewResult")
	public String interviewResult() {
		return "jobTools/interviewResult";
	}
	
	@GetMapping("chatbot")
	public String chatbotMain() {
		return "jobTools/chatbot";
	}
}
       
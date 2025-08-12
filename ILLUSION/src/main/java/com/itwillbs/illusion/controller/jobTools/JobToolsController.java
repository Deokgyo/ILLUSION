package com.itwillbs.illusion.controller.jobTools;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.service.JobToolsService;

@Controller
public class JobToolsController {

	
	@Autowired
	JobToolsService service;
	
	@GetMapping("coverletterCreate")
	public String coverletterCreate(Model model) {
		
		List<Map<String, String>> occupationList = service.getOccupation();
		model.addAttribute("occupationList", occupationList);
		
		
		List<Map<String, String>> expList = service.getExperience();
		model.addAttribute("expList", expList);
		
		
		return "jobTools/coverletterCreate";
	}
	
	@PostMapping("coverletterGenerate")
	public String coverletterGenerate(Model model, 
										String title, String company, 
										String prevCompany, String prevJob,
										String maxLength, String keywords, String question) {
		
		
		System.out.println("title" + title);
		System.out.println("company" + company);
		System.out.println("maxLength" + maxLength);
		System.out.println("keywords" + keywords);
		System.out.println("question" + question);
		
		return "redirect:coverletterResult";
	}
	
	
	
	
	@GetMapping("coverletterModify")
	public String coverletterModify() {
		return "jobTools/coverletterModify";
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
       
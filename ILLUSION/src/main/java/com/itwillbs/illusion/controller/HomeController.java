package com.itwillbs.illusion.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

// 

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	@GetMapping("errorPage")
    public String errorPage() {
        return "errorPage"; 
    }
	
	//로그인 이동 
	@GetMapping("login")
	public String login() {
		return "home/login";
	}
	
	// 회원가입 이동 
	@GetMapping("register")
	public String register() {
		return "home/register";
	}
	
	// 메인 자소서 생성기 이동 
	@GetMapping("Create")
	public String Create() {
		return "jobTools/coverletterCreate";
	}
	
	//메인 채용정보 페이지 이동
	@GetMapping("recruitment")
	public String recruitment() {
		return "recruitment/recruitmentInfo";
	}
	
	// 자세히 보기 자소서 생성기 이동 
	@GetMapping("coverletter")
	public String coverletter() {
		return "jobTools/coverletterCreate";
	}
	
	// 자세히 보기 자소서 다듬기 이동 
	@GetMapping("Refiner")
	public String Refiner() {
		return "jobTools/coverletterRefiner";
		}
	
	// 자세히 보기 면접질문 이동 
	@GetMapping("interview")
	public String interview() {
		return "jobTools/interviewCreate";
		}
	
	// 자세히 보기 챗봇 이동 
		@GetMapping("chatbot")
		public String chatbot() {
			return "jobTools/chatbot";
			}
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}

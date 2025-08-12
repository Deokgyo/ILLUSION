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
	
	//로그인 이동 
	@GetMapping("idPwFind")
	public String idPwFind() {
		return "home/idPwFind";
	}
	
	
	// 회원가입 이동 
	@GetMapping("register")
	public String register() {
		return "home/register";
	}
	

	
	
	
	
	
	
	
	
	
	
	
	
	
}

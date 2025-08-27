package com.itwillbs.illusion.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.CompanyService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

// 

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CompanyService companyService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}

	@GetMapping("errorPage")
	public String errorPage() {
		return "errorPage";
	}

	// 로그인 이동
	@GetMapping("idPwFind")
	public String idPwFind() {
		return "home/idPwFind";
	}

	// 회원가입 이동
	@GetMapping("register")
	public String register() {
		return "home/register";
	}

//	@PostMapping("register")
//	public String register2() {
//		System.out.println("!@#!@#");
//		return "";
//	}
	
	@PostMapping("register")
	public String register(MemberVO member, CompanyVo company, Model model, String address_name1, String address_name2) {
		
		System.out.println("!@#");
		System.out.println(member);
		System.out.println(company);
		
		if (member.getMember_type().equals("MEM001")) { // 개인
			member.setAddress_name(address_name1 + " " + address_name2);
			boolean result = memberService.insertMember(member, company);
			if (result) {
				MailAuthInfo mailAuthInfo = new MailAuthInfo();
				mailAuthInfo.setEmail(member.getMember_email()); // 이메일 필드명 맞게 사용
				memberService.updateMailAuthStatus(mailAuthInfo);

				return "redirect:/login";
			} else {
				// 회원가입 실패 시 오류 메시지 전달 후 가입 폼으로 이동
				model.addAttribute("error", "회원가입 실패");
				return "registerForm";
			}
		} else {	// 기업
			System.out.println("Received password: " + member.getMember_pw());
			// 기업회원 정보 넣는거 (멤버테이블)
			boolean memberResult = memberService.insertCompanyMember(member);
			// 기업 정보 넣는거 (회사테이블)
			boolean companyResult = companyService.insertMemberCompany(company);
//			boolean addressResult = companyService.insertAddress(company);
			
//			company.setAddress_idx(service.getAddrPk());
//			member.setCompany_idx(service.getCompanyPk());
//			
//			service.insertAddr();	// 6
//			service.insertMemberCompany(company);
			
			if (memberResult && companyResult) {
				return "redirect:/login";
			} else {
				model.addAttribute("error", "회원가입 실패");
				return "redirect:/login";
			}
		}
		
	}

	// 날짜관련
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		// true : 빈 값도 허용 (optional)
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}

	
}

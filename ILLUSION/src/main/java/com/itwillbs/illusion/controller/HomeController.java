package com.itwillbs.illusion.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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

	@PostMapping("register")
	public String register(MemberVO member, Model model, String address_name1, String address_name2) {
		member.setAddress_name(address_name1 + " " + address_name2);
		boolean result = memberService.insertMember(member);
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
	}
	
	// 날짜관련
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		// true : 빈 값도 허용 (optional)
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
	}
//	 //기업회원
//	 @PostMapping("registerCompanyMember")
//	    public String registerCompanyMember(MemberVO member,
//	                           @RequestParam(required = false) String company_name,
//	                           @RequestParam(required = false) String establishment_date,
//	                           @RequestParam(required = false) String ceo_name,
//	                           Model model) {
//	        try {
//	            // 기업회원일 때(member_type 값이 MEM003) 기업정보 받아서 서비스에 추가 전달
//	            if ("MEM003".equals(member.getMember_type())) {
//	                CompanyVo company = new CompanyVo();
//	                company.setCompany_name(company_name);
//	                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//	                company.setEstablishment_date(sdf.parse(establishment_date));
//	                company.setCeo_name(ceo_name);
//
//	                boolean success = memberService.registerCompanyMember(member, company);
//	                if (success) {
//	                    return "redirect:/login";
//	                } else {
//	                    model.addAttribute("error", "기업회원 가입 실패");
//	                    return "home/register";
//	                }
//	            } else {
//	                // 개인회원 가입 처리
//	                boolean success = memberService.insertMember(member);
//	                if (success) {
//	                    return "redirect:/login";
//	                } else {
//	                    model.addAttribute("error", "회원가입 실패");
//	                    return "home/register";
//	                }
//	            }
//	        } catch (Exception e) {
//	            model.addAttribute("error", "회원가입 중 오류: " + e.getMessage());
//	            return "home/register";
//	        }
//	    }
//	}

}

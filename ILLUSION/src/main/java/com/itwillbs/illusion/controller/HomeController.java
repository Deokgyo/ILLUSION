package com.itwillbs.illusion.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.illusion.service.CompanyService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.RecruitService;
import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.RecruitVO;

// 

@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private CompanyService companyService;
	
	@Autowired
	RecruitService recruitService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		RecruitFilterVO filterVO = new RecruitFilterVO();
		
		filterVO.setListLimit(4);
		filterVO.setStartRow(0);
		
		List<RecruitVO> recruitList = recruitService.homeSelectRecruitList(filterVO);
		
		model.addAttribute("recruitList", recruitList);   // 화면에 표시할 목록
		
		return "home";
	}
	
	//에러페이지 이동 
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
	
	// 이용약관 이동 
    @GetMapping("termsOfService")
    public String termsOfService() {
    	return "home/termsOfService";
    }
    
    // 개인정보 이동 
    @GetMapping("privacyPolicy")
    public String privacyPolicy() {
    	return "home/privacyPolicy";
    }
    
    //마케팅 이동 
    @GetMapping("marketing")
    public String marketing() {
    	return "home/marketing";
    }
    
    //회원가입
	@PostMapping("register")
	public String register(MemberVO member, CompanyVo company, 
						   String address_name1, String address_name2,
						   RedirectAttributes redirectAttributes) {

		System.out.println("!@#");
		System.out.println(member);
		System.out.println(company);
		
		Map<String, Object> response = new HashMap<>();
		
		// 주소 합치기
		member.setAddress_name(address_name1 + " " + address_name2);

		// 기업 개인 상관 없이 회원 테이블에 정보 넣기
		boolean result = memberService.insertMember(member, company);

	    // 서비스 호출 결과에 따라 분기 처리
	    if (result) {
	        Map<String, String> param = new HashMap<>();
	        param.put("email", member.getMember_email());
	        memberService.updateMailAuthStatus(param);
	        
	        redirectAttributes.addFlashAttribute("msg", "회원가입 성공! 로그인 해주세요.");
	        // 성공했으므로 로그인 페이지로 리다이렉트
	        return "redirect:/login";
	    } else {
	        // 회원가입 실패 시
	    	redirectAttributes.addFlashAttribute("error", "회원가입 실패");
	        return "redirect:/login";
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

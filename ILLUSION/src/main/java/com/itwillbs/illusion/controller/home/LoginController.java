package com.itwillbs.illusion.controller.home;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService service;
	
	// 로그인 이동
	@GetMapping("login")
	public String login(HttpSession session, Model model) {
		
        Object loginErrorMsg = session.getAttribute("loginErrorMessage");
        
        
        if (loginErrorMsg != null) {
        	System.out.println(loginErrorMsg);
            model.addAttribute("errorMsg", loginErrorMsg);
            
            session.removeAttribute("loginErrorMessage");
        }
		
		return "home/login";
	}
	
	// 관리자 로그인 페이지 이동
	@GetMapping("adminLogin")
	public String adminLogin() {
		return "admin/adminLogin";
	}
	
	// 접근 제한 시 에러페이지 TODO 여기 메서드들 나중에 홈쪽 컨트롤러로 이동
    @GetMapping("/accessDenied")
    public String accessDenied(Model model) {
        model.addAttribute("msg", "페이지에 접근할 권한이 없습니다.");
        
        return "errorPage";
    }
    
    // 아이디 찾기 
    @PostMapping("idFind")
    @ResponseBody
    public Map<String, String> idFind(String member_name, String member_email){
    	
    	
    	Map<String, String> idFindMap = new HashMap<String, String>();
    	
    	return idFindMap; 
    }
	
// 스프링 시큐리티가 이제 다해줌
//	
//	// 로그인 기능
//	@PostMapping("login")
//	public String login(
//			@RequestParam Map<String, String> memberMap,
//			Model model,
//			HttpSession session,
//			HttpServletResponse res) {
//		
//		
//		Map<String, Object> loginMember = service.loginMember(memberMap);
//		
//		System.out.println("memberMap: ======== " + memberMap);
//		
//		System.out.println(loginMember);
//		
//		if (loginMember == null) {
//			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다.");
//			System.out.println("임시 에러");
//			return "";
//		} 
//		
//		boolean isRememberId = "true".equals(memberMap.get("rememberId"));
//		int maxAge = isRememberId ? 60 * 60 * 24 * 30 : 0;
//		Cookie cookie = new Cookie("rememberId", (String) loginMember.get("member_id"));
//		cookie.setMaxAge(maxAge);
//		res.addCookie(cookie);
//		
//		session.setAttribute("sId", loginMember);
//		session.setMaxInactiveInterval(600);
//		
//		
//		return "redirect:/";
//	}
	
	
//	@GetMapping("MemberLogout")
//	public String memberLogout(HttpSession session) {
//		session.invalidate();
//		return "redirect:/";
//	}
}

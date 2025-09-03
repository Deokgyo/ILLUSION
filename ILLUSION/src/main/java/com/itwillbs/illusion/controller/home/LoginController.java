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

	// 아이디 찾기 - 인증번호 발송
    @PostMapping("idFind/sendAuthCode")
    @ResponseBody
    public Map<String, Object> sendIdAuthCode(String member_name, String member_email) {
    	Map<String, Object> response = new HashMap<String, Object>();
    	
    	// 탈퇴된 회원인지 먼저 확인
    	if (service.isWithdrawnMemberForIdFind(member_name, member_email)) {
    		response.put("success", false);
    		response.put("message", "탈퇴된 회원입니다.");
    		return response;
    	}
    	
    	boolean isSuccess = service.sendIdFindAuthCode(member_name, member_email);
    	
    	response.put("success", isSuccess);
    	if (!isSuccess) {
    		response.put("message", "일치하는 회원 정보가 없습니다.");
    	}
    	
    	return response;
    }
    
    // 아이디 찾기 - 인증 확인 및 아이디 반환
    @PostMapping("idFind/verify")
    @ResponseBody
    public Map<String, String> verifyId(String member_email, String auth_code, String member_name) {
    	return service.verifyIdAndReturnId(member_email, auth_code, member_name);
    }
    
    // 비밀번호 찾기 - 인증번호 발송
    @PostMapping("pwFind/sendAuthCode")
    @ResponseBody
    public Map<String, Object> sendPwAuthCode(String member_id, String member_email) {
    	Map<String, Object> response = new HashMap<String, Object>();
    	
    	// 탈퇴된 회원인지 먼저 확인
    	if (service.isWithdrawnMemberForPwFind(member_id, member_email)) {
    		response.put("success", false);
    		response.put("message", "탈퇴된 회원입니다.");
    		return response;
    	}
    	
    	boolean isSuccess = service.sendPasswordResetAuthCode(member_id, member_email);
    	
    	response.put("success", isSuccess);
    	if (!isSuccess) {
    		response.put("message", "일치하는 회원 정보가 없습니다.");
    	}
    	
    	return response;
    }
    
    // 비밀번호 찾기 - 인증 및 재설정
    @PostMapping("pwFind/verifyAndReset")
    @ResponseBody
    public Map<String, String> verifyAndReset(String member_id, String member_email, String auth_code) {
    	return service.verifyCodeAndResetPassword(member_id, member_email, auth_code);
    }
}
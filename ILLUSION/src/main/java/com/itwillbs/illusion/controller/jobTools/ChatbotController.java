package com.itwillbs.illusion.controller.jobTools;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;
import com.itwillbs.illusion.util.SecurityUtil;
import com.itwillbs.illusion.vo.MemberVO;

@Controller
public class ChatbotController {
	
	 @Autowired
	 GeminiService geminiService;
	 
	 @Autowired
	 JobToolsService service;
	
	// 챗봇 메인페이지 이동
	 @GetMapping("chatbot")
	public String chatbotMain(Model model) {
		
		MemberVO loginUser = SecurityUtil.getLoginUser();
		int userToken = 0;
		
		if (loginUser != null) {
		    userToken = loginUser.getToken();
		}

        model.addAttribute("userToken", userToken);
        
		return "jobTools/chatbot";
	}

	// ai 챗봇 채팅 전송
	@PostMapping("aiChat") 
    @ResponseBody 
    public Map<String, Object> getChatResponse(@RequestParam String message, HttpSession session) { // 2. HttpSession 파라미터 추가
        
        Map<String, Object> response = new HashMap<>();
        
        // 3. (수정!) 토큰 차감과 AI 호출을 트랜잭션으로 묶은 서비스 메소드를 호출합니다.
        int requiredTokens = 5; // 예: 챗봇 1회 사용에 5토큰 필요
        
        try {
            // 4. 새로운 서비스 메소드를 호출합니다. (이 메소드는 아래에 새로 만들어야 함)
            String aiReply = service.useTokenForChatbot(message, requiredTokens);
            
            // --- 5. (핵심!) 성공 시 세션 정보 업데이트 ---
            MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                loginUser.setToken(loginUser.getToken() - requiredTokens);
                session.setAttribute("loginUser", loginUser);
            }
            // --- 여기까지 ---

            response.put("success", true);
            response.put("reply", aiReply); 
            
        } catch (RuntimeException e) {
            // 서비스에서 "토큰 부족" 예외가 발생했을 때
            response.put("success", false);
            response.put("message", e.getMessage());
	        }

	        return response;
	    }
}
	


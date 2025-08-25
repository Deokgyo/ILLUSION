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
    public Map<String, Object> getChatResponse(@RequestParam String message) {
        Map<String, Object> response = new HashMap<>();
        int requiredTokens = 5; // 챗봇 1회 사용에 5토큰 필요

        try {
            // 서비스 계층에서 토큰 차감, AI 호출, 새 토큰 개수 조회를 모두 처리
            Map<String, Object> serviceResult = service.useTokenForChatbot(message, requiredTokens);

            // 서비스 결과를 프론트엔드 응답에 맞게 재구성
            response.put("success", true);
            response.put("reply", serviceResult.get("reply"));
            response.put("newToken", serviceResult.get("newToken"));

        } catch (RuntimeException e) {
            // 서비스에서 "토큰 부족" 또는 다른 예외가 발생했을 때
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }
}
	


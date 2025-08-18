package com.itwillbs.illusion.controller.jobTools;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;

@Controller
public class ChatbotController {
	
	 @Autowired
	 GeminiService geminiService;
	 
	 @Autowired
	 JobToolsService service;
	
	// 챗봇 메인페이지 이동
	@GetMapping("chatbot")
	public String chatbotMain(Model model) {
		
		// TODO 로그인 한 유저 번호 가져오기
        int member_idx = 1; 
        
        Integer userToken = service.getMemberToken(member_idx);
        
        if(userToken == null) {
            userToken = 0;
        }

        model.addAttribute("userToken", userToken);
        
		return "jobTools/chatbot";
	}
	
	// ai 챗봇 채팅 전송
    @PostMapping("aiChat") 
    @ResponseBody 
    public Map<String, Object> getChatResponse(@RequestParam String message) {

        
        Map<String, Object> response = new HashMap<>();
        
        // TODO 로그인한 유저 번호로
        boolean isTokenAvailable = service.useTokenForJobTools(1, 5);
        
        if (isTokenAvailable) {
        	String aiReply = geminiService.callGeminiApi(message);
            response.put("success", true);
            response.put("reply", aiReply); 
        } else {
        	response.put("success", false);
            response.put("message", "토큰이 부족하여 면접 질문을 생성할 수 없습니다.");
        }

        return response;
    }
}
	


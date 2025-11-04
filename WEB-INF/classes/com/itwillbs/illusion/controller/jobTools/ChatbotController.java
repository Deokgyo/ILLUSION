package com.itwillbs.illusion.controller.jobTools;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;
import com.itwillbs.illusion.util.JobToolsConstants;
import com.itwillbs.illusion.util.SecurityUtil;
import com.itwillbs.illusion.vo.MemberVO;

@Controller
public class ChatbotController {

    @Autowired
    private GeminiService geminiService;

    @Autowired
    private JobToolsService service;

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

    @PostMapping("aiChat")
    @ResponseBody
    public Map<String, Object> getChatResponse(@RequestParam String message, HttpSession session) {
        try {
            Map<String, Object> serviceResult = service.useTokenForChatbot(message, JobToolsConstants.CHATBOT_QUERY_COST);
            updateSessionToken(session, (Integer) serviceResult.get("newToken"));

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("reply", serviceResult.get("reply"));
            response.put("newToken", serviceResult.get("newToken"));
            return response;
        } catch (RuntimeException e) {
            return createErrorResponse(e.getMessage());
        }
    }

    // ===================================================================
    // Helper Methods
    // ===================================================================

    private void updateSessionToken(HttpSession session, Integer newTokenCount) {
        if (newTokenCount != null) {
            MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                loginUser.setToken(newTokenCount);
                session.setAttribute("loginUser", loginUser);
            }
        }
    }

    private Map<String, Object> createErrorResponse(String message) {
        Map<String, Object> response = new HashMap<>();
        response.put("success", false);
        response.put("message", message);
        return response;
    }
}

	


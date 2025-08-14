package com.itwillbs.illusion.controller.jobTools;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;

@Controller
public class JobToolsController {

	
	@Autowired
	JobToolsService service;
	
	@Autowired
	private GeminiService geminiService;
	
	@GetMapping("coverletterCreate")
	public String coverletterCreate(Model model) {
		
		List<Map<String, String>> occupationList = service.getOccupation();
		model.addAttribute("occupationList", occupationList);
		
		
		List<Map<String, String>> expList = service.getExperience();
		model.addAttribute("expList", expList);
		
		
		return "jobTools/coverletterCreate";
	}
	
	@ResponseBody
	@PostMapping("coverletterGenerate")
	public Map<String, Object> coverletterGenerate(Model model, HttpSession session, 
	                                    String title, String company, 
	                                    String prevCompany, String prevJob, String occupation,
	                                    String maxLength, String keywords, String question, String experience) {
	    
	    String prompt = String.format(
	        "너는 이제부터 채용을 위한 자기소개서를 작성해주는 전문가야. 아래 조건에 맞춰서 자기소개서를 완벽하게 작성해줘.\n" +
	        "- 지원 회사: %s\n" +
	        "- 지원 직무: %s\n" +
	        "- 자기소개서 문항: %s\n" +
	        "- 이전 회사 및 직무 경험: %s에서 %s로 근무\n" +
	        "- 나의 핵심 경험/역량: %s\n" +
	        "- 반드시 포함할 키워드: %s\n" +
	        "- 글자 수 제한: %s자 이내\n" +
	        "- 위의 모든 조건을 충실하게 반영해서 자연스럽고 설득력 있는 어투로 자기소개서를 작성해줘.",
	        company, occupation, question, prevCompany, prevJob, experience, keywords, maxLength
	    );

	    System.out.println("--- 생성된 프롬프트 ---");
	    System.out.println(prompt);
	    
	    String aiResult = geminiService.callGeminiApi(prompt);
	    
	    // Model 대신 Session에 결과값 저장
	    session.setAttribute("aiResult", aiResult);
	    session.setAttribute("title", title); // 제목도 필요하다면 세션에 저장

	    // 성공 여부와 이동할 URL을 JSON 형태로 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    response.put("redirectUrl", "coverletterResult"); // 이동할 URL
	    
	    return response;
	}
	
	
	
	@GetMapping("coverletterResult")
	public String showCoverletterResult(Model model, HttpSession session) {
	    String aiResult = (String) session.getAttribute("aiResult");
	    String title = (String) session.getAttribute("title");

	    model.addAttribute("aiResult", aiResult);
	    model.addAttribute("title", title);
	    
	    session.removeAttribute("aiResult");
	    session.removeAttribute("title");

	    return "jobTools/coverletterResult";
	}
	
	@GetMapping("coverletterModify")
	public String coverletterModify() {
		return "jobTools/coverletterModify";
	}
	
	@GetMapping("coverletterRefiner")
	public String coverletterRefiner() {
		return "jobTools/coverletterRefiner";
	}
	
	@GetMapping("interviewCreate")
	public String interviewCreate() {
		return "jobTools/interviewCreate";
	}
	
	@GetMapping("interviewResult")
	public String interviewResult() {
		return "jobTools/interviewResult";
	}
	
	@GetMapping("chatbot")
	public String chatbotMain() {
		return "jobTools/chatbot";
	}
}
       
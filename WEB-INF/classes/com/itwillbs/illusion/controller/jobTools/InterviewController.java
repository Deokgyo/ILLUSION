package com.itwillbs.illusion.controller.jobTools;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.tika.Tika;
import org.apache.tika.exception.TikaException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;
import com.itwillbs.illusion.util.AIPromptManager;
import com.itwillbs.illusion.util.JobToolsConstants;
import com.itwillbs.illusion.util.SecurityUtil;


// 면접 예상질문 관련 컨트롤러

@Controller
public class InterviewController {

    @Autowired
    private JobToolsService service;

    @Autowired
    private GeminiService geminiService;
    
    @Autowired
    private AIPromptManager promptManager;

    // ===================================================================
    // 페이지 이동 (GET Mappings)
    // ===================================================================
    
    // 저장된 자소서 가져오기 (덕교)
    @GetMapping("interviewCreate")
    public String interviewCreate(Model model) {
    	int member_idx = SecurityUtil.getLoginUserIndex();
        if (member_idx != -1) {
            List<Map<String, String>> clList = service.getCoverletterTitlesByMember(member_idx);
            model.addAttribute("clList", clList);
        }
        return "jobTools/interviewCreate";
    }
    
    // 생성된 예상 질문 결과 페이지 (덕교)
    @GetMapping("interviewResult")
    public String interviewResult(int cl_idx, Model model) {
    	
    	List<Map<String,String>> interviewResultList = service.selectInterviewResult(cl_idx);
    	model.addAttribute("interviewResultList", interviewResultList);
    	
        return "jobTools/interviewResult";
    }

    // ===================================================================
    // 기능 처리 (POST Mappings - @ResponseBody)
    // ===================================================================
    
    // 면접 예상 질문 생성 ajax 처리(덕교)
    @PostMapping("createInterviewByDirect")
    @ResponseBody
    public String createInterviewByDirect(@RequestParam("data")String data, 
    			@RequestParam("company_name") String company_name, 
    			@RequestParam("cl_title") String cl_title) {
    	
    	// 토큰 차감 로직
    	// 토큰 차감 하려면, member_idx 필요함.. 
    	int member_idx = SecurityUtil.getLoginUserIndex(); // member_idx 
    	// 얼마 차감 해야하는지도 필요함 
    	int cost = JobToolsConstants.COVER_LETTER_INTERVIEW_COST;
    	// 차감 해라 ... 토큰 반환 
    	int crruentTokens = service.deductToken(member_idx, cost);
    	
    	
    	//data도 디비에 인서트 해야함 
        Map<String, Object> originalClMap = buildCoverletterMap(SecurityUtil.getLoginUserIndex(), 
        		cl_title, company_name, data, JobToolsConstants.CL_TYPE_ORIGINAL_FOR_REFINEMENT);
        // 인서트 하고 인서트 후에 생성된 idx 값  받기 
        int cl_idx = service.saveCoverletterOnly(originalClMap);
        
        // 프롬프트에 맞춰서 질문 생성하고 쪼개서 배열로 저장함 
        String prompt = promptManager.createInterviewPrompt(data);
    	String aiResult = geminiService.callGeminiApi(prompt);
    	List<String> splitResult = Arrays.asList(aiResult.split("\n"));
    	
    	// 쪼갠 질문들 디비에 넣기, 질문과 멤버 idx와 cl_idx 같이 들어가야함   
    	service.insertQuestion(splitResult, member_idx, cl_idx);
    	
    	return "interviewResult?cl_idx=" + cl_idx;
    }
    
    @PostMapping("createInterviewByFile")
    @ResponseBody 
    public String createInterviewByFile(@RequestParam MultipartFile file, 
    		@RequestParam("company_name") String company_name, 
			@RequestParam("cl_title") String cl_title) {
    	// 토큰 차감 로직
    	int member_idx = SecurityUtil.getLoginUserIndex(); // member_idx 
    	int cost = JobToolsConstants.COVER_LETTER_INTERVIEW_COST;
    	service.deductToken(member_idx, cost);
    	
    	// 텍스트 추출을 위한 tika 라이브러리 사용 
    	Tika tika = new Tika();
    	try {
    		//멀티 파트 파일 형식을 인풋 스트림으로 변환하고 티카 사용해서 파스 투스트링후 저장
			String coverletter = tika.parseToString(file.getInputStream());
			
			//추출한 텍스트 디비에 인서트 해야함 
	        Map<String, Object> originalClMap = buildCoverletterMap(SecurityUtil.getLoginUserIndex(), 
	        		cl_title, company_name, coverletter, JobToolsConstants.CL_TYPE_ORIGINAL_FOR_REFINEMENT);
	        // 인서트 하고 인서트 후에 생성된 idx 값  받기 
	        int cl_idx = service.saveCoverletterOnly(originalClMap);
			
	        // 프롬프트에 맞춰서 질문 생성하고 쪼개서 배열로 저장함 
	        String prompt = promptManager.createInterviewPrompt(coverletter);
	    	String aiResult = geminiService.callGeminiApi(prompt);
	    	List<String> splitResult = Arrays.asList(aiResult.split("\n"));
	    	
	    	// 쪼갠 질문들 디비에 넣기, 질문과 멤버 idx와 cl_idx 같이 들어가야함   
	    	service.insertQuestion(splitResult, member_idx, cl_idx);
	    	
	    	return "interviewResult?cl_idx=" + cl_idx;
		} catch (IOException | TikaException e) {
			e.printStackTrace();
			// 에러 터지면 에러 페이지롷 이동함 
			return "error";
		}
    	
    }
    
    @PostMapping("createInterviewBySavedCl")
    @ResponseBody
    public String createInterviewBySavedCl(int cl_idx) {
    	// 토큰 차감 로직
    	int member_idx = SecurityUtil.getLoginUserIndex(); // member_idx 
    	int cost = JobToolsConstants.COVER_LETTER_INTERVIEW_COST;
    	service.deductToken(member_idx, cost);
    	// 디비에 저장된 자소서 불러오기 
		Map<String, Object> originalCoverletter = service.getCoverletterById(cl_idx);
		String coverletter = (String) originalCoverletter.get("generated_cl_content");
		String prompt = promptManager.createInterviewPrompt(coverletter);
	    String aiResult = geminiService.callGeminiApi(prompt);
	    List<String> splitResult = Arrays.asList(aiResult.split("\n"));
    	
    	// 쪼갠 질문들 디비에 넣기, 질문과 멤버 idx와 cl_idx 같이 들어가야함   
    	service.insertQuestion(splitResult, member_idx, cl_idx);
    	
    	return "interviewResult?cl_idx=" + cl_idx;
    }
    
    //예상 질문에 대한 사용자 답변 피드백 주기 (덕교)
    @PostMapping("getAiFeedback")
    @ResponseBody 
    public Map<String, String> getAiFeedback(@RequestParam("question") String question, 
    							@RequestParam("answer") String answer ) {
    	String prompt = promptManager.createAIFeedbackPrompt(question, answer);
     	String aiResult = geminiService.callGeminiApi(prompt);
     	Map<String, String> result = new HashMap<String, String>();
     	result.put("feedback", aiResult);
    	return result;
    }
    
    // 예상 질문과 사용자 답변과 피드백 디비에 저장하기 (덕교 ) 
    @PostMapping("saveAnswer") 
    @ResponseBody
    public void saveAnswer(@RequestParam("question_idx") String question_idx, 
    					@RequestParam("answer") String answer_text,
    					@RequestParam("feedback") String ai_feedback) {
    	
    	int member_idx = SecurityUtil.getLoginUserIndex();
    	service.insertAnswer(question_idx, answer_text, ai_feedback, member_idx);
    	
    }

    // ===================================================================
    // Helper Methods
    // ===================================================================
    
    private Map<String, Object> buildCoverletterMap(int memberIdx, String title, String companyName, String aiResult, String clType) {
        Map<String, Object> map = new HashMap<>();
        map.put("member_idx", memberIdx);
        map.put("title", title);
        map.put("company_name", companyName);
        map.put("aiResult", aiResult);
        map.put("generated_char_count", aiResult.length());
        map.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
        map.put("cl_type", clType);
        return map;
    }
}
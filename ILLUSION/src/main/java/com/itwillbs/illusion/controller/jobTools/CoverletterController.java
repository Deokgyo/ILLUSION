package com.itwillbs.illusion.controller.jobTools;

import java.io.IOException;
import java.security.Principal;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.itwillbs.illusion.vo.MemberVO;

@Controller
public class CoverletterController {

    @Autowired
    private JobToolsService service;

    @Autowired
    private GeminiService geminiService;
    
    @Autowired
    private AIPromptManager promptManager;

    // ===================================================================
    // 페이지 이동 (GET Mappings)
    // ===================================================================
    
    // 자소서 생성 페이지 이동
    @GetMapping("coverletterCreate")
    public String coverletterCreate(Model model) {
        model.addAttribute("occupationList", service.getOccupation());
        model.addAttribute("expList", service.getExperience());
        return "jobTools/coverletterCreate";
    }
    
    // 자소서 결과 페이지 이동 (통합)
    @GetMapping("coverletterResult")
    public String showCoverletterResult(Model model, @RequestParam("cl_idx") int cl_idx,
            @RequestParam(value = "original_cl_idx", required = false) Integer original_cl_idx) {
        
        Map<String, Object> coverletter = service.getCoverletterById(cl_idx);
        model.addAttribute("coverletter", coverletter);
        
        // CL002(첨삭된 자소서)인 경우에만 원본 자소서 정보 추가
        if (coverletter != null && "CL002".equals(coverletter.get("cl_type")) && original_cl_idx != null) {
            Map<String, Object> originalCoverletter = service.getCoverletterById(original_cl_idx);
            model.addAttribute("originalCoverletter", originalCoverletter);
        }
        
        return "jobTools/coverletterResult";
    }

    
    // 자소서 다듬기
    @GetMapping("coverletterRefiner")
    public String coverletterRefiner(Model model) {
        int member_idx = SecurityUtil.getLoginUserIndex();
        if (member_idx != -1) {
            List<Map<String, String>> clList = service.getCoverletterTitlesByMember(member_idx);
            model.addAttribute("clList", clList);
        }
        return "jobTools/coverletterRefiner";
    }
    
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
    
    // 자소서 생성
    @PostMapping("coverletterGenerate")
    @ResponseBody
    public Map<String, Object> coverletterGenerate(@RequestParam Map<String, String> params, HttpSession session) {
        try {
            Map<String, Object> serviceResult = service.generateAndSaveCoverletter(params);
            updateSessionToken(session, (Integer) serviceResult.get("newTokenCount"));
            
            int generatedClIdx = (int) serviceResult.get("generatedClIdx");
            
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("redirectUrl", String.format("coverletterResult?cl_idx=%d&original_cl_idx=%d", generatedClIdx, generatedClIdx));
            response.put("newToken", serviceResult.get("newTokenCount"));
            return response;
        } catch (RuntimeException e) {
            return createErrorResponse(e.getMessage());
        }
    }

    // 새 자소서 다듬기
    @PostMapping("refineNewCoverletter")
    @ResponseBody
    public Map<String, Object> refineNewCoverletter(@RequestParam String cl_input_method,
            @RequestParam(required = false) MultipartFile uploadedFile,
            @RequestParam(required = false) String coverletterText, 
            @RequestParam("cl_title")String cl_title,
            @RequestParam("company_name")String company_name,
            HttpSession session) {

        String originalContent = "";
        try {
            if ("file".equals(cl_input_method) && uploadedFile != null && !uploadedFile.isEmpty()) {
                originalContent = new String(uploadedFile.getBytes(), "UTF-8");
            } else if ("text".equals(cl_input_method) && coverletterText != null) {
                originalContent = coverletterText;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return createErrorResponse("파일을 읽는 중 오류가 발생했습니다.");
        }

        if (originalContent.trim().isEmpty()) {
            return createErrorResponse("첨삭할 자기소개서 내용이 비어있습니다.");
        }

        try {
            // 1. 원본 자소서 저장
            Map<String, Object> originalClMap = buildCoverletterMap(SecurityUtil.getLoginUserIndex(), cl_title, company_name, originalContent, JobToolsConstants.CL_TYPE_ORIGINAL_FOR_REFINEMENT);
            int originalClIdx = service.saveCoverletterOnly(originalClMap);

            // 2. 서비스 호출
            Map<String, Object> params = new HashMap<>();
            params.put("original_content", originalContent);
            params.put("member_idx", SecurityUtil.getLoginUserIndex());
            params.put("title", cl_title);
            params.put("company_name", company_name);
            params.put("original_cl_idx", originalClIdx);

            Map<String, Object> result = service.refineAndSaveCoverletter(params);

            updateSessionToken(session, (Integer) result.get("newTokenCount"));

            // 3. 성공 응답 반환
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("redirectUrl", String.format("coverletterResult?cl_idx=%d&original_cl_idx=%d", result.get("refinedClIdx"), result.get("originalClIdx")));
            response.put("newToken", result.get("newTokenCount"));
            return response;

        } catch (RuntimeException e) {
            return createErrorResponse(e.getMessage());
        }
    }
    
    // 저장된 자소서 다듬기
    @PostMapping("refineSavedCoverletter")
    @ResponseBody
    public Map<String, Object> refineSavedCoverletter(@RequestParam int cl_idx, HttpSession session) {
        Map<String, Object> originalCoverletter = service.getCoverletterById(cl_idx);

        String cl_type = (String) originalCoverletter.get("cl_type");
        if (JobToolsConstants.CL_TYPE_REFINED.equals(cl_type)) {
            return createErrorResponse("이미 첨삭된 자소서는 다시 다듬을 수 없습니다.");
        }

        int writer_idx = (Integer) originalCoverletter.get("member_idx");
        int current_member_idx = SecurityUtil.getLoginUserIndex();

        if (writer_idx != current_member_idx) {
            return createErrorResponse("자신이 작성한 자소서만 다듬을 수 있습니다.");
        }

        try {
            Map<String, Object> params = new HashMap<>();
            params.put("original_content", originalCoverletter.get("generated_cl_content"));
            params.put("member_idx", current_member_idx);
            params.put("title", (String) originalCoverletter.get("cl_title"));
            params.put("company_name", (String) originalCoverletter.get("company_name"));
            params.put("original_cl_idx", cl_idx);

            Map<String, Object> result = service.refineAndSaveCoverletter(params);

            updateSessionToken(session, (Integer) result.get("newTokenCount"));

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("redirectUrl", String.format("coverletterResult?cl_idx=%d&original_cl_idx=%d", result.get("refinedClIdx"), result.get("originalClIdx")));
            response.put("newToken", result.get("newTokenCount"));
            return response;
        } catch (RuntimeException e) {
            return createErrorResponse(e.getMessage());
        }
    }
    
    // 저장버튼 토글 기능
    @PostMapping("saveToMypage")
	@ResponseBody
	public Map<String, String> saveToMypage(@RequestParam("cl_idx") int cl_idx) {
		return service.toggleSaveToMypage(cl_idx);
	}

    // ===================================================================
    // Helper Methods
    // ===================================================================
    
    private Map<String, Object> buildCoverletterMap(int memberIdx, String title, String company, String aiResult, String clType) {
        Map<String, Object> map = new HashMap<>();
        map.put("member_idx", memberIdx);
        map.put("title", title);
        map.put("company", company);
        map.put("aiResult", aiResult);
        map.put("generated_char_count", aiResult.length());
        map.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
        map.put("cl_type", clType);
        return map;
    }
    
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

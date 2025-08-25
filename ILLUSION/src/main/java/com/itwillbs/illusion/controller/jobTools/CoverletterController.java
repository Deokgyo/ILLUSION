package com.itwillbs.illusion.controller.jobTools;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.itwillbs.illusion.util.SecurityUtil;
import com.itwillbs.illusion.vo.MemberVO; 

@Controller
public class CoverletterController {
	
	@Autowired
	private JobToolsService service;
	
	@Autowired
	private GeminiService geminiService;

	// ===================================================================
	// 페이지 이동 (GET Mappings)
	// ===================================================================

	@GetMapping("coverletterCreate")
	public String coverletterCreate(Model model) {
		model.addAttribute("occupationList", service.getOccupation());
		model.addAttribute("expList", service.getExperience());
		return "jobTools/coverletterCreate";
	}

	@GetMapping("coverletterResult")
	public String showCoverletterResult(Model model, 
				@RequestParam("cl_idx") int cl_idx,
				@RequestParam("original_cl_idx") int original_cl_idx) {
		
		Map<String, Object> coverletter = service.getCoverletterById(cl_idx);
		Map<String, Object> originalCoverletter = service.getCoverletterById(original_cl_idx);
		
		model.addAttribute("coverletter", coverletter);
		model.addAttribute("originalCoverletter", originalCoverletter);
		
		return "jobTools/coverletterResult";
	}

	@GetMapping("coverletterModify")
	public String coverletterModify() {
		return "jobTools/coverletterModify";
	}

	@GetMapping("coverletterRefiner")
	public String coverletterRefiner(Model model) {
	    int member_idx = SecurityUtil.getLoginUserIndex();
	    if (member_idx != -1) { // -1은 비로그인 상태를 의미 (SecurityUtil에서 설정)
	        List<Map<String, String>> clList = service.getCoverletterTitlesByMember(member_idx);
	        model.addAttribute("clList", clList);
	    }
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

	// ===================================================================
	// 기능 처리 (POST Mappings - @ResponseBody)
	// ===================================================================

	
	// 새로운 자기소개서를 생성하기
	@PostMapping("coverletterGenerate")
    @ResponseBody
	public Map<String, Object> coverletterGenerate(@RequestParam Map<String, String> params, HttpSession session) {
	    String prompt = createGenerationPrompt(params);
	    String aiResult = geminiService.callGeminiApi(prompt);
	    
	    System.out.println(prompt);
	    
	    Map<String, Object> coverletterMap = new HashMap<>();
	    coverletterMap.put("member_idx", SecurityUtil.getLoginUserIndex());
	    coverletterMap.put("title", params.get("title"));
	    coverletterMap.put("company", params.get("company"));
	    coverletterMap.put("aiResult", aiResult);
	    coverletterMap.put("generated_char_count", aiResult.length());
	    coverletterMap.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
	    coverletterMap.put("cl_type", "CL001"); // TODO
	    
	    try {
	        int requiredTokens = 30; 
	        int generatedClIdx = service.useTokenForJobTools(coverletterMap, requiredTokens);
	        
            MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                loginUser.setToken(loginUser.getToken() - requiredTokens);
                session.setAttribute("loginUser", loginUser);
            }
	        
	        // 성공 응답 반환
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", true);
	        response.put("redirectUrl", "coverletterResult?cl_idx=" + generatedClIdx);
	        return response;
	        
	    } catch (RuntimeException e) {
	        // 서비스에서 "토큰 부족" 예외가 발생했을 때 처리
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("message", e.getMessage()); 
	        return response;
	    }
	}
	
	
	// 파일 또는 텍스트로 입력된 새로운 자기소개서를 다듬기
	@PostMapping("refineNewCoverletter")
    @ResponseBody
    public Map<String, Object> refineNewCoverletter(
            @RequestParam String cl_input_method,
            @RequestParam(required = false) MultipartFile uploadedFile,
            @RequestParam(required = false) String coverletterText) { // HttpSession 제거

		Map<String, Object> response = new HashMap<>();
		int member_idx = SecurityUtil.getLoginUserIndex();
	
		// 1. 원본 내용 확정
		String originalContent = "";
		try {
			if ("file".equals(cl_input_method) && uploadedFile != null && !uploadedFile.isEmpty()) {
				originalContent = new String(uploadedFile.getBytes(), "UTF-8");
			} else if ("text".equals(cl_input_method) && coverletterText != null) {
				originalContent = coverletterText;
			}
		} catch (IOException e) {
			e.printStackTrace();
			response.put("success", false);
			response.put("message", "파일을 읽는 중 오류가 발생했습니다.");
			return response;
		}
	
		if (originalContent.trim().isEmpty()) {
			response.put("success", false);
			response.put("message", "첨삭할 자기소개서 내용이 비어있습니다.");
			return response;
		}
	
		try {
			// 2. 원본 자소서를 먼저 DB에 저장 (토큰 차감 없이)
			Map<String, Object> originalClMap = new HashMap<>();
			originalClMap.put("member_idx", member_idx);
			originalClMap.put("title", "원본 자기소개서 (첨삭용)");
			originalClMap.put("aiResult", originalContent);
			originalClMap.put("generated_char_count", originalContent.length());
			originalClMap.put("generated_char_count_no_space", originalContent.replaceAll("\\s", "").length());
			originalClMap.put("cl_type", "CL003"); // '원본' 타입
			int originalClIdx = service.saveCoverletterOnly(originalClMap);
	
			// 3. AI를 통해 첨삭본 생성
			String prompt = createRefinementPrompt(originalContent);
			String aiResult = geminiService.callGeminiApi(prompt);
	
			// 4. 첨삭본 자소서를 저장 (이때 토큰 차감)
			Map<String, Object> refinedClMap = new HashMap<>();
			refinedClMap.put("member_idx", member_idx);
			refinedClMap.put("title", "첨삭된 자기소개서");
			refinedClMap.put("aiResult", aiResult);
			refinedClMap.put("generated_char_count", aiResult.length());
			refinedClMap.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
			refinedClMap.put("cl_type", "CL002"); // '첨삭본' 타입
	
			int requiredTokens = 30;
			int refinedClIdx = service.useTokenForJobTools(refinedClMap, requiredTokens);
	
			// 5. 두 ID를 모두 포함하여 리다이렉트 URL 생성
			String redirectUrl = String.format("coverletterResult?cl_idx=%d&original_cl_idx=%d",
					refinedClIdx,
					originalClIdx);
	
			response.put("success", true);
			response.put("redirectUrl", redirectUrl);
			return response;
	
		} catch (RuntimeException e) {
			// 토큰 부족 또는 기타 런타임 예외 처리
			response.put("success", false);
			response.put("message", e.getMessage());
			return response;
		}
    }
	
	/**
	 * 이미 저장된 자기소개서를 다듬는(첨삭하는) API
	 */
	@PostMapping("refineSavedCoverletter")
	@ResponseBody
	public Map<String, Object> refineSavedCoverletter(@RequestParam int cl_idx) { 
	    
	    Map<String, Object> originalCoverletter = service.getCoverletterById(cl_idx);

		// 자소서 타입을 확인하여 이미 첨삭된 자소서인지 검사
		String cl_type = (String) originalCoverletter.get("cl_type");
		if ("CL002".equals(cl_type)) {
			Map<String, Object> response = new HashMap<>();
			response.put("success", false);
			response.put("message", "이미 첨삭된 자소서는 다시 다듬을 수 없습니다.");
			return response;
		}

	    int writer_idx = (Integer) originalCoverletter.get("member_idx");
	    int current_member_idx = SecurityUtil.getLoginUserIndex();

	    if (writer_idx != current_member_idx) {
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("message", "자신이 작성한 자소서만 다듬을 수 있습니다.");
	        return response;
	    }
	    
	    String originalContent = (String) originalCoverletter.get("generated_cl_content");
	    String prompt = createRefinementPrompt(originalContent);
	    String aiResult = geminiService.callGeminiApi(prompt);
	    
	    Map<String, Object> newCoverletterMap = new HashMap<>();
	    newCoverletterMap.put("member_idx", current_member_idx);
	    newCoverletterMap.put("title", originalCoverletter.get("cl_title") + " (첨삭본)");
	    newCoverletterMap.put("company", (String) originalCoverletter.get("company_name"));
	    newCoverletterMap.put("aiResult", aiResult);
	    newCoverletterMap.put("generated_char_count", aiResult.length());
	    newCoverletterMap.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
	    newCoverletterMap.put("originalCoverletter", originalCoverletter.get("generated_cl_content"));
	    newCoverletterMap.put("cl_type", "CL002"); 
	    
	    try {
	        int requiredTokens = 30; 
	        int generatedClIdx = service.useTokenForJobTools(newCoverletterMap, requiredTokens);
	        
	        // 성공 응답 반환
	        Map<String, Object> response = new HashMap<>();
	        
	        String redirectUrl = String.format("coverletterResult?cl_idx=%d&original_cl_idx=%d", 
                    generatedClIdx, 
                    cl_idx);
	        
	        response.put("success", true);
	        response.put("redirectUrl", redirectUrl);
	        return response;
	        
	    } catch (RuntimeException e) {
	        // 서비스에서 "토큰 부족" 예외가 발생했을 때 처리
	        Map<String, Object> response = new HashMap<>();
	        response.put("success", false);
	        response.put("message", e.getMessage()); 
	        return response;
	    }
	}

	/**
	 * 자소서의 '마이페이지 저장' 상태를 토글하는 API
	 */
	@PostMapping("saveToMypage")
	@ResponseBody
	public Map<String, String> saveToMypage(@RequestParam("cl_idx") int cl_idx) {
	    // TODO: 이 자소서가 현재 로그인한 사용자의 것인지 권한 검사 로직 추가 필요
		
		
		
	    String newStatus = service.toggleSaveToMypage(cl_idx);
	    Map<String, String> map = new HashMap<>();
	    if ("BOL001".equals(newStatus)) {
	        map.put("message", "마이페이지에 저장되었습니다.");
	        map.put("status", "saved");
	    } else {
	        map.put("message", "마이페이지 저장이 취소되었습니다.");
	        map.put("status", "unsaved");
	    }
	    return map;
	}

	// ===================================================================
	// 프롬프트 생성을 위한 헬퍼(Helper) 메소드들
	// ===================================================================


	private String createGenerationPrompt(Map<String, String> params) {
	    String company = params.getOrDefault("company", "해당 없음");
	    String occupation = params.getOrDefault("occupation", "해당 없음");
	    String question = params.getOrDefault("question", "자유 양식");
	    String prevCompany = params.getOrDefault("prevCompany", "해당 없음");
	    String prevJob = params.getOrDefault("prevJob", "해당 없음");
	    String experience = params.getOrDefault("experience", "해당 없음");
	    String keywords = params.getOrDefault("keywords", "해당 없음");
	    String maxLength = params.getOrDefault("maxLength", "1000");
	    String experiencePeriod = params.getOrDefault("experience_period", ""); 
	
	    return String.format(
            "너는 대한민국 최고의 채용 컨설턴트이자 자기소개서 작성 전문가야. "
          + "주어진 핵심 정보를 바탕으로, 지원자의 역량이 최대한 돋보이도록 매력적인 자기소개서를 '완성된 하나의 문단'으로 작성해줘.\n\n"
          + "### 작성 조건:\n"
          + "1. **지원 회사:** %s\n"
          + "2. **지원 직무:** %s\n"
          + "3. **자기소개서 문항:** %s\n"
          + "4. **주요 경력:** %s에서 %s 직무를 %s 동안 수행함\n"
          + "5. **핵심 경험/역량:** %s\n"
          + "6. **필수 포함 키워드:** %s\n"
          + "7. **분량:** 공백 미포함 %s자에 최대한 맞춰서 풍부하게 작성\n\n"
          + "### 글쓰기 스타일 가이드:\n"
          + "- **STAR 기법 활용:** 지원자의 핵심 경험을 서술할 때, '상황(Situation)-과제(Task)-행동(Action)-결과(Result)'가 명확히 드러나도록 구체적이고 논리적으로 작성해줘.\n"
          + "- **직무 연관성 부각:** 경험과 성과가 지원 직무에 어떻게 기여할 수 있을지 명확하게 연결하여 서술해줘.\n"
          + "- **전문적인 어투:** 긍정적이고 자신감 있는 어투를 사용하되, 성과를 구체적인 수치나 사실에 기반하여 진솔하게 표현해줘.\n"
          + "- **가독성:** 문장은 간결하면서도 핵심 내용이 잘 전달되도록 구성하고, 맞춤법과 띄어쓰기를 완벽하게 지켜줘.\n"
          + "- **출력 형식:** 다른 설명이나 제목 없이, 오직 완성된 자기소개서 본문 내용만 출력해줘.",
            company, occupation, question, prevCompany, prevJob, experiencePeriod, experience, keywords, maxLength
	        );
	    }
    
	private String createRefinementPrompt(String originalContent) {
	    return String.format(
	        "너는 대한민국 최고의 커리어 코치이자 자기소개서 첨삭 전문가야. "
	      + "아래의 [자소서 원문]을 '채용 담당자의 관점'에서 깊이 있게 분석하고, 지원자의 역량이 극대화되도록 수정 및 보완한 뒤 구체적인 피드백을 제공해줘.\n\n"
	      + "### 첨삭 지침:\n"
	      + "1. **내용 보강 및 가독성 향상:** 맞춤법, 띄어쓰기, 문법 오류를 교정하고, 길고 복잡한 문장은 간결하게 다듬어줘. 만약 내용이 부족하다면, 직무 역량을 어필할 수 있는 방향으로 내용을 더 풍부하게 보강해줘.\n"
	      + "2. **논리 구조 강화 (STAR 기법):** 경험 서술의 흐름이 '상황(S)-과제(T)-행동(A)-결과(R)'에 따라 명확히 드러나도록 문단 구조를 재배치하거나 연결어를 보강해줘.\n"
	      + "3. **성과 부각 및 수치화:** '노력했다', '기여했다' 같은 추상적인 표현을 '매출 15%% 증대', '프로세스 3일 단축' 등 구체적이고 측정 가능한 성과로 바꾸어 신뢰도를 높여줘.\n"
	      + "4. **직무 연관성 강화:** 지원자의 경험과 역량이 지원 직무에 정확히 어떻게 기여할 수 있는지 직접적이고 명확하게 연결하여 문장을 개선해줘.\n\n"
	      + "### 출력 형식 (매우 중요!):\n"
	      + "아래의 형식을 반드시 정확하게 지켜서 출력해줘. 각 섹션의 제목을 그대로 사용하고, 다른 부가적인 설명은 절대 추가하지 마.\n"
	      + "---[수정된 자기소개서]---\n"
	      + "(여기에 모든 지침이 반영되어, 내용까지 완벽하게 보강된 자기소개서 전체 내용을 작성)\n\n"
	      + "---[핵심 피드백]---\n"
	      + "1. **핵심 성과:** (가장 눈에 띄게 개선된 성과 표현에 대한 피드백과 수정 방향 제시)\n"
	      + "2. **문장 구조:** (논리적 흐름이나 가독성 측면에서 가장 효과적으로 개선된 부분에 대한 피드백과 수정 방향 제시)\n"
	      + "3. **직무 적합성:** (지원 직무와의 연결성이 어떻게 강화되었는지에 대한 피드백과 수정 방향 제시)\n\n"
	      + "### 자소서 원문:\n"
	      + "%s",
	        originalContent
	    );
	}
}
package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.JobToolsMapper;
import com.itwillbs.illusion.util.AIPromptManager;
import com.itwillbs.illusion.util.JobToolsConstants;
import com.itwillbs.illusion.util.PrincipalRefresher;
import com.itwillbs.illusion.util.SecurityUtil;

@Service
public class JobToolsService {
	
	@Autowired
	JobToolsMapper mapper;
	
	@Autowired
	PrincipalRefresher principalRefresher;
    
    @Autowired
    private GeminiService geminiService;
    
    @Autowired
    private AIPromptManager promptManager;
	
	// 직무 대분류 가져오기 
	public List<Map<String, String>> getOccupation() {
		return mapper.getOccupation();
	}
	
	// 직무 소분류 가져오기 
	public List<Map<String, String>> getJobList(String occupation) {
		return mapper.getJobList(occupation);
	}
	
	// 경력 가져오기
	public List<Map<String, String>> getExperience() {
		return mapper.getExperience();
	}
	
	// 유저 토큰 가져오기
	public Integer getMemberToken(int member_idx) {
		return mapper.getMemberToken(member_idx);
	}
	
	// 유저 토큰 수 차감
	@Transactional
	public Map<String, Object> useTokenForJobTools(Map<String, Object> coverletterMap, int requiredTokens) {
		
	    int member_idx = (int) coverletterMap.get("member_idx");
	    
	    // 토큰 차감 
	    int updateCount = mapper.deductToken(member_idx, requiredTokens);
	    if (updateCount == 0) {
	        throw new RuntimeException(JobToolsConstants.ERROR_TOKEN_INSUFFICIENT);
	    }
	    
	    //토큰 있으면 저장 실행 
	    mapper.saveCoverletter(coverletterMap);
	    
	    // 
	    Number generatedId = (Number) coverletterMap.get("cl_idx");

	    if (generatedId == null) {
	        throw new RuntimeException(JobToolsConstants.ERROR_COVERLETTER_SAVE_FAILED);
	    }
		
	    // 차감되고 나서 얼마나 남았는지 ? 
		Integer newTokenCount = mapper.getMemberToken(member_idx);
		
		Map<String, Object> result = new HashMap<>();
		result.put("generatedClIdx", generatedId.intValue());
		result.put("newTokenCount", newTokenCount);
	    
	    // 세션에 변경된 토큰 정보를 즉시 반영
	    principalRefresher.refreshPrincipal();

	    return result;
	}
	
	@Transactional
	public Map<String, Object> useTokenForChatbot(String message, int requiredTokens) {
	    int member_idx = SecurityUtil.getLoginUserIndex();
	    if (member_idx == -1) {
	        throw new RuntimeException(JobToolsConstants.ERROR_LOGIN_REQUIRED);
	    }
	    
	    int updateCount = mapper.deductToken(member_idx, requiredTokens);
	    
	    if (updateCount == 0) {
	        throw new RuntimeException(JobToolsConstants.ERROR_CHATBOT_TOKEN_INSUFFICIENT);
	    }
	    
	    // AI 응답 호출
	    String aiReply = geminiService.callGeminiApi(message);

	    // 갱신된 토큰 정보 조회
	    Integer newTokenCount = mapper.getMemberToken(member_idx);

	    // 결과 맵 생성
	    Map<String, Object> result = new java.util.HashMap<>();
	    result.put("reply", aiReply);
	    result.put("newToken", newTokenCount);

	    // 세션에 변경된 토큰 정보를 즉시 반영
	    principalRefresher.refreshPrincipal();

	    return result;
	}
	    
	
	// 자소서 정보 가져오기
	public Map<String, Object> getCoverletterById(int cl_idx) {
		return mapper.getCoverletterById(cl_idx);
	}
	// 특정 회원의 자소서 목록 조회
	public List<Map<String, String>> getCoverletterTitlesByMember(int member_idx) {
		return mapper.getCoverletterTitlesByMember(member_idx);
	}
	
	
	// 자소서 저장 여부 토글
		public Map<String, String> toggleSaveToMypage(int cl_idx) {
		return mapper.callToggleAndSelectSaveStatus(cl_idx);
	}
	
	// 토큰 차감 없이 자소서만 저장하는 메소드
	public int saveCoverletterOnly(Map<String, Object> map) {
		mapper.saveCoverletter(map);
		Number generatedId = (Number) map.get("cl_idx");
	    if (generatedId == null) {
	        throw new RuntimeException(JobToolsConstants.ERROR_COVERLETTER_SAVE_FAILED);
	    }
	    return generatedId.intValue();
	}
	
	// 진짜 토큰 차감만하는거(덕교) 
	public int deductToken(int member_idx, int cost) {
		Integer newTokenCount = mapper.getMemberToken(member_idx);
		if (newTokenCount < cost) return 0; 
		int result = mapper.deductToken(member_idx, cost);
		if(result>0) principalRefresher.refreshPrincipal();
		return result;
	}
	
	// 생성된 질문 디비에 넣기 (덕교)
	public int insertQuestion(List<String> splitResult, int member_idx, int cl_idx) {
		return mapper.insertQuestion(splitResult, member_idx, cl_idx);
	}
	
	// 면접 예상질문 생성된거 들고오기 (덕교) 
	public List<Map<String,String>> selectInterviewResult(int cl_idx) {
		return mapper.selectInterviewResult(cl_idx);
	}
	
	// 예상질문 답변과 피드백 저장하기 (덕교) 
	public void insertAnswer(String question_idx, String answer_text, String ai_feedback, int member_idx) {
		mapper.insertAnswer(question_idx, answer_text, ai_feedback, member_idx);
	}

	@Transactional
	public Map<String, Object> generateAndSaveCoverletter(Map<String, String> params) {
	    String prompt = promptManager.createGenerationPrompt(params);
	    String aiResult = geminiService.callGeminiApi(prompt);

	    if (JobToolsConstants.AI_SERVICE_UNAVAILABLE.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SERVICE_OVERLOAD);
        } else if (JobToolsConstants.AI_SAFETY_BLOCK.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SAFETY_BLOCK);
        } else if (JobToolsConstants.AI_FAILURE.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SERVICE_FAILED);
        }

	    Map<String, Object> coverletterMap = new HashMap<>();
	    coverletterMap.put("member_idx", SecurityUtil.getLoginUserIndex());
	    coverletterMap.put("title", params.get("title"));
	    coverletterMap.put("company_name", params.get("company"));
	    coverletterMap.put("aiResult", aiResult);
	    coverletterMap.put("generated_char_count", aiResult.length());
	    coverletterMap.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
	    coverletterMap.put("cl_type", JobToolsConstants.CL_TYPE_GENERATED);

	    return useTokenForJobTools(coverletterMap, JobToolsConstants.COVER_LETTER_GENERATION_COST);
	}

	
	@Transactional
	public Map<String, Object> refineAndSaveCoverletter(Map<String, Object> params) {
	    // 1. 파라미터 추출
	    String originalContent = (String) params.get("original_content");
	    int memberIdx = (int) params.get("member_idx");
	    String title = (String) params.get("title");
	    String companyName = (String) params.get("company_name");
	    Integer originalClIdx = (Integer) params.get("original_cl_idx"); // null일 수 있음

	    // 2. AI 호출하여 첨삭된 내용 생성
	    String prompt = promptManager.createRefinementPrompt(originalContent);
	    String aiResult = geminiService.callGeminiApi(prompt);

	    if (JobToolsConstants.AI_SERVICE_UNAVAILABLE.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SERVICE_OVERLOAD);
        } else if (JobToolsConstants.AI_SAFETY_BLOCK.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SAFETY_BLOCK);
        } else if (JobToolsConstants.AI_FAILURE.equals(aiResult)) {
            throw new RuntimeException(JobToolsConstants.ERROR_AI_SERVICE_FAILED);
        }

	    // 3. 첨삭된 자소서를 저장할 Map 생성
	    Map<String, Object> refinedClMap = new HashMap<>();
	    refinedClMap.put("member_idx", memberIdx);
	    refinedClMap.put("title", title + JobToolsConstants.TITLE_REFINED_SUFFIX);
	    refinedClMap.put("company", companyName);
	    refinedClMap.put("aiResult", aiResult);
	    refinedClMap.put("generated_char_count", aiResult.length());
	    refinedClMap.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
	    refinedClMap.put("cl_type", JobToolsConstants.CL_TYPE_REFINED);
	    if (originalClIdx != null) {
	        refinedClMap.put("original_cl_idx", originalClIdx);
	    }

	    // 4. 토큰 사용 및 자소서 저장
	    Map<String, Object> serviceResult = useTokenForJobTools(refinedClMap, JobToolsConstants.COVER_LETTER_REFINEMENT_COST);

	    // 5. 결과 반환
	    Map<String, Object> finalResult = new HashMap<>();
	    finalResult.put("refinedClIdx", serviceResult.get("generatedClIdx"));
	    finalResult.put("originalClIdx", originalClIdx);
	    finalResult.put("newTokenCount", serviceResult.get("newTokenCount"));

	    return finalResult;
	}

	
	
	
}


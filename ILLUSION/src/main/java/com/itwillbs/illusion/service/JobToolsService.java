package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.JobToolsMapper;
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
	        throw new RuntimeException("토큰이 부족하여 작업을 완료할 수 없습니다.");
	    }
	    
	    //토큰 있으면 저장 실행 
	    mapper.saveCoverletter(coverletterMap);
	    
	    // 
	    Number generatedId = (Number) coverletterMap.get("cl_idx");

	    if (generatedId == null) {
	        throw new RuntimeException("자소서 저장 후 PK를 가져오는 데 실패했습니다.");
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
	        throw new RuntimeException("로그인이 필요합니다.");
	    }
	    
	    int updateCount = mapper.deductToken(member_idx, requiredTokens);
	    
	    if (updateCount == 0) {
	        throw new RuntimeException("토큰이 부족하여 챗봇을 이용할 수 없습니다.");
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
		System.out.println("### 서비스 계층에서 받은 ID: " + cl_idx + " ###");
		return mapper.getCoverletterById(cl_idx);
	}
	// 특정 회원의 자소서 목록 조회
	public List<Map<String, String>> getCoverletterTitlesByMember(int member_idx) {
		return mapper.getCoverletterTitlesByMember(member_idx);
	}
	
	
	// 자소서 저장 여부 토글
	public String toggleSaveToMypage(int cl_idx) {
	    mapper.toggleSaveStatus(cl_idx);   // 토글 실행
	    return mapper.selectSaveStatus(cl_idx); // 바뀐 값 조회
	}
	
	// 토큰 차감 없이 자소서만 저장하는 메소드
	public int saveCoverletterOnly(Map<String, Object> map) {
		mapper.saveCoverletter(map);
		Number generatedId = (Number) map.get("cl_idx");
	    if (generatedId == null) {
	        throw new RuntimeException("자소서 저장 후 PK를 가져오는 데 실패했습니다.");
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
	
}


package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.JobToolsMapper;

@Service
public class JobToolsService {
	
	@Autowired
	JobToolsMapper mapper;
	
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
	public boolean useTokenForJobTools(int member_idx, int tokenAmount) {
		Integer currentToken = mapper.getMemberToken(member_idx);
		
		if (currentToken != null && currentToken >= tokenAmount) {
			mapper.deductMemberToken(member_idx, tokenAmount);
			return true;
		}
		return false;
	}
	
	// 자소서 생성 결과 저장
	public int saveCoverletter(Map<String, Object> map) {
		mapper.saveCoverletter(map);
		Number generatedId = (Number) map.get("cl_idx");
		return generatedId.intValue();
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
	
	
}


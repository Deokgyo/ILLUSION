package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface JobToolsMapper {
	 
	public List<Map<String, String>> getOccupation(); // 직무 대분류 값 가져오기
	
	public List<Map<String, String>> getJobList(@Param("occupation") String occupation); // 직무 소분류 값 가져오기
	
	public List<Map<String, String>> getExperience(); // 경력 가져오기
	
	public int saveCoverletter(Map<String, Object> map); // 자소서 저장 
	
	public Map<String, Object> getCoverletterById(@Param("cl_idx") int cl_idx); // 자소서 정보 가져오기
	
	public List<Map<String, String>> getCoverletterTitlesByMember(int member_idx); // 특정 회원의 자소서 목록 조회
	
	// 자소서 저장 여부 수정
	public int toggleSaveStatus(int cl_idx);
	public String selectSaveStatus(int cl_idx);

	public Integer getMemberToken(int member_idx); // 유저 토큰 수 가져오기
	
	public int deductToken(@Param("member_idx") int member_idx, @Param("tokenAmount") int tokenAmount); // 회원 토큰 차감하기
	
	// 생성된 질문 삽입 (덕교)
	public int insertQuestion(@Param("splitResult")List<String> splitResult, @Param("member_idx")int member_idx, @Param("cl_idx")int cl_idx);
	
	// 면접 예상질문 생성된거 들고오기 (덕교) 
	public List<Map<String,String>> selectInterviewResult(int cl_idx);
}

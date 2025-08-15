package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface JobToolsMapper {
	// 직무 대분류 값 가져오기 
	public List<Map<String, String>> getOccupation();
	
	// 직무 소분류 값 가져오기 
	public List<Map<String, String>> getJobList(@Param("occupation") String occupation);
	
	// 경력 가져오기
	public List<Map<String, String>> getExperience();
	
	// 자소서 저장
	public int saveCoverletter(Map<String, Object> map); 
	
	// 자소서 정보 가져오기
	public Map<String, Object> getCoverletterById(@Param("cl_idx") int cl_idx);
	
	// 자소서 저장 여부 수정
	public int saveToMypage(int cl_idx);
}

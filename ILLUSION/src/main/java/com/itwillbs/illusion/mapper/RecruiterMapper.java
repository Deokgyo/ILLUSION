package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.RecruitVO;

@Mapper
public interface RecruiterMapper {
	// 대분류 값 가져오기 
	public List<Map<String, String>> getLocation();
	
	// 소분류 값 가져오기 
	public List<Map<String, String>> getlocDetailList(@Param("location") String location);
	
	// 직무 대분류 값 가져오기 
	public List<Map<String, String>> getOccupation();
	
	// 직무 소분류 값 가져오기 
	public List<Map<String, String>> getJobList(@Param("occupation") String occupation);
	
	// 공고 등록 
	public int insertRecruitment(RecruitVO recruit);
	
	// 공고 목록 가져오기 
	public List<Map<String, Object>> getRecruitmentList(String status);
//	public List<RecruitVO> getRecruitmentList();
	
	// 공고 마감 처리 
	public int recruitClose(int recruit_idx);
	
	public RecruitVO selectRecruitModify(int recruit_idx);
	
}

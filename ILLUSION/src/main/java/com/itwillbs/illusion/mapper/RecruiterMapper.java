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
	public int insertRecruitment(@Param("recruit")RecruitVO recruit, @Param("member_id") String member_id);
	
	// 공고 목록 가져오기 
	public List<Map<String, Object>> getRecruitmentList(@Param("status")String status, @Param("member_id")String member_id);
//	public List<RecruitVO> getRecruitmentList();
	
	// 공고 마감 처리 
	public int recruitClose(int recruit_idx);
	
	// 공고 수정 폼에서 기존값 보여주기 
	public RecruitVO selectRecruitModify(int recruit_idx);
	
	// 공고 수정 업데이트 구ㅡ문 작업 
	public int recruitModify(@Param("recruit")RecruitVO recruit, @Param("member_id") String member_id);
	
	//채용중 공고 갯수 가져오기 
	public String getRecruitmentCnt(String member_id);
	
	//공고 제목과 마감일 가져오기 
	public List<Map<String, Object>> getRecruitmentSubjectDate(String member_id);
	
	//// 기업 이름, 담당자 이름, 담당자 이메일, 마감 임박 공고 개수 가져오기 
	public List<Map<String, String>> getRecruiterInfo(String member_id);
	
}

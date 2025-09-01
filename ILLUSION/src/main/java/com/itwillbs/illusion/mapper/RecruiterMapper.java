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
	
	// 공고 삭제 
	public boolean recruitDelete(int recruit_idx);
	
	// 공고 수정 폼에서 기존값 보여주기 
	public RecruitVO selectRecruitModify(int recruit_idx);
	
	// 공고 수정 업데이트 구ㅡ문 작업 
	public int recruitModify(@Param("recruit")RecruitVO recruit, @Param("member_id") String member_id);
	
	//채용중 공고 갯수 가져오기 
	public String getRecruitmentCnt(String member_id);
	
	//공고 제목과 마감일 가져오기 
	public List<Map<String, Object>> getRecruitmentSubjectDate(String member_id);
	
	//// 기업 이름, 담당자 이름, 담당자 이메일, 마감 임박 공고 개수 가져오기 
	public Map<String, String> getRecruiterInfo(String member_id);
	
	// 미 열람 이력서 수 가져오기 
	public int selectUnViewedCnt(int member_idx) ;
	// 미열람 이력서 상세 보기 클릭시 열람 함으로 바꾸기 
	public void updateIsviewed(int apply_idx);
	// 총 지원자수 가져오기 
	public int selectTotalAppCnt(String member_id);
	
	//미 열람 이력서의 제목, 경력, 학력, 거주지 가져오기 
	public List<Map<String, String>> selectResumeInfo(int member_idx);
	
	// 기업 정보 들고오기 
	public Map<String, String> getCompanyInfo(String member_id);
	
	// 스케줄러 사용해서 주기적으로 공고 마감 처리 
	public void expiredRecruiteClose();
	
	// company_idx 가져오기 
	public int selectCompany_idx(int member_idx);
}

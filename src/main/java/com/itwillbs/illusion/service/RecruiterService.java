package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.mapper.RecruiterMapper;
import com.itwillbs.illusion.vo.RecruitVO;

@Service
public class RecruiterService {
	
	@Autowired
	RecruiterMapper mapper;
	
	// 대분류 값 가져오기 
	public List<Map<String, String>> getLocation() {
		return mapper.getLocation();
	}
	
	//소분류 값 가져오기 
	public List<Map<String, String>> getlocDetailList(String location) {
		return mapper.getlocDetailList(location);
	}
	
	// 직무 대분류 가져오기 
	public List<Map<String, String>> getOccupation() {
		return mapper.getOccupation();
	}
	
	// 직무 소분류 가져오기 
	
	public List<Map<String, String>> getJobList(String occupation) {
		return mapper.getJobList(occupation);
	}
	
	// 공고 등록 
	
	public int insertRecruitment(RecruitVO recruit, String member_id) {
		return mapper.insertRecruitment(recruit, member_id);
	}
	
	// 공고 목록 가져오기 
	public List<Map<String, Object>> getRecruitmentList(String status, String member_id) {
		return mapper.getRecruitmentList(status, member_id);
	}
	
	// 공고 마감 처리 
	public int recruitClose(int recruit_idx) {
		return mapper.recruitClose(recruit_idx);
	}
	
	// 공고 삭제 처리 
	
	public boolean recruitDelete(int recruit_idx) { 
		return mapper.recruitDelete(recruit_idx);
	}
	// 공고 수정 폼에서 기존의 값들 보여주는 용도 
	public RecruitVO selectRecruitModify(int recruit_idx) {
		return mapper.selectRecruitModify(recruit_idx);
	}
	
	// 공고 수정폼 업데이트 구문 작업 
	public int recruitModify(RecruitVO recruit, String member_id) {
		return mapper.recruitModify(recruit, member_id);
	}
	
	//채용 공고 개수 
	public String getRecruitmentCnt(int member_idx) {
		return mapper.getRecruitmentCnt(member_idx);
	}
	//채용 공고 제목과 날짜
	public List<Map<String, Object>> getRecruitmentSubjectDate(int member_idx) {
		return mapper.getRecruitmentSubjectDate(member_idx);
	}
	
	// 기업 이름, 담당자 이름, 담당자 이메일, 마감 임박 공고 개수 가져오기 
	public Map<String, String> getRecruiterInfo(int member_idx) {
		return mapper.getRecruiterInfo(member_idx) ;
		
	}
	
	// 미 열람 이력서 수 가져오기 
	public int selectUnViewedCnt(int member_idx) {
		return mapper.selectUnViewedCnt(member_idx);
	}
	
	
	// 총 지원자 수 가져오기 
	public int selectTotalAppCnt(int member_idx) {
		return mapper.selectTotalAppCnt(member_idx);
	}
	
	//기업 정보 들고오기 
	public Map<String, String> getCompanyInfo(String member_id) {
		return mapper.getCompanyInfo(member_id) ;
	}
	
	//미열람 이력서의 제목, 경력, 학력, 거주지 가져오기 
	public List<Map<String, String>> selectResumeInfo(int member_idx) {
		return mapper.selectResumeInfo(member_idx);
	}
	
	// 미열람 이력서 상세 보기 클릭시 열람 함으로 바꾸기 
	public void updateIsviewed(int apply_idx) {
		mapper.updateIsviewed(apply_idx);
	}
	
	// 스케줄러 사용해서 주기적으로 공고 마감 처리 
	public void expiredRecruiteClose() {
		mapper.expiredRecruiteClose();
	}
	
	// 지원자 관리를 위한 정보 가져오기 
	public List<Map<String, Object>> getApply(int member_idx) {
		return mapper.getApply(member_idx);
	}
	
	// 지원 상태 변경 
	public boolean updateApplyStatus(int apply_idx, String apply_status) {
		return mapper.updateApplyStatus(apply_idx, apply_status);
	}
	
	// company_idx 가져오기 
	public int selectCompany_idx(int member_idx) {
		return mapper.selectCompany_idx(member_idx);
	}
	
	
}

package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.mapper.AdminMapper;
import com.itwillbs.illusion.vo.CommonCodeVO;

@Service
public class AdminService {
	
	@Autowired
	AdminMapper mapper;
	
	// 구직자 수 조회
	public int getApplicantCount() {
		return mapper.getApplicantCount();
	}
	
	// 구인자 수 조회
	public int getEmployerCount() {
		return mapper.getEmployerCount();
	}
	
	// 공고 수 조회
	public int getRecruitCount() {
		return mapper.getRecruitCount();
	}
	// 공고 목록 불러오기 
	public List<Map<String, Object>> getAdminRecruitmentList(String status) {
		return mapper.getAdminRecruitmentList(status);
	}
	// 생성된 ai 자소서 수 조회
	public int getCoverletterCount() {
		return mapper.getCoverletterCount();
	}
	
	// 커뮤니티 게시글 수 조회 (검색 기능 포함)
	public int getBoardCount(String keyword) {
		return mapper.getBoardCount(keyword);
	}
	
	// 회원 정보 조회 (검색 기능 포함)
	public List<Map<String, String>> getMember(String keyword, int startRow, int listLimit){
		return mapper.getMember(keyword, startRow, listLimit);
	}

	// 전체 회원 수 조회 (검색 기능 포함)
	public int getMemberCount(String keyword) {
		return mapper.getMemberCount(keyword);
	}
	
	// 회원 타입 조회
	public List<Map<String, String>> getMemberType() {
		return mapper.getMemberType();
	}
	
	// 회원 상태 조회
	public List<Map<String, String>> getMemberStatus(){
		return mapper.getMemberStatus();
	}
	
	// 회원 상태 타입 수정
	public void updateMemberStatusAndType(Map<String, Object> map) {
		mapper.updateMemberStatusAndType(map);
	}

	// 회원 상세 정보 조회
	public Map<String, Object> getMemberDetail(int member_idx) {
		return mapper.getMemberDetail(member_idx);
	}

	// 회원 삭제
	public void deleteMember(int member_idx) {
		mapper.deleteMember(member_idx);
	}
	
	// 게시글 리스트 조회 (검색 기능 포함)
	public List<Map<String, String>> getBoardList(String keyword, int startRow, int listLimit) {
		return mapper.getBoardList(keyword, startRow, listLimit);
	}
	
	// 게시글 삭제
	public void deleteBoard(int board_idx) {
		mapper.deleteBoard(board_idx);
	}
	
	// 공통코드 리스트 조회
	public List<Map<String, String>> getCommonCodeList(String keyword, int startRow, int listLimit) {
		return mapper.getCommonCodeList(keyword, startRow, listLimit);
	}
	
	// 공통코드 하나 조회
	public Map<String, String> getCommonCode(String code) {
		return mapper.getCommonCode(code);
	}
	
	// 공통코드 수 조회
	public int getCommonCodeCount(String keyword) {
		return mapper.getCommonCodeCount(keyword);
	}

	// 공통코드 수정
	public void updateCommonCode(Map<String, String> param) {
		mapper.updateCommonCode(param);
	}
	
	// 공통코드 그룹 목록 조회
	public List<Map<String, String>> getCommonCodeGroups() {
		return mapper.getCommonCodeGroups();
	}
	
	// 공통코드 그룹 추가
	public void addCommonCodeGroup(Map<String, String> group) {
		mapper.insertCommonCodeGroup(group);
	}
	
	// 공통코드 추가
	public void addCommonCodes(List<CommonCodeVO> codes) {
	    // 비어 있거나 null인 parent_code_id를 null로 설정
	    for (CommonCodeVO code : codes) {
	        if (code.getParent_code_id() != null && code.getParent_code_id().trim().isEmpty()) {
	            code.setParent_code_id(null);
	        }
	    }
	    mapper.insertCommonCodes(codes);
	}

 	// 공통코드 삭제
	public void deleteCommonCode(String code) {
		mapper.deleteCommonCode(code);
	}
	
	// AI 생성 건수 추이 데이터 조회 (차트용)
	public List<Map<String, Object>> getAiUsageChartData() {
		return mapper.getAiUsageChartData();
	}
	
	// 회원가입 추이 데이터 조회 (차트용)
	public List<Map<String, Object>> getMemberSignupChartData() {
		return mapper.getMemberSignupChartData();
	}
	
}

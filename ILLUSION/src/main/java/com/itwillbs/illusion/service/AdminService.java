package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.AdminMapper;

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
	
	// 생성된 ai 자소서 수 조회
	public int getCoverletterCount() {
		return mapper.getCoverletterCount();
	}
	
	// 커뮤니티 게시글 수 조회
	public int getBoardCount() {
		return mapper.getBoardCount();
	}
	
	// 회원 정보 조회
	public List<Map<String, String>> getMember(int startRow, int listLimit){
		return mapper.getMember(startRow, listLimit);
	}

	// 전체 회원 수 조회
	public int getMemberCount() {
		return mapper.getMemberCount();
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
	
	// 공고 리스트 조회
	public List<Map<String, String>> getRecruitment() {
		return mapper.getRecruitment();
	}
	
	// 게시글 리스트 조회
	public List<Map<String, String>> getBoardList(int startRow, int listLimit) {
		return mapper.getBoardList(startRow, listLimit);
	}
	
	// 게시글 삭제
	public void deleteBoard(int board_idx) {
		mapper.deleteMember(board_idx);
	}
	
	// 공통코드 리스트 조회
	public List<Map<String, String>> getCommonCodeList() {
		return mapper.getCommonCodeList();
	}
	
 	
}

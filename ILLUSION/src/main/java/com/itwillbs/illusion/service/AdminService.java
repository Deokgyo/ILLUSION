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
	public List<Map<String, String>> getMember(){
		return mapper.getMember();
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
	public void updateMemberStatusAndType(int member_idx) {
		mapper.updateMemberStatusAndType(member_idx);
	}
 	
}

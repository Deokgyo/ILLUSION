package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	
	public int getApplicantCount(); // 구직자 수 조회
	
	public int getEmployerCount(); // 구인자 수 조회
	 
	public int getRecruitCount(); // 공고 수 조회
	
	public int getCoverletterCount(); // 생성된 ai 자소서 수 조회
	
	public int  getBoardCount(); // 커뮤니티 게시글 수 조회 
	
	public List<Map<String, String>> getMember(); // 회원 정보 조회
	
	public List<Map<String, String>> getMemberType(); // 회원 타입 조회
	
	public List<Map<String, String>> getMemberStatus(); // 회원 상태 조회
	
	public void updateMemberStatusAndType(int member_idx);
}

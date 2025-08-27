package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminMapper {
	
	public int getApplicantCount(); // 구직자 수 조회
	
	public int getEmployerCount(); // 구인자 수 조회
	 
	public int getRecruitCount(); // 공고 수 조회
	
	public int getCoverletterCount(); // 생성된 ai 자소서 수 조회
	
	public int  getBoardCount(); // 커뮤니티 게시글 수 조회 
	
	public List<Map<String, String>> getMember(@Param("startRow") int startRow, @Param("listLimit") int listLimit); // 회원 정보 조회
	
	public int getMemberCount(); // 전체 회원 수 조회
	
	public List<Map<String, String>> getMemberType(); // 회원 타입 조회
	
	public List<Map<String, String>> getMemberStatus(); // 회원 상태 조회
	
	public void updateMemberStatusAndType(Map<String, Object> map); // 회원 상태 타입 수정

	public Map<String, Object> getMemberDetail(int member_idx); // 회원 상세 정보 조회

	public void deleteMember(int member_idx); // 회원 삭제
	
	public List<Map<String, String>> getRecruitment(); // 공고 리스트 조회
	
	public List<Map<String, String>> getBoardList(@Param("startRow") int startRow, @Param("listLimit") int listLimit); // 게리글 리스트 조회
	
	public List<Map<String, String>> getCommonCodeList(); // 공통 코드 리스트 조회
	
	public void deleteBoard(int board_idx); // 공통 코드 삭제
	
	public Map<String, String> getCommonCode(String code); // 공통 코드 하나 조회
	
	public void updateCommonCode(Map<String, String> map); // 공통 코드 수정
	
}

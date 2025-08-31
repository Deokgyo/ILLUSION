package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginMapper {
	
	public Map<String, Object> selectMemberById(String member_id); // 아이디 찾기 - 아이디 반환 

	public Map<String, String> selectMemberId(Map<String, String> params);

	public int selectMemberForPasswordReset(Map<String, String> params); // 비밀번호 재설정을 위한 회원 확인

 	public int updateMemberPassword(Map<String, String> params); //  회원 비밀번호 업데이트

	public int selectMemberByNameAndEmail(Map<String, String> params); // 아이디 찾기 - 이름과 이메일로 회원 존재 여부 확인
	
	public int checkMemberIdAndEmailExists(Map<String, String> params); // 아이디와 이메일로 회원 존재 여부 확인
	
	public boolean isWithdrawnMember(Map<String, String> params); // 이름과 이메일로 탈퇴된 회원인지 확인
	
	public boolean isWithdrawnMemberById(Map<String, String> params); // 아이디와 이메일로 탈퇴된 회원인지 확인
}
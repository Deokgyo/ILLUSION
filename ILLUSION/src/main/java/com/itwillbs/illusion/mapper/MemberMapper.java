package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Mapper
public interface MemberMapper {
	public int checkIdCount(String member_id);
	public int checkId(String id);
	public int insertMember(MemberVO member);
	// 메일 인증 등록 및 수정
	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo);
	// 메일 인증 정보 조회
	public MailAuthInfo selectMailAuthInfo(MailAuthInfo mailAuthInfo);
	// Member 테이블의 mail_auth_status 컬럼을 'Y'로 변경
	public int updateMailAuthStatus(MailAuthInfo mailAuthInfo);
	// mail_auth_info 테이블 row 삭제
	public int deleteMailAuthInfo(MailAuthInfo mailAuthInfo);
<<<<<<< HEAD
=======
	public MemberVO getMemberInfo(String id);
	
	// 아이디로 멤버 idx 조회 
	public MemberVO getMemberById(String member_id); 
	
	// 마이페이지 멤버 전체 조회
	public MemberVO getMemberInfoById(String member_id);
>>>>>>> branch 'main' of https://github.com/Deokgyo/ILLUSION.git
}

package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Mapper
public interface MemberMapper {
	public int checkIdCount(String member_id);
	
	public int insertMember(MemberVO member);
	
	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	public MailAuthInfo selectMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	public int updateMailAuthStatus(MailAuthInfo mailAuthInfo);
	public int deleteMailAuthInfo(MailAuthInfo mailAuthInfo);


	// 조영재
	public MemberVO getMemberInfoById(String id);

	
}

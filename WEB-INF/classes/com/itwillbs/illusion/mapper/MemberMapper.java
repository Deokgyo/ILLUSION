package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Mapper
public interface MemberMapper {
	public int checkIdCount(String member_id);
	
	public int insertMember(MemberVO member);
	
	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	public MailAuthInfo selectMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	public int updateMailAuthStatus(Map<String, String> param);
	
	public int deleteMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	public int countByEmail(String email);
	
	public boolean insertCompanyMember(MemberVO member);
	
	public int checkRecruiterNumber(String recruiterNumber); //사업자 중복체크

	// 조영재
	public MemberVO getMemberInfoById(String id);
	
	public MemberVO getMemberCompanyInfoById(String id);
	
	// 마이페이지 토큰 결제 (이대은)
    public void updateMemberTokens(@Param("memberIdx") int memberIdx, @Param("tokenAmount") int tokenAmount);

    public Integer selectMemberTokens(int memberIdx);

	public boolean isEmailExist(String email);

	
}

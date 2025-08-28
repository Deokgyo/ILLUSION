package com.itwillbs.illusion.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;

@Mapper
public interface CompanyMapper {
	
	public boolean insertMemberCompany(CompanyVo company);

	public MailAuthInfo selectCompanyMailAuthInfo(MailAuthInfo mailAuthInfo);

	public int deleteCompanyMailAuthInfo(MailAuthInfo mailAuthInfo);
	
//	public boolean insertAddress(CompanyVo company);
}

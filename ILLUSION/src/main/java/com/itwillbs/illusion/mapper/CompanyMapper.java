package com.itwillbs.illusion.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;

@Mapper
public interface CompanyMapper {
	
	public boolean insertMemberCompany(CompanyVo company);

	public MailAuthInfo selectCompanyMailAuthInfo(MailAuthInfo mailAuthInfo);

	public int deleteCompanyMailAuthInfo(MailAuthInfo mailAuthInfo);
	
	// 회사 로고 업데이트(덕교) 
	public void updateCompanyLogo(
			@Param("company_idx")int company_idx, 
			@Param("logoTag") String logoTag);
//	public boolean insertAddress(CompanyVo company);
}

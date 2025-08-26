package com.itwillbs.illusion.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.CompanyVo;

@Mapper
public interface CompanyMapper {
	
	public boolean insertMemberCompany(CompanyVo company);
}

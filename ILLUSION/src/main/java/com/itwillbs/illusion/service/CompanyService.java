package com.itwillbs.illusion.service;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.CompanyMapper;
import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.CompanyVo;

@Service
public class CompanyService {
	
	@Autowired
	CompanyMapper mapper;

	public boolean insertMemberCompany(CompanyVo company) {
        return mapper.insertMemberCompany(company);
    }
//	
//	public boolean insertAddress(CompanyVo company) {
//        return mapper.insertAddress(company);
//    }

}

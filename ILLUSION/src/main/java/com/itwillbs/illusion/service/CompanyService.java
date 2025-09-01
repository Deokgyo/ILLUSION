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
	
	// 회사 정보 넣는거 회사 테이블 
	public boolean insertMemberCompany(CompanyVo company) {
		//기본 로고 넣기 (덕교)
    	company.setCompany_logo("<img src='/illusion/resources/mypage_image/profile.png'>");
        return mapper.insertMemberCompany(company);
    }
//	
//	public boolean insertAddress(CompanyVo company) {
//        return mapper.insertAddress(company);
//    }

}

package com.itwillbs.illusion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.ScrapMapper;
import com.itwillbs.illusion.vo.ScrapVO;

@Service
public class ScrapService {
		
	@Autowired
	ScrapMapper mapper;
	
	public List<ScrapVO> getScrapsByMemberId(int member_idx, int startRow, int listLimit){
		return mapper.getScrapsByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getScrapCountByMember (int member_idx) {
		return mapper.getScrapCountByMember(member_idx);
	}
	
}

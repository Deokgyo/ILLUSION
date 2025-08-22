package com.itwillbs.illusion.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.ApplyMapper;
import com.itwillbs.illusion.vo.ApplyVO;

@Service
public class applyService {
		
	@Autowired
	ApplyMapper mapper;
	
	public List<ApplyVO> getApplyByMemberId(int member_idx, int startRow, int listLimit){
		return mapper.getApplyByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getApplyCountByMember (int member_idx) {
		return mapper.getApplyCountByMember(member_idx);
	}
	
}

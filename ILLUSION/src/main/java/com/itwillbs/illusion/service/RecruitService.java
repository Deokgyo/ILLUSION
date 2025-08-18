package com.itwillbs.illusion.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.RecruitMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Service

public class RecruitService {
	
	@Autowired
	RecruitMapper mapper;

	public List<RecruitVO> selectRecruitList(String sort) {
		Map<String, Object> map = new HashMap<>();
		map.put("sort", sort);

		return mapper.selectRecruitList(map);
	}
	
	public RecruitVO selectRecruitIndex(int recruit_idx) {
		return mapper.selectRecruitIndex(recruit_idx);
	}
	
	public List<ApplyVO> applyModal(int recruit_idx){
		return mapper.applyModal(recruit_idx);
	}
	
	public int insertApply(RecruitVO recruit) {
		return mapper.insertApply(recruit);
	}
	
}

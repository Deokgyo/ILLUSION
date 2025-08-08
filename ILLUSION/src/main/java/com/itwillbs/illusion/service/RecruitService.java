package com.itwillbs.illusion.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.RecruitMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Service

public class RecruitService {
	
	@Autowired
	RecruitMapper mapper;

	public List<RecruitVO> selectRecruitList() {

		return mapper.selectRecruitList();
	}
	
	public RecruitVO selectRecruitIndex(int recruit_idx) {
		return mapper.selectRecruitIndex(recruit_idx);
	}
	
	public List<ApplyVO> applyModal(){
		return mapper.applyModal();
	}
	
	public int insertApply(RecruitVO recruit) {
		return mapper.insertApply(recruit);
	}
	
}

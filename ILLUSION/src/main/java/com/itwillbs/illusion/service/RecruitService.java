package com.itwillbs.illusion.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.RecruitMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Service

public class RecruitService {
	
	@Autowired
	RecruitMapper mapper;

    public List<RecruitVO> selectRecruitList(RecruitFilterVO filterVO) {
        
        return mapper.selectRecruitList(filterVO);
    }
	
	public int getBoardListCount(RecruitFilterVO filterVO) {
		return mapper.getBoardListCount(filterVO);
	} 
	
	public RecruitVO selectRecruitIndex(int recruit_idx) {
		return mapper.selectRecruitIndex(recruit_idx);
	}
	
	// 조회수 증가
	public void increaseViewCount(int recruit_idx) {
		mapper.increaseViewCount(recruit_idx);
	}
	
	public List<ApplyVO> applyModal(int recruit_idx){
		return mapper.applyModal(recruit_idx);
	}
	
	public int insertApply(RecruitVO recruit) {
		return mapper.insertApply(recruit);
	}
	
}

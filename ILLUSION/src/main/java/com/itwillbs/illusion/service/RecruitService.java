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
	
	// getClList
	public List<ApplyVO> getClList(int member_idx){
		return mapper.getClList(member_idx);
	}
	
	//getResumeList
	public List<ApplyVO> getResumeList(int member_idx){
		return mapper.getResumeList(member_idx);
	}
	
	public int insertApply(RecruitVO recruit) {
		return mapper.insertApply(recruit);
	}
	
	//작성자가 일치하는지 용도 (덕교 ) 
	public int selectMemberIdx(String member_id) {
		return mapper.selectMemberIdx(member_id);
	}
	
}

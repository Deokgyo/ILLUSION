package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.ApplyMapper;
import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.mapper.ScrapMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Service
public class MypageService {
	
	@Autowired
	MemberMapper memberMapper;
		
	@Autowired
	ScrapMapper scrapMapper;
	
	@Autowired
	ApplyMapper applyMapper;
	
	
	// 마이페이지 스크랩 목록
	public List<ScrapVO> getScrapsByMemberId(int member_idx, int startRow, int listLimit){
		return scrapMapper.getScrapsByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getScrapCountByMember (int member_idx) {
		return scrapMapper.getScrapCountByMember(member_idx);
	}
	
	// 마이페이지 입사지원 목록
	public List<ApplyVO> getApplyByMemberId(int member_idx, int startRow, int listLimit){
		return applyMapper.getApplyByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getApplyCountByMember (int member_idx) {
		return applyMapper.getApplyCountByMember(member_idx);
	}
	
	
}

package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Mapper
public interface RecruitMapper {

	public List<RecruitVO> selectRecruitList(Map<String, Object> map);
	
	public RecruitVO selectRecruitIndex(int recruit_idx);
	
	public List<ApplyVO> applyModal(int recruit_idx);
	
	public int insertApply(RecruitVO recruit);

}

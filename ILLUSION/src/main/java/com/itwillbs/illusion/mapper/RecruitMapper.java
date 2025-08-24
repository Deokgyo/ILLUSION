package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Mapper
public interface RecruitMapper {

	public List<RecruitVO> selectRecruitList(RecruitFilterVO filterVO);
	
	int getBoardListCount(RecruitFilterVO filterVO);
	
	public RecruitVO selectRecruitIndex(int recruit_idx);
	
	public void increaseViewCount(int board_idx); // 조회수 증가
	
	public List<ApplyVO> getClList(@Param("member_idx") int member_idx);
	public List<ApplyVO> getResumeList(@Param("member_idx") int member_idx);
	
	public int insertApply(RecruitVO recruit);
	
	//작성자가 일치하는지 용도 (덕교) 
	public int selectMemberIdx(String member_id);
}

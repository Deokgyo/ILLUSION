package com.itwillbs.illusion.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.ApplyVO;

@Mapper
public interface ApplyMapper {
	
	public List<ApplyVO> getApplyByMemberId(
			@Param("memberIdx") int member_idx, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 스크랩 갯수 조회
	public int getApplyCountByMember(@Param("memberIdx") int member_idx);
}

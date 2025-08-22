package com.itwillbs.illusion.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.ScrapVO;

@Mapper
public interface ScrapMapper {
	
	public List<ScrapVO> getScrapsByMemberId(
			@Param("memberIdx") int member_idx, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 스크랩 갯수 조회
	public int getScrapCountByMember(@Param("memberIdx") int member_idx);
}

package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

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
	
	// 스크랩 추가, 삭제
    int selectScrapCount(Map<String, Object> params);
    int insertScrap(Map<String, Object> params);
    int deleteScrap(Map<String, Object> params);
}

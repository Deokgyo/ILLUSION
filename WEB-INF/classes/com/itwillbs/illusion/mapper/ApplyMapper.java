package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.ApplyVO;

@Mapper
public interface ApplyMapper {
	
	public List<ApplyVO> getApplyByMemberId(
			@Param("memberIdx") int member_idx, 
			@Param("startRow") int startRow, 
			@Param("listLimit") int listLimit);
	
	// 회원의 지원 갯수 조회
	public int getApplyCountByMember(@Param("memberIdx") int member_idx);
	
    // 마이페이지 입사지원 여러건 삭제
	public int deleteApplys(Map<String, Object> params);
}

package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.illusion.vo.BoardVO;

@Mapper
public interface MyPostMapper {
	
	public List<BoardVO> getMyPostByMemberId(Map<String, Object> params);
	
	// 회원의 내가 쓴 글 갯수 조회
	public int getMyPostCountByMember(Map<String, Object> params);
	
    // 마이페이지 입사지원 여러건 삭제
	public int deleteMyPosts(Map<String, Object> params);
}

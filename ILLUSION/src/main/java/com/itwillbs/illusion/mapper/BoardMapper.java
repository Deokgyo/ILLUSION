package com.itwillbs.illusion.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.BoardVO;

@Mapper
public interface BoardMapper {
	
	public List<BoardVO> selectBoardList();
}

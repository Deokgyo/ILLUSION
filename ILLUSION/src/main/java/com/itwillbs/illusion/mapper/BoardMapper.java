package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.BoardVO;

@Mapper
public interface BoardMapper {
	
	List<Map<String, String>> selectBoardList();	// 게시글 전체 선택

	public Map<String, String> selectBoard(int board_idx); // 게시글 하나 선택
	
	public int boardWrite(Map<String, String> map); // 게시글 작성
	
	public List<String> selectCategory();
	
	public List<String> cmtWrite(int board_idx);
}

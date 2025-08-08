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
	
	public int cmtWrite(Map<String, String> map);
	
	public List<Map<String, String>> selectComment(int board_idx);
	
	public int countComment(int board_idx);
}

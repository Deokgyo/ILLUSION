package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.BoardVO;

@Mapper
public interface BoardMapper {
	
	public List<Map<String, String>> selectBoardList(Map<String, String> map);	// 게시글 전체 정보 조회

	public Map<String, String> selectBoard(int board_idx); // 게시글 하나 정보 조회
	
	public int boardWrite(Map<String, String> map); // 게시글 작성
	
	public void boardDelete(int board_idx); // 게시글 삭제
	
	public List<Map<String, String>> selectCategory(); // 카테고리 조회
	
	public void cmtWrite(Map<String, String> map); // 댓글 작성
	
	public List<Map<String, String>> selectComment(int board_idx); // 댓글 조회
	
//	public int countComment(int board_idx); // 댓글 개수 카운트
	
	public void increaseViewCount(int board_idx); // 조회수 증가
	
	public void updateCommentCount(String board_idx);
}

package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.BoardMapper;
import com.itwillbs.illusion.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper mapper;
	
	public List<Map<String, String>> selectBoardList(String categoryCode, String sort) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("categoryCode", categoryCode);
		map.put("sort", sort);
		
		
        return mapper.selectBoardList(map);
    }

	public Map<String, String> selectBoard(int board_idx) {
		return mapper.selectBoard(board_idx);
	}
	
	public int boardWrite(Map<String, String> map) {
		return mapper.boardWrite(map);
	}
	
	public List<Map<String, String>> selectCategory() {
		return mapper.selectCategory();
	}
	
	// 조회수 증가
	public void increaseViewCount(int board_idx) {
		mapper.increaseViewCount(board_idx);
	}
	
	public void boardDelete(int board_idx) {
		mapper.boardDelete(board_idx);
	}
	
	
	/* 댓글관련 영역 */
	
	// 댓글 작성
	@Transactional
	public void cmtWrite(Map<String, String> map){
		mapper.cmtWrite(map);
		mapper.updateCommentCount(map.get("board_idx"));
	}
	
	// 댓글 조회
	public List<Map<String, String>> selectComment(int board_idx){
		return mapper.selectComment(board_idx);
	}
}

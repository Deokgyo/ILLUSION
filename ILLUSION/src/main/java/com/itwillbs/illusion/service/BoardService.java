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
	 
	// 게시글 전체 조회
	public List<Map<String, Object>> selectBoardList(String categoryCode, String sort, String searchKeyword, int startRow, int listLimit) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryCode", categoryCode);
		map.put("sort", sort);
		map.put("searchKeyword", searchKeyword);
		map.put("startRow", startRow);
		map.put("listLimit", listLimit);
		
        return mapper.selectBoardList(map);
    }

	// 게시글 하나 조회
	public Map<String, String> selectBoard(int board_idx) {
		return mapper.selectBoard(board_idx);
	}
	
	// 게시글 상세 조회 (Object 타입 반환)
	public Map<String, Object> boardDetail(int board_idx) {
		Map<String, String> boardStr = mapper.selectBoard(board_idx);
		Map<String, Object> boardObj = new HashMap<>();
		boardObj.putAll(boardStr);
		return boardObj;
	}
	
	// 게시글 작성
	public int boardWrite(Map<String, Object> map) {
		return mapper.boardWrite(map);
	}
	
	// 카테고리 가져오기
	public List<Map<String, String>> selectCategory() {
		return mapper.selectCategory();
	}
	
	// 조회수 증가
	public void increaseViewCount(int board_idx) {
		mapper.increaseViewCount(board_idx);
	}
	
	// 게시물 수정
	public void boardUpdate(Map<String, String> map) {
		mapper.boardUpdate(map);
	}
	
	// 게시글 삭제
	public void boardDelete(int board_idx) {
		mapper.boardDelete(board_idx);
	}
	
	public int getBoardListCount(String categoryCode, String searchKeyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryCode", categoryCode);
		map.put("searchKeyword", searchKeyword);
		
		return mapper.getBoardListCount(map);
	}
	
	
	/* 댓글관련 영역 */
	
	// 댓글 작성
	@Transactional
	public void cmtWrite(Map<String, String> map){
		mapper.cmtWrite(map);
		mapper.updateCommentCount(map.get("board_idx"));
	}
	
	// 댓글 조회
	public List<Map<String, Object>> selectComment(int board_idx, int startRow, int listLimit){
		Map<String, Object> map = new HashMap<>();
	    map.put("board_idx", board_idx);
	    map.put("startRow", startRow);
	    map.put("listLimit", listLimit);
		return mapper.selectComment(map);
	}
	
	// 댓글 삭제
	public void deleteComment(int cmt_idx) {
		mapper.deleteComment(cmt_idx);
	};
	
	// 댓글 개수 가져오기
	public int getCommentCount(int board_idx) {
		return mapper.getCommentCount(board_idx);
	}
	
	public Map<String, Object> getMemberById(String member_id) {
		return mapper.getMemberById(member_id);
	}
}

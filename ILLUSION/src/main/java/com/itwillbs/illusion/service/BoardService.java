package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.BoardMapper;
import com.itwillbs.illusion.vo.BoardVO;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper mapper;
	
	public List<Map<String, String>> selectBoardList() {
        return mapper.selectBoardList();
    }

	public Map<String, String> selectBoard(int board_idx) {
		return mapper.selectBoard(board_idx);
	}
	
	public int boardWrite(Map<String, String> map) {
		return mapper.boardWrite(map);
	}
	
	public List<String> selectCategory() {
		return mapper.selectCategory();
	}
	
	public List<String> cmtWrite(int board_idx){
		return mapper.cmtWrite(board_idx);
	}
}

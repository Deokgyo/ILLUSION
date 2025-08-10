package com.itwillbs.illusion.controller.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.BoardService;

@RestController
@RequestMapping("api/board/{board_idx}")
public class BoardApiController {
	
	@Autowired
	BoardService service;
	
	@DeleteMapping
    public String deleteBoard(@PathVariable int board_idx) {
        // TODO 권한검사
		
        service.boardDelete(board_idx);
        
        return "삭제성공";
    }
	
	@PutMapping
	public String updateBoard(@PathVariable int board_idx) {
//		service.boardUpdate();
		
		return "수정완료";
	}
}

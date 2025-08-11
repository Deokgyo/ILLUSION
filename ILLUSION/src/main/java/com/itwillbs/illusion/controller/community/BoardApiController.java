package com.itwillbs.illusion.controller.community;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	// PutMapping 담에 다시 시도해보기
	@PostMapping
	public String updateBoard(@PathVariable String board_idx,
						      @RequestParam String title,
							  @RequestParam	String content,
							  @RequestParam String category) {
		
		System.out.println(category + "djalsjdlaksj");
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("board_idx", board_idx);
		map.put("title", title);
		map.put("content", content);
		map.put("category", category);
		
		service.boardUpdate(map);
		
		return "수정완료";
	}
}

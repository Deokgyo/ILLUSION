package com.itwillbs.illusion.controller.community;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.BoardService;

@RestController
@RequestMapping("api/boards/{board_idx}/comments")
public class CommentApiController {

	@Autowired
	BoardService service;
	
	// 커뮤니티 게시글 댓글 작성
	@PostMapping
	public void cmtWrite(
						 @PathVariable("board_idx") String board_idx
						,@RequestParam String member_idx
						,@RequestParam String comment) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("comment", comment);
		map.put("board_idx", board_idx);
		map.put("member_idx", member_idx);
		
		service.cmtWrite(map);
	}
	
	
	// 게시글 댓글 목록 조회
	@GetMapping
	public List<Map<String, Object>> getCmtList(@PathVariable("board_idx") String board_idx) {
		return service.selectComment(Integer.parseInt(board_idx));
	}
	
	// 댓글 삭제
	@DeleteMapping("/api/boards/{board_idx}/comments/{cmt_idx}")
	public String deleteComment(
			@PathVariable("board_idx") int board_idx,
			@PathVariable("cmt_idx") int cmt_idx) {
		service.deleteComment(cmt_idx);
		
		return "삭제 성공";
	}
	
}

package com.itwillbs.illusion.controller.community;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.vo.PageInfo;

@RestController
@RequestMapping("api/boards/{board_idx}/comments")
public class CommentApiController {

	@Autowired
	BoardService service;
	
	// 커뮤니티 게시글 댓글 작성
	@PostMapping
	public Map<String, String> cmtWrite(
						 @PathVariable("board_idx") String board_idx
						,@RequestParam String comment
						,Principal principal) {
		
		String member_id = principal.getName();
		Map<String, Object> loginUser = service.getMemberById(member_id);
		int member_idx = (Integer) loginUser.get("member_idx");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("comment", comment);
		map.put("board_idx", board_idx);
		map.put("member_idx", String.valueOf(member_idx));
		
		service.cmtWrite(map);
		
		Map<String, String> response = new HashMap<String, String>();
		response.put("result", "success");
		
		return response;
	}
	
	
	// 게시글 댓글 목록 조회
	@GetMapping
	public Map<String, Object> getCmtList(@PathVariable("board_idx") int board_idx, @RequestParam(defaultValue = "1") int pageNum) {
	    int listLimit = 5; // 한 페이지에 표시할 댓글 수
	    int pageListLimit = 10; // 한 번에 표시할 페이지 번호 수

	    int startRow = (pageNum - 1) * listLimit;
	    int listCount = service.getCommentCount(board_idx);
	    int maxPage = (int) Math.ceil((double) listCount / listLimit);
	    int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
	    int endPage = startPage + pageListLimit - 1;

	    if (endPage > maxPage) {
	        endPage = maxPage;
	    }

	    List<Map<String, Object>> commentList = service.selectComment(board_idx, startRow, listLimit);
	    PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);

	    Map<String, Object> response = new HashMap<>();
	    response.put("comments", commentList);
	    response.put("pageInfo", pageInfo);

	    return response;
	}
	
	// 댓글 삭제
	@DeleteMapping("/{cmt_idx}")
	public String deleteComment(
			@PathVariable("board_idx") int board_idx,
			@PathVariable("cmt_idx") int cmt_idx) {
		service.deleteComment(cmt_idx);
		
		return "삭제 성공";
	}
	
}


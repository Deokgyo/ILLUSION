package com.itwillbs.illusion.controller.community;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.util.SecurityUtil;

@RestController
@RequestMapping("api/board/{board_idx}")
public class BoardApiController {
	
	@Autowired
	BoardService service;
		
	@DeleteMapping
    public String deleteBoard(@PathVariable int board_idx, Principal principal) {
        // 권한 검사: 작성자 본인이거나 관리자여야 삭제 가능
        String loginId = principal.getName();
        String memberType = SecurityUtil.getLoginUserType();
        
        // 게시글 작성자 확인
        Map<String, Object> board = service.boardDetail(board_idx);
        String boardWriterId = (String) board.get("member_id");
        
        // 작성자 본인이거나 관리자(MEM001)인 경우에만 삭제 허용
        if (!loginId.equals(boardWriterId) && !"MEM001".equals(memberType)) {
            throw new RuntimeException("삭제 권한이 없습니다.");
        }
        
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

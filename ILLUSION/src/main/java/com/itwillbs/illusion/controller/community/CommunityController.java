package com.itwillbs.illusion.controller.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.vo.BoardVO;

@Controller
public class CommunityController {
	
	@Autowired
	BoardService service;
	
	// 커뮤니티 메인 페이지 이동 
	@GetMapping("communityMain")
	public String communityMain(Model model, Map<String, String> map) {
	    
	    List<Map<String, String>> boardList = service.selectBoardList();
	    List<String> categoryList = new ArrayList<String>();
		
		categoryList = service.selectCategory();
		
		model.addAttribute("categoryList", categoryList);
	    model.addAttribute("boardList", boardList);
	    
	    return "community/communityMain";
	}
	
	// 커뮤니티 게시글 상세 페이지 이동
	@GetMapping("communityDetail")
	public String communityDetail(Model model, int board_idx) {
		Map<String, String> boardMap = service.selectBoard(board_idx);
		List<Map<String, String>> cmtList = service.selectComment(board_idx);
		int cmtCount = service.countComment(board_idx);
		
		System.out.println(cmtCount);
		
		model.addAttribute("board", boardMap);
		model.addAttribute("cmtList", cmtList);
		model.addAttribute("cmtCount", cmtCount);
		
		return "community/communityDetail";
	}
	
	// 커뮤니티 글 작성 페이지 이동
	@GetMapping("communityWrite")
	public String communityWrite(Model model) {
		
//		List<String> categoryList = new ArrayList<String>();
//		
//		categoryList = service.selectCategory();
//		
//		model.addAttribute("categoryList", categoryList);
		
		return "community/communityWrite";
	}
	
	// 커뮤니티 글 수정 페이지 이동
	@GetMapping("communityModify")
	public String communityModify() {
		return "community/communityModify";
	}
	
	// 커뮤니티 글 작성 
	@PostMapping("boardWrite")
	public String boardWrite(String content, 
							 String title, 
							 String category) {
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("title", title);
		map.put("content", content);
		map.put("category", category);
		
		service.boardWrite(map);
		
		return "redirect:communityMain";
	}

	
	// 커뮤니티 게시글 댓글 작성
	@ResponseBody
	@PostMapping("cmtWrite")
	public void cmtWrite(Model model
						,String board_idx
						,String member_idx
						,@RequestParam("comment") String comment) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("comment", comment);
		map.put("board_idx", board_idx);
		map.put("member_idx", member_idx);
		
		System.out.println(comment);
		System.out.println(board_idx);
		System.out.println(member_idx);
		
		service.cmtWrite(map);
		
//		return "redirect:communityDetail?board_idx=" + board_idx;
	}
	
	@ResponseBody
	@GetMapping("cmtWrite")
	public List<Map<String, String>> getCmtList(String board_idx) {
		return service.selectComment(Integer.parseInt(board_idx));
	}
	
	
	
	
}

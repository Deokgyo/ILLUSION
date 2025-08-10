package com.itwillbs.illusion.controller.community;

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

import com.itwillbs.illusion.service.BoardService;

@Controller
public class CommunityController {
	
	@Autowired
	BoardService service;
	
	// 커뮤니티 메인 페이지 이동 
	@GetMapping("communityMain")
	public String communityMain(Model model, 
								@RequestParam(value="categoryCode", required = false) String categoryCode,
								@RequestParam(value="sort", defaultValue = "latest") String sort) {
		List<Map<String, String>> categoryList = service.selectCategory();
		model.addAttribute("categoryList", categoryList);

		List<Map<String, String>> boardList = service.selectBoardList(categoryCode, sort);
		model.addAttribute("boardList", boardList);

		model.addAttribute("selectedCategoryCode", categoryCode);
		model.addAttribute("sort", sort);

		return "community/communityMain";
	}
	
	// 커뮤니티 게시글 상세 페이지 이동
	@GetMapping("communityDetail")
	public String communityDetail(Model model, int board_idx) {
		
		// 조회수 증가 
		service.increaseViewCount(board_idx);
		
		Map<String, String> boardMap = service.selectBoard(board_idx);
		model.addAttribute("board", boardMap);
		
		return "community/communityDetail";
	}
	
	// 커뮤니티 글 작성 페이지 이동
	@GetMapping("communityWrite")
	public String communityWrite(Model model) {
		
		List<Map<String, String>> categoryList = service.selectCategory();
		model.addAttribute("categoryList", categoryList);
		
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
	
}

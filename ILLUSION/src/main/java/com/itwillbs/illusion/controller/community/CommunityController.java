package com.itwillbs.illusion.controller.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	
	@GetMapping("communityDetail")
	public String communityDetail(Model model, int board_idx) {
		
		Map<String, String> map = service.selectBoard(board_idx);
		
		model.addAttribute("board", map);
		
		return "community/communityDetail";
	}
	
	// 커뮤니티 글 작성 페이지 이동
	@GetMapping("communityWrite")
	public String communityWrite(Model model) {
		
		List<String> categoryList = new ArrayList<String>();
		
		categoryList = service.selectCategory();
		
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
		System.out.println(content);
		System.out.println(title);
		System.out.println(category);
		
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("title", title);
		map.put("content", content);
		map.put("category", category);
		
		service.boardWrite(map);
		
		return "redirect:communityMain";
	}
	
	// 커뮤니티 게시글 댓글 작성
//	@PostMapping("cmtWrite")
//	public String cmtWrite(Model model, int board_idx) {
//		
//		List<String> list = new ArrayList<String>();
//		System.out.println(list + " asdadsada");
//		service.cmtWrite(board_idx);
//		
//		return "redirect:communityDetail?board_idx=${board_idx}";
//	}
	
	
	
	
}

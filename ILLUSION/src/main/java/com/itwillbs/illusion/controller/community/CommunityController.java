package com.itwillbs.illusion.controller.community;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.illusion.service.BoardService;

@Controller
public class CommunityController {
	
	@Autowired
	BoardService service;
	
	// 커뮤니티 메인 페이지 이동 
	@GetMapping("communityMain")
	public String communityMain(Model model) {
		
//		service.selectBoardList();
		
		return "community/communityMain";
	}
	
	// 커뮤니티 글 작성 페이지 이동
	@GetMapping("communityWrite")
	public String communityWrite() {
		return "community/communityWrite";
	}
	
	
	
	@GetMapping("communityModify")
	public String communityModify() {
		return "community/communityModify";
	}
	@GetMapping("communityDetail")
	public String communityDetail() {
		return "community/communityDetail";
	}
	
	
	
}

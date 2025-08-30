package com.itwillbs.illusion.controller.community;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.vo.PageInfo;

@Controller
public class CommunityController {
	
	@Autowired
	BoardService service;
	
	// 커뮤니티 메인 페이지 이동 
	@GetMapping("communityMain")
	public String communityMain(
								Model model, 
								@RequestParam(value="categoryCode", required = false) String categoryCode,
								@RequestParam(value="sort", defaultValue = "latest") String sort,
								@RequestParam(value="searchKeyword", required = false) String searchKeyword,
								@RequestParam(defaultValue = "1") int pageNum) {
		
		// 페이지 네이션
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
		int listCount = service.getBoardListCount(categoryCode, searchKeyword);
		System.out.println("listCount -----------------" + listCount);
		int pageListLimit = 10;
		
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
		
		if (maxPage == 0) {
			maxPage = 1;
		}
		
		int startPage = (pageNum - 1 ) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		model.addAttribute("pageInfo", pageInfo);

		// 카테고리 리스트 가져오기
		List<Map<String, String>> categoryList = service.selectCategory();
		model.addAttribute("categoryList", categoryList);
		
		// 게시글 리스트 가져오기
		List<Map<String, Object>> boardList = service.selectBoardList(categoryCode, sort, searchKeyword, startRow, listLimit);
		model.addAttribute("boardList", boardList);

		model.addAttribute("selectedCategoryCode", categoryCode);
		model.addAttribute("sort", sort);
		model.addAttribute("searchKeyword", searchKeyword);
		
		
		
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
	public String communityModify(Model model,  @RequestParam int board_idx) {
//		model.addAttribute("board_idx", board_idx); 
		
		List<Map<String, String>> categoryList = service.selectCategory();
		model.addAttribute("categoryList", categoryList);
		
		Map<String, String> boardMap = service.selectBoard(board_idx);
		model.addAttribute("board", boardMap);
		
		return "community/communityModify";
	}
	
	// 커뮤니티 글 작성
	@PostMapping("boardWrite")
	public String boardWrite(String content, 
							 String title, 
							 String category,
							 Principal principal) {
		
		String member_id = principal.getName();
		Map<String, Object> loginUser = service.getMemberById(member_id);
	    
	    int member_idx = (Integer) loginUser.get("member_idx");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("title", title);
		map.put("content", content);
		map.put("category", category);
		map.put("member_idx", member_idx);
		
		service.boardWrite(map);
		
		return "redirect:communityMain";
	}
	
}

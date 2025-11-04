package com.itwillbs.illusion.controller.community;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.util.SecurityUtil;
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
	
	// 게시글 삭제 (작성자 및 관리자 권한)
	@DeleteMapping("community/deleteBoard/{board_idx}")
	@ResponseBody
	public Map<String, Object> deleteBoardFromCommunity(@PathVariable int board_idx, Principal principal) {
		Map<String, Object> response = new HashMap<>();
		
		try {
			// 권한 검사: 작성자 본인이거나 관리자여야 삭제 가능
			String loginId = principal.getName();
			String memberType = SecurityUtil.getLoginUserType();
			
			// 게시글 작성자 확인
			Map<String, Object> board = service.boardDetail(board_idx);
			String boardWriterId = (String) board.get("member_id");
			
			// 작성자 본인이거나 관리자(MEM001)인 경우에만 삭제 허용
			if (!loginId.equals(boardWriterId) && !"MEM001".equals(memberType)) {
				response.put("success", false);
				response.put("message", "삭제 권한이 없습니다.");
				return response;
			}
			
			service.boardDelete(board_idx);
			
			response.put("success", true);
			response.put("message", "게시글이 삭제되었습니다.");
			
		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "삭제 중 오류가 발생했습니다.");
		}
		
		return response;
	}
	
}

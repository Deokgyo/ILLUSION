package com.itwillbs.illusion.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.AdminService;
import com.itwillbs.illusion.util.PagingUtil;
import com.itwillbs.illusion.vo.CodeListVO;
import com.itwillbs.illusion.vo.PageInfo;

@Controller
public class AdminController {

	@Autowired
	AdminService service;
	
	
	// 관리자 메인 페이지 이동
	@GetMapping("adminMain")
	public String adminMain(Model model) {
		
		int applicantCnt = service.getApplicantCount(); // 구인자 수 조회
		int employerCnt = service.getEmployerCount(); // 구직자 수 조회
		int recruitCnt = service.getRecruitCount(); // 공고 수 조회
		int coverletterCnt = service.getCoverletterCount(); // 생성된 ai 자소서 조회
		int getBoardCnt = service.getBoardCount(); // 커뮤니티 게시글 수 조회
		
		Map<String, Object> adminMainMap = new HashMap<String, Object>();
		adminMainMap.put("applicantCnt", applicantCnt);
		adminMainMap.put("employerCnt", employerCnt);
		adminMainMap.put("recruitCnt", recruitCnt);
		adminMainMap.put("coverletterCnt", coverletterCnt);
		adminMainMap.put("boardCnt", getBoardCnt);
		
		
		model.addAttribute("mainInfo", adminMainMap);
		
		return "admin/adminMain";
	}
	
	// 관리자 회원 정보 관리 페이지 이동
	@GetMapping("adminMember")
	public String adminMember(Model model, @RequestParam(defaultValue = "1") int pageNum) {
		
		int listLimit = 10; // 한 페이지에 표시할 회원 수
	    int pageListLimit = 10; // 한 번에 표시할 페이지 번호 수

	    int listCount = service.getMemberCount(); // 전체 회원 수 조회
	    PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);

	    int startRow = (pageInfo.getPageNum() - 1) * listLimit;
	    
		List<Map<String, String>> memberInfo = service.getMember(startRow, listLimit);
		List<Map<String, String>> memberType = service.getMemberType();
		List<Map<String, String>> memberStatus = service.getMemberStatus();
	
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("memberType", memberType);
		model.addAttribute("memberStatus", memberStatus);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/adminMember";
	}
	
	// 공고관리 페이지 이동
	@GetMapping("adminRecruitment")
	public String adminRecruitment() {
		
//		List<Map<String, String>> recruitmentMap = service.getRecruitment();
		return "admin/adminRecruitment";
	}
	
	// 게시글 관리 페이지 이동
	@GetMapping("adminCommunity")
	public String adminCommunity(Model model, @RequestParam(defaultValue = "1") int pageNum) {
		
		
		int listLimit = 10; // 한 페이지에 표시할 회원 수
	    int pageListLimit = 10; // 한 번에 표시할 페이지 번호 수

	    int listCount = service.getBoardCount(); // 전체 게시글 수 조회
	    PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);

	    int startRow = (pageInfo.getPageNum() - 1) * listLimit;
		
	    List<Map<String, String>> boardMap = service.getBoardList(startRow, listLimit);
	    
	    model.addAttribute("boardInfo", boardMap);
	    model.addAttribute("pageInfo", pageInfo);
	    
		return "admin/adminCommunity";
	}
	
	@GetMapping("adminSupport")
	public String adminSupport() {
		return "admin/adminSupport";
	}
	
	@GetMapping("adminPayment")
	public String adminPayment() {
		return "admin/adminPayment";
	}
	
	// 공통코드 관리페이지 이동
	@GetMapping("comcodeRegist")
	public String comcodeRegist(Model model, @RequestParam(value = "keyword", required = false) String keyword) {
		
		List<Map<String, String>> commonCodeList = service.getCommonCodeList(keyword);
		System.out.println(commonCodeList);
		
		
		model.addAttribute("commonCodeList", commonCodeList);
		return "admin/comcodeRegist";
	}
	
	// 공통코드 등록 페이지 이동
	@GetMapping("comcodeCommit")
	public String comcodeCommit(Model model) {

		// 공통코드 그룹 목록을 조회하여 모델에 추가
		List<Map<String, String>> codeGroups = service.getCommonCodeGroups();
		model.addAttribute("codeGroups", codeGroups);

		return "admin/comcodeCommit";
	}
	
	// 공통코드 그룹 추가
	@PostMapping("addCommonCodeGroup")
	public String addCommonCodeGroup(@RequestParam Map<String, String> group) {
		service.addCommonCodeGroup(group);
		return "redirect:/comcodeCommit";
	}
	
	// 공통코드 추가
	@PostMapping("addCommonCodes")
	public String addCommonCodes(CodeListVO codeList) {
	    service.addCommonCodes(codeList.getCodes());
	    return "redirect:/comcodeRegist"; 
	}
	
	// 공통코드 수정 페이지 이동
	@GetMapping("comcodeModify")
	public String comcodeModify(@RequestParam("code") String code, Model model) {
	    Map<String, String> commonCode = service.getCommonCode(code);
	    model.addAttribute("code", commonCode);

	    return "admin/comcodeModify"; // 수정 페이지 이동
	}
	
	@GetMapping("adminMemberDetail")
	public String adminMemberDetail(@RequestParam("member_idx") int member_idx, Model model) {
		Map<String, Object> member = service.getMemberDetail(member_idx);
		model.addAttribute("member", member);
		return "admin/adminMemberDetail";
	}
	
	// 회원 상태, 타입 수정 
	@PostMapping("updateMemberStatusAndType")
	@ResponseBody
	public Map<String, String> updateMemberStatusAndType(@RequestParam("member_idx") int member_idx, 
												   @RequestParam("member_type_code") String member_type_code, 
												   @RequestParam("member_status_code") String member_status_code) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_idx", member_idx);
		map.put("member_type_code", member_type_code);
		map.put("member_status_code", member_status_code);
		
		service.updateMemberStatusAndType(map);
		
		Map<String, String> response = new HashMap<String, String>();
		response.put("result", "success");
		
		return response;
	}
	
	// 회원 삭제
	@DeleteMapping("deleteMember/{member_idx}")
	@ResponseBody
	public Map<String, String> deleteMember(@PathVariable("member_idx") int member_idx) {
		service.deleteMember(member_idx);
		
		Map<String, String> res = new HashMap<String, String>();
		res.put("result", "success");
		
		return res;
	}
	
	// 게시글 삭제
	@DeleteMapping("deleteBoard/{board_idx}")
	@ResponseBody
	public Map<String, String> deleteBoard(@PathVariable("board_idx") int board_idx){
		service.deleteBoard(board_idx);
		
		Map<String, String> res = new HashMap<String, String>();
		res.put("result", "success");
		
		return res;
	}
	
	// 공통코드 수정
	@PostMapping("comcodeModify")
	public String updateCommonCode(@RequestParam Map<String, String> param) {
		
		service.updateCommonCode(param); 
		
		return "redirect:/comcodeRegist";
		
	}
	
	// 공통코드 삭제
	@GetMapping("comcodeDelete")
	public String deleteCommonCode(@RequestParam("code") String code) {
		
		service.deleteCommonCode(code);
		
		return "redirect:/comcodeRegist"; 
	}
	
}

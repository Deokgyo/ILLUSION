package com.itwillbs.illusion.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.AdminService;

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
		
		System.out.println(getBoardCnt);
		
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
	public String adminMember(Model model) {
		
		List<Map<String, String>> memberInfo = service.getMember();
		List<Map<String, String>> memberType = service.getMemberType();
		List<Map<String, String>> memberStatus = service.getMemberStatus();
	
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("memberType", memberType);
		model.addAttribute("memberStatus", memberStatus);
		
		return "admin/adminMember";
	}
	
	@GetMapping("adminRecuritment")
	public String adminRecuritment() {
		return "admin/adminRecuritment";
	}
	
	@GetMapping("adminCommunity")
	public String adminCommunity() {
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
	
	@GetMapping("comcodeRegist")
	public String comcodeRegist() {
		return "admin/comcodeRegist";
	}
	
	@GetMapping("adminMemberDetail")
	public String adminMemberDetail() {
		return "admin/adminMemberDetail";
	}
	
	@GetMapping("comcodeCommit")
	public String comcodeCommit() {
		return "admin/comcodeCommit";
	}
	
	// 회원 상태, 타입 수정 
	@PostMapping("updateMemberStatusAndType")
	public String updateMemberStatusAndType(@RequestParam("member_idx") int member_idx) {
		
		service.updateMemberStatusAndType(member_idx);
		
		return "redirect:admin/adminMember";
	}
	
}

package com.itwillbs.illusion.controller.myPage;

import java.security.Principal;
import java.time.LocalTime;
import java.util.List;
import java.util.Map;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.util.PagingUtil;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.BoardVO;
import com.itwillbs.illusion.vo.CoverLetterVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.PageInfo;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.ResumeVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Controller
public class MypageController2 {
	@Autowired
	ResumeService resumeService;

	@Autowired
	BoardService service;
	  
	@Autowired
	MemberService memberService;
	
	@Autowired
	MypageService mypageService;
	

	@GetMapping("myPage")
	public String myPage(Principal principal, Model model) {
		
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		
		MemberVO member = memberService.getMemberInfoById(member_id);
		model.addAttribute("member", member);
	
		return "myPage/myPage";
	}

	/* 이력서 목록 */
	@GetMapping("savedResumeList")
	public String savedResumeList(Principal principal,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
		
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        // 페이징 처리-
        int listLimit = 10; // 한페이지에 10개
		int pageListLimit = 5;
        
        int listCount = mypageService.getResumeListCountByMember(member.getMember_idx());
        
        // static PagingUtil 페이징 전용 유틸리티 클래스 만들어서 페이징 공통으로 쓰게끔
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        // 데이터 조회
        int startRow = (pageNum - 1) * listLimit;
		
		List<ResumeVO> resumeList = mypageService.getResumeListByMemberId(member.getMember_idx(), startRow, listLimit);
		model.addAttribute("resumeList", resumeList);
		model.addAttribute("pageInfo", pageInfo);

		return "myPage/savedResumeList";
	}
	
	/* 이력서 수정 */
	@GetMapping("resumeUpdate")
	public String resumeUpdate() {
		return "myPage/resumeUpdate";
	}

	/* 이력서 수정 */
	@PostMapping("resumeUpdate")
	public String postResumeUpdate() {
		return "redirect:/savedResumeDetail";
	}

	/* 자소서 목록 */
	@GetMapping("savedCLList")
	public String savedCLList(Principal principal,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
		
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        // 페이징 처리-
        int listLimit = 10; // 한페이지에 10개
		int pageListLimit = 5;
        
        int listCount = mypageService.getCLListCountByMember(member.getMember_idx());
        
        // static PagingUtil 페이징 전용 유틸리티 클래스 만들어서 페이징 공통으로 쓰게끔
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        // 데이터 조회
        int startRow = (pageNum - 1) * listLimit;
		
		List<CoverLetterVO> CLList = mypageService.getCLListByMemberId(member.getMember_idx(), startRow, listLimit);
		model.addAttribute("CLList", CLList);
		model.addAttribute("pageInfo", pageInfo);
		return "myPage/savedCLList";
	}
	
	/* 이력서 상세보기 */
	@GetMapping("savedResumeDetail")
	public String savedResumeDetail(Principal principal,
			Model model,
			@RequestParam("resume_idx") int resumeIdx) {
		
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		List<ResumeVO> resume = mypageService.savedResumeDetail(resumeIdx);
		
		model.addAttribute("resume", resume);
		
		return "myPage/savedResumeDetail";
	}

	/* 자소서 상세보기 */
	@GetMapping("savedCLDetail")
	public String savedCLDetail() {
		return "myPage/savedCLDetail";
	}

	/* 면접예상질문 리스트 */
	@GetMapping("savedQuestionList")
	public String savedQuestionList(Model model) {
		List<Map<String, Object>> questList = resumeService.selectquestList();
		model.addAttribute("QuestList", questList);

		return "myPage/savedQuestionList";
	}

	/* 스크랩공고 목록 */
	@GetMapping("scraprecruitList")
	public String scraprecruitList(Principal principal,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
		
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        // 페이징 처리-
        int listLimit = 10; // 한페이지에 10개
		int pageListLimit = 5;
        
        int listCount = mypageService.getScrapCountByMember(member.getMember_idx());
        
        // static PagingUtil 페이징 전용 유틸리티 클래스 만들어서 페이징 공통으로 쓰게끔
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        // 데이터 조회
        int startRow = (pageNum - 1) * listLimit;
		
		List<ScrapVO> scrapList = mypageService.getScrapsByMemberId(member.getMember_idx(), startRow, listLimit);
		model.addAttribute("scrapList", scrapList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "myPage/scraprecruitList";
	}

	/* 입사지원현황 */
	@GetMapping("jobapplicationlist")
	public String jobapplicationlist(Principal principal,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
			
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        // 페이징 처리-
        int listLimit = 10; // 한페이지에 10개
		int pageListLimit = 5;
        
        int listCount = mypageService.getApplyCountByMember(member.getMember_idx());
        
        // static PagingUtil 페이징 전용 유틸리티 클래스 만들어서 페이징 공통으로 쓰게끔
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        // 데이터 조회
        int startRow = (pageNum - 1) * listLimit;
		
		List<ApplyVO> applyList = mypageService.getApplyByMemberId(member.getMember_idx(), startRow, listLimit);
		
		model.addAttribute("applyList", applyList);
		model.addAttribute("pageInfo", pageInfo);
		
		
		return "myPage/jobapplicationlist";
	}

	/* 내가쓴글 */
	@GetMapping("myPost")
	public String myPost(Principal principal,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam(defaultValue = "BRD001") String categoryCode,
			Model model) {

		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        // 페이징 처리-
        int listLimit = 10; // 한페이지에 10개
		int pageListLimit = 5;
        
        int listCount = mypageService.getMyPostCountByMember(member.getMember_idx(), categoryCode);
        
        // static PagingUtil 페이징 전용 유틸리티 클래스 만들어서 페이징 공통으로 쓰게끔
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        // 데이터 조회
        int startRow = (pageNum - 1) * listLimit;
        
		List<Map<String, String>> categoryList = service.selectCategory();
		
		List<BoardVO> myPostList = mypageService.getMyPostByMemberId(member.getMember_idx(), categoryCode, startRow, listLimit);
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("myPostList", myPostList);
		model.addAttribute("pageInfo", pageInfo);

		return "myPage/myPost";
	}

	/* 토큰 결제 */
	@GetMapping("tokenpay")
	public String tokenpay() {
		return "myPage/tokenpay";
	}
	
	/* 환불 정책 */
	@GetMapping("refundPolicy")
	public String refundPolicy() {
		return "myPage/refundPolicy";
	}


}

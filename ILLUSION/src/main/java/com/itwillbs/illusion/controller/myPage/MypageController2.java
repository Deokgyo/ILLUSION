package com.itwillbs.illusion.controller.myPage;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.print.DocFlavor.STRING;
import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.BoardService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.util.PagingUtil;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.BoardVO;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.CoverLetterVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.PageInfo;
import com.itwillbs.illusion.vo.QuestionVO;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.ResumeVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Controller
public class MypageController2 {
	@Autowired
	ResumeService resumeService;
	
	// 업로드 경로(이클립스 프로젝트 상의 경로)
	String virtualPath = "/resources/upload";

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
		
        // 페이징 처리
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
	
	/*이력서 등록, 수정*/
	@GetMapping("resumeModify")
	public String resumeModifyForm(Principal principal, Model model, 
			@RequestParam(required = false) Integer resume_idx) {
		
		String id = principal.getName();
		
		MemberVO member = resumeService.SelectM(id);
		model.addAttribute("member", member);
		
		if(member == null) {
			return "home/login";
		}
		
	    ResumeVO resume = resumeService.getResumeForEdit1(resume_idx, member.getMember_idx()); // 본인 확인 로직 포함
	    ResumeVO exp = resumeService.getExpForEdit(resume_idx);
	    
	    model.addAttribute("resume", resume);
	    model.addAttribute("exp", exp);
		
		List<CommonCodeVO> degreeList = resumeService.getCodes("DEGREE");
		List<CommonCodeVO> experienceList = resumeService.getCodes("EXPERIENCE");
		List<CommonCodeVO> occupationList = resumeService.getCodes1("OCCUPATION");
		List<CommonCodeVO> positionList = resumeService.getCodes("POSITION");
		
		model.addAttribute("degreeList", degreeList);
        model.addAttribute("experienceList", experienceList);
        model.addAttribute("occupationList", occupationList);
        model.addAttribute("positionList", positionList);
        
		
		return "myPage/resumeModify";
	}
	
	@PostMapping("resumeModify")
	public String resumeModify(@RequestParam Map<String, Object> paramMap
								, HttpSession session
								,HttpServletRequest req
								, @RequestParam("resume_img") MultipartFile file1
								,Principal principal
								) {
		
	    // --- 1. 본인 확인 (수정 권한 체크) ---
	    if (principal == null) { return "redirect:/login"; }
	    
	    // form에서 넘어온 resume_idx를 가져옴 (반드시 String으로 먼저 받아야 함)
	    String resumeIdxStr = (String) paramMap.get("resume_idx"); 
	    if (resumeIdxStr == null || resumeIdxStr.isEmpty()) {
	        return "redirect:/savedResumeList";
	    }
	    int resumeIdx = Integer.parseInt(resumeIdxStr);
		
		
		//1.가상의 경로에 대한 서버상의 실제 경로 알아내기
		String realPath =req.getServletContext().getRealPath(virtualPath);
		System.out.println(realPath);
		
		//2.업로드 경로관리
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		
		// 3. 파일 처리
		Map<String, String> savedFiles = new HashMap<>();
		MultipartFile[] files = {file1};
		String[] keys = {"resume_img"};
	    
	    for (int i = 0; i < files.length; i++) {
	        MultipartFile mFile = files[i];
	        if (!mFile.isEmpty()) {
	            String fileName = UUID.randomUUID().toString() + "_" + mFile.getOriginalFilename();
	            savedFiles.put(keys[i], subDir + "/" + fileName);
	            try {
	                mFile.transferTo(new File(realPath, fileName));
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    
	    // 4. Map에 파일 경로 추가
	    paramMap.putAll(savedFiles);
	    System.out.println("============================");
	    System.out.println(paramMap);
	    
		resumeService.updateResumeAndExpInfo(paramMap);
		
		return "redirect:/savedResumeDetail?resume_idx=" + resumeIdx;
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
		
        int listLimit = 10;
		int pageListLimit = 5;
        
        int listCount = mypageService.getCLListCountByMember(member.getMember_idx());
        
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
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
	public String savedQuestionList(Principal principal,
			Model model,
			@RequestParam(defaultValue = "1") int pageNum,
			@RequestParam("cl_idx") int clIdx) {
		
		// 방어 코드
		if(principal == null) {
			return "home/login";
		}
		
		String member_id = principal.getName();
		MemberVO member = memberService.getMemberInfoById(member_id);
		
        int listLimit = 10;
		int pageListLimit = 5;
        
        int listCount = mypageService.getQuestionListCountByMember(member.getMember_idx());
        
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
        int startRow = (pageNum - 1) * listLimit;
		
		List<QuestionVO> QuestionList = mypageService.getQuestionListByMemberId(
		member.getMember_idx(), clIdx, startRow, listLimit);
		
		
		model.addAttribute("QuestionList", QuestionList);
		model.addAttribute("pageInfo", pageInfo);

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
		
        int listLimit = 10;
		int pageListLimit = 5;
        
        int listCount = mypageService.getScrapCountByMember(member.getMember_idx());
        
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
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
		
        int listLimit = 10;
		int pageListLimit = 5;
        
        int listCount = mypageService.getApplyCountByMember(member.getMember_idx());
        
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
        
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
		
        int listLimit = 10;
		int pageListLimit = 5;
        
        int listCount = mypageService.getMyPostCountByMember(member.getMember_idx(), categoryCode);
        
        PageInfo pageInfo = PagingUtil.getPageInfo(pageNum, listLimit, pageListLimit, listCount);
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
	
	private String createDirectories(String realPath) {
		// Date 또는 LocalXXX 클래스 활용
		
		// 1. LocalXXX 클래스 활용
		// => 날짜 정보: LocalDate, 시간정보: LocalTime, 날짜 및 시간: LocalDateTime
		LocalDate today = LocalDate.now();
		// 2025-07-28
		
		// 2. 날짜 포멧을 디렉토리 형식에 맞게 변경 (ex. 2025-01-06 -> 2025/01/06)
		String datePattern = "yyyy/MM/dd";
		
		// 3. 지정한 포멧을 적용하여 날짜 형식 변경
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dtf);
		
		// 4. 기존 실제 업로드 경로에 서브디렉토리 결합
		realPath += "/" + subDir;
		
		try {
			// 5. 해당 디렉토리를 실제 경로상에 생성
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출하여 Path 객체 리턴
			Path path = Paths.get(realPath);
			
			// 5-2) Files 클래스의 createDirectories() 호출하여 실제 경로 생성
			Files.createDirectories(path);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return subDir;
	}


}

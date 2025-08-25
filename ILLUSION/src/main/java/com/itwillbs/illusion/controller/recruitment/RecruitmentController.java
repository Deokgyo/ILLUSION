package com.itwillbs.illusion.controller.recruitment;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.RecruitService;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.PageInfo;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class RecruitmentController {
	
	// 업로드 할 가상 경로 
	String virtualPath = "/resources/upload";
	
	@Autowired
	RecruitService service;
	
	@Autowired
	CommonCodeService commonCodeService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MypageService mypageService;
	
	// 채용정보 페이지 이동
	@GetMapping("recruitmentInfo")
	public String recruitmentInfo(@ModelAttribute RecruitFilterVO filterVO,
			@RequestParam(defaultValue = "1") int pageNum,
			Model model) {
		
		// 페이징 처리 계산
		// ------------------------------------------------
		int listLimit = 12; // 페이지 당 게시물 수
		int pageListLimit = 5; // 하단 페이지 번호 수

	    // 1. 필터링된 전체 게시물 갯수를 정확히 조회
	    int listCount = service.getBoardListCount(filterVO);
	    
	    // 2. 최대 페이지 번호 계산
	    int maxPage = (int) Math.ceil((double) listCount / listLimit);
	    
	    // 3. 시작 페이지 번호 계산
	    int startPage = ((pageNum - 1) / pageListLimit) * pageListLimit + 1;
	    
	    // 4. 끝 페이지 번호 계산
	    int endPage = startPage + pageListLimit - 1;
	    
	    // 5. 만약 끝 페이지가 최대 페이지보다 크면, 끝 페이지를 최대 페이지로 교체
	    if (endPage > maxPage) {
	        endPage = maxPage;
	    }
	    
	    PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage, pageNum);
		
        int startRow = (pageNum - 1) * listLimit;
        filterVO.setStartRow(startRow);
        filterVO.setListLimit(listLimit);

		// 필터와 페이징 정보가 모두 담긴 DTO로 최종 목록 조회
		List<RecruitVO> recruitList = service.selectRecruitList(filterVO);
		
		model.addAttribute("recruitList", recruitList);   // 화면에 표시할 목록
		model.addAttribute("pageInfo", pageInfo);         // 페이지네이션 UI를 위한 정보
		
		// -----------------------------------------------
        // 2. 필터 UI를 위한 대분류 목록 가져오기
        Map<String, List<CommonCodeVO>> filterOptions = commonCodeService.getFilterOptionsForRecruit();
        model.addAttribute("filterOptions", filterOptions);

        // 3. 현재 필터/정렬 상태를 View에 전달
		model.addAttribute("selectedFilters", filterVO);
		
		
		return "recruitment/recruitmentInfo";
	}
	
	// 채용공고 상세페이지 이동
	@GetMapping("recruitmentDetail")
	public String recruitmentDetail(int recruit_idx, Model model, Principal principal) {
	    // 조회수 증가 
	    service.increaseViewCount(recruit_idx);

	    // 공고 내용 가져오기 
	    RecruitVO recruit = service.selectRecruitIndex(recruit_idx);
	    model.addAttribute("recruit", recruit);
	    
	    
	    // 사용자 스크랩 상태 확인 (기본값 false)
	    boolean isScrapped = false;
	    if (principal != null) {
	        // 로그인 상태이면, 현재 사용자가 이 공고를 스크랩했는지 확인
	        String memberId = principal.getName();
	        MemberVO member = memberService.getMemberInfoById(memberId);
	        if (member != null) {
	        	isScrapped = mypageService.isScrapped(member.getMember_idx(), recruit_idx);
	        }
	    }
	    
	    model.addAttribute("isScrapped", isScrapped);

	    int member_idx = -1;
	    String member_id = "";

	    if (principal != null) {
	        member_id = principal.getName();
	        member_idx = service.selectMemberIdx(member_id);

	        // 작성자 여부 판별
	        boolean isAuthor = recruit.getRecruiter_member_idx() == member_idx;
	        model.addAttribute("isAuthor", isAuthor);
	        
			// 모달에 넘겨줄 정보들
			List<ApplyVO> clList = service.getClList(member_idx);
			List<ApplyVO> resumeList = service.getResumeList(member_idx);
			model.addAttribute("clList", clList);
			model.addAttribute("resumeList", resumeList);
	        
	    } else {
	        // 비회원 → 작성자 아님
	        model.addAttribute("isAuthor", false);
	    }

	    model.addAttribute("memberIdx", member_idx);
	    model.addAttribute("memberId", member_id);

	    return "recruitment/recruitmentDetail";
	}
	
	
	
//	@GetMapping("applyModal")
//	public String applyModal(int recruit_idx, Model model,Principal principal) {
//
//		return "recruitment/applyModal";
//	}

	
	@PostMapping("apply")
	public String apply(ApplyVO apply
			, HttpServletRequest req
			, Principal principal) {
		
		System.out.println("멤버 idx 넘어오나.....");
		System.out.println(apply.getMember_idx());
		
		
		String realPath = req.getServletContext().getRealPath(virtualPath);
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		MultipartFile file = apply.getApply_file();
		
		String fileName = "";
		String origin = file.getOriginalFilename();
		
		// 파일 이름 난수 넣어서 저장함 
		if(!origin.equals("")) {
			fileName = UUID.randomUUID().toString() + "_" + origin;
		}
		
		// 난수포함된 파일을 실제로 파일로 옮기는 작업 
		try {
			if(!file.getOriginalFilename().equals("")) {
				file.transferTo(new File(realPath, fileName));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		apply.setApply_files_path(subDir + "/" + fileName);
		
		int insertCnt = service.insertApply(apply);
		
		return "redirect:/recruitmentDetail?recruit_idx=" + apply.getRecruit_idx();
	}
	
	private String createDirectories(String realPath) {
		LocalDate today = LocalDate.now();
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dft = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dft);
		realPath += "/" + subDir;
		try {
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출 Path 객체 리턴 
			Path path = Paths.get(realPath);
			// 5-2) Files 클래스의 createDirectories() 호출하여 실제 경로 생성 
			Files.createDirectories(path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subDir;
	}
	
}

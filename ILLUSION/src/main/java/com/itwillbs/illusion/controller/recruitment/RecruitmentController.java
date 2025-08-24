package com.itwillbs.illusion.controller.recruitment;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.service.RecruitService;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.PageInfo;
import com.itwillbs.illusion.vo.RecruitFilterVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class RecruitmentController {
	
	@Autowired
	RecruitService service;
	
	@Autowired
	CommonCodeService commonCodeService; 
	
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
		
		System.out.println("@#%#@%@%@#%@#%#@%#@%");
		System.out.println(filterVO);
		
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
			System.out.println("여기에 뭐들어있냐");
			System.out.println(clList);
			System.out.println(resumeList);
	        
	    } else {
	        // 비회원 → 작성자 아님
	        model.addAttribute("isAuthor", false);
	    }

	    model.addAttribute("memberIdx", member_idx);
	    model.addAttribute("memberId", member_id);

	    return "recruitment/recruitmentDetail";
	}
	
	@GetMapping("applyModal")
	public String applyModal(int recruit_idx, Model model,Principal principal) {

		return "recruitment/applyModal";
	}
	
//	@PostMapping("applyModal")
//	public String applyModalSave(RecruitVO recruit ,int recruit_idx, Model model) {
//		
//		int insertCnt = service.insertApply(recruit);
//		
//		return "redirect:/recruitmentDetail?recruit_idx=" + recruit_idx;
//	}
	
	
}

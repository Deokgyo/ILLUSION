package com.itwillbs.illusion.controller.recruitment;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.BoardService;
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
			Model model) {
		
		// 1. DTO를 Service로 전달하여 필터링된 목록을 가져옴
		List<RecruitVO> recruitList = service.selectRecruitList(filterVO); // 메소드명 통일
		model.addAttribute("recruitList", recruitList);
		
        // 2. 필터 UI를 위한 대분류 목록 가져오기
        Map<String, List<CommonCodeVO>> filterOptions = commonCodeService.getFilterOptionsForRecruit();
        model.addAttribute("filterOptions", filterOptions);

        // 3. 현재 필터/정렬 상태를 View에 전달
		model.addAttribute("selectedFilters", filterVO);
		
		return "recruitment/recruitmentInfo";
	}
	
	// 채용공고 상세페이지 이동
	@GetMapping("recruitmentDetail")
	public String recruitmentDetail(int recruit_idx, Model model) {
		
		RecruitVO recruit = service.selectRecruitIndex(recruit_idx);
		model.addAttribute("recruit", recruit);
		
		List<ApplyVO> apply = service.applyModal(recruit_idx);
		model.addAttribute("apply", apply);
		
		return "recruitment/recruitmentDetail";
	}
	
	@GetMapping("applyModal")
	public String applyModal(Model model) {
//		List<ApplyVO> apply = service.applyModal();
//		model.addAttribute("apply", apply);
		
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

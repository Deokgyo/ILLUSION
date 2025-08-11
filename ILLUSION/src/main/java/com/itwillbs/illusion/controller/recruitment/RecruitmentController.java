package com.itwillbs.illusion.controller.recruitment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.RecruitService;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class RecruitmentController {
	
	@Autowired
	RecruitService service;
	
	// 채용정보 페이지 이동
	@GetMapping("recruitmentInfo")
	public String recruitmentInfo(Model model,
			 @RequestParam(value="sort", defaultValue="latest") String sort) {
		
		// 채용정보 리스트 model에 담기
		List<RecruitVO> recruitList = service.selectRecruitList(sort);
		model.addAttribute("recruitList", recruitList);
		model.addAttribute("sort", sort);
		
		System.out.println("@#%#@%#@%");
		System.out.println(sort);
		
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
	
	@PostMapping("applyModal")
	public String applyModalSave(RecruitVO recruit ,int recruit_idx, Model model) {
		
		int insertCnt = service.insertApply(recruit);
		
		return "redirect:/recruitmentDetail?recruit_idx=" + recruit_idx;
	}
	
	
}

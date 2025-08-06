package com.itwillbs.illusion.controller.recruitment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.illusion.service.RecruitService;
import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class RecruitmentController {
	
	@Autowired
	RecruitService service;
	
	// 채용정보 페이지 이동
	@GetMapping("recruitmentInfo")
	public String recruitmentInfo(Model model) {
		
		// 채용정보 리스트 model에 담기
		List<RecruitVO> recruitList = service.selectRecruitList();
		model.addAttribute("recruitList", recruitList);
		
		return "recruitment/recruitmentInfo";
	}
	
	// 채용공고 상세페이지 이동
	@GetMapping("recruitmentDetail")
	public String recruitmentDetail(int recruit_idx, Model model) {
		
		RecruitVO recruit = service.selectRecruitIndex(recruit_idx);
		
		System.out.println("@!$@!$!@$");
		System.out.println(recruit);
		
		model.addAttribute("recruit", recruit);
		
		return "recruitment/recruitmentDetail";
	}
}

package com.itwillbs.illusion.controller.recruiter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.handler.recruiter.CodeGroups;
import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.service.RecruiterService;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.RecruitVO;

@Controller
public class RecruiterController {
	
	@Autowired
	RecruiterService service;
	@Autowired
	CommonCodeService comService;
	
	// 기업 메인 페이지로 이동 
	@GetMapping("recruiterMain") 
	public String recruiterMain() {
		return "recruiter/recruiterMain"; 
	}
	@GetMapping("recruiterMainLogin") 
	public String recruiterMainLogin() {
		return "recruiter/recruiterMainLogin"; 
	}
	
	// 기업 정보 수정으로 이동 
	@GetMapping("recruiterInfo")
	public String recruiterInfo() {
		return "recruiter/recruiterInfo";
	}
	
	// 기업 회원이 작성한 목록 페이지로 이동
	@GetMapping("recruiterList")
	public String recruiterList() {
		return "recruiter/recruiterList";
	}
	
	@GetMapping("recruitClose")
	public String recruitClose(int recruit_idx) {
		service.recruitClose(recruit_idx);
		return "redirect:/recruiterList";
	}
	
	// =======================================================================
	// 							공고 등록 관련
	// =======================================================================
	
	// 공고 등록 페이지로 이동함 
	@GetMapping("recruiterRegistForm")
	public String recruiterRegistForm(Model model) {
		// 디비 공통코드에서 주소 값 가져오기 s
		List<Map<String, String>> locationList = service.getLocation();
		model.addAttribute("locationList", locationList);
		
		// 디비 직무 가져오기 
		List<Map<String, String>> occupationList = service.getOccupation();
		model.addAttribute("occupationList", occupationList);
		
		//공통코드 값들 가져오기 
		
		// 그룹으로 조회 하기 위해서 상수 값을 스트링 배열로 전환 
		List<String> codeGroups = Arrays.stream(CodeGroups.values())
										.map(Enum::name)
										.collect(Collectors.toList());
		
		// 그룹을 파라미터로 넘겨서 해당하는 공통 코드와 이름을 조회해서 배열에 담음 
		List<CommonCodeVO> commonList = comService.selectAllCommonList(codeGroups);
		System.out.println(commonList);
		
		// 배열에 담아온 값을 그룹아이디를 기준으로 그룹화 하여서 맵 형태로 바꿈 
		Map<String,List<CommonCodeVO>> commonListMap 
			= commonList.stream().collect(Collectors.groupingBy(CommonCodeVO::getCode_group_id));
		
		// 맵형태로 바꾼 것을 모델에 담아 전달함 
		model.addAttribute("commonListMap", commonListMap);
		
		return "recruiter/recruiterRegistForm";
	}
	
	// 공고 등록 폼 제출 
	@PostMapping("recruiterRegistForm")
	public String recruiterRegistForm(RecruitVO recruit) {
		System.out.println("여기다 이놈아 ~~~~~~~~~~~~~~");
		System.out.println(recruit);
		
		int insertCnt = service.insertRecruitment(recruit);
		
		
		return "redirect:/recruiterList";
	}
	

}

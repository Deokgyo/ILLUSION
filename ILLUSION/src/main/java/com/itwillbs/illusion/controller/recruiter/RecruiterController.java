package com.itwillbs.illusion.controller.recruiter;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.handler.recruiter.CodeGroups;
import com.itwillbs.illusion.service.CommonCodeService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.service.RecruiterService;
import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.RecruitVO;
import com.itwillbs.illusion.vo.ResumeVO;

@Controller
public class RecruiterController {
	
	@Autowired
	RecruiterService service;
	@Autowired
	CommonCodeService comService;
	@Autowired 
	ResumeService resumeService;
	@Autowired 
	MypageService mypageService;
	
	// 기업 메인 페이지로 이동 
	@GetMapping("recruiterMain") 
	public String recruiterMain(Principal principal) {
		if (principal == null)  return "recruiter/recruiterMain";
	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	    boolean isRecruiter = auth.getAuthorities().stream()
	                              .anyMatch(a -> a.getAuthority().equals("ROLE_MEM003"));
	    // 기업 회원이면 로그인 페이지로, 아니면 메인
	    return isRecruiter ? "redirect:/recruiterMainLogin" : "recruiter/recruiterMain";
	}
	
	@GetMapping("recruiterMainLogin") 
	public String recruiterMainLogin(Model model, Principal principal) {
		// 현재 로그인된 아이디 가져오기 
		String member_id = principal.getName();
		
		// 채용중인 공고 개수 가져오기 
		String RecruitmentCnt = service.getRecruitmentCnt(member_id);
		model.addAttribute("RecruitmentCnt", RecruitmentCnt);
		
		// 기업 이름, 담당자 이름, 담당자 이메일, 마감 임박 공고 개수 가져오기 
		Map<String, String> RecruiterInfo = service.getRecruiterInfo(member_id);
		model.addAttribute("RecruiterInfo", RecruiterInfo);
		
//		공고의 제목과 마감일 가져오기 
		List<Map<String, Object>> recruitmentSubjectDate = service.getRecruitmentSubjectDate(member_id);
		System.out.println(recruitmentSubjectDate);
		for (Map<String, Object> r : recruitmentSubjectDate) {
			LocalDateTime endDate = (LocalDateTime) r.get("end_date"); // Map에서 키로 꺼냄
			String formatted = endDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			r.put("end_date", formatted);     
		}
		model.addAttribute("recruitmentSubjectDate", recruitmentSubjectDate);
		
		// 미열람 이력서 수 가져오기 
		int unViewedCnt = service.selectUnViewedCnt(member_id);
		model.addAttribute("unViewedCnt", unViewedCnt);
		
		// 총 지원자 수 가져오기 
		int totalAppCnt = service.selectTotalAppCnt(member_id);
		model.addAttribute("totalAppCnt", totalAppCnt);
		
		// 미 열람 이력서 제목, 경력, 학력, 거주지 가져오기 
		List<Map<String,String>> resumeInfo = service.selectResumeInfo(member_id);
		model.addAttribute("resumeInfo", resumeInfo);
		
		return "recruiter/recruiterMainLogin"; 
	}
		
	//이력서 상세 보기 
	@GetMapping("viewResume")
	public String viewResume(int resume_idx, int member_idx, Model model) {
//			Map<String, Object> member = resumeService.selectMember(member_idx);
//			model.addAttribute("member", member);
//			Map<String, Object> resume = resumeService.selectResume(resume_idx);
//			model.addAttribute("resume", resume);
//			List<Map<String, Object>> resumeExpInfoList = resumeService.selectResumeExpInfoList(resume_idx);
//			model.addAttribute("resume_exp_info_list", resumeExpInfoList);
		
		
		List<ResumeVO> resume = mypageService.savedResumeDetail(resume_idx);
		model.addAttribute("resume", resume);
		
		return "recruiter/viewResume";
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
	
	// 기업회원 수정 페이지 이동 
	@GetMapping("memberModify")
	public String memberModify() {
		return "recruiter/memberModify";
	}
	
	// 공고 마감 버튼 누를 때 
	@GetMapping("recruitClose")
	public String recruitClose(int recruit_idx) {
		service.recruitClose(recruit_idx);
		return "redirect:/recruiterList";
	}
	
	// 공고 삭제 
	@GetMapping("recruitDelete") 
	public String recruitDelete(int recruit_idx) {
		boolean isDelete = service.recruitDelete(recruit_idx);
		return "redirect:/recruiterList";
	}
	
	// 공고 수정 버튼 누르고 공고 수정 페이지로 이동함 
	@GetMapping("recruitModify")
	public String recruitModify(int recruit_idx, Model model) {
		
		RecruitVO vo = service.selectRecruitModify(recruit_idx);
		System.out.println("vo 어케 찍히노: " + vo);
		model.addAttribute("savedData", vo);
		
		// 디비 공통코드에서 주소 값 가져오기 
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
		
		return "recruiter/recruitModify";
	}
	
	// 공고 수정 내용 업데이트 
	@PostMapping("recruitModify")
	public String recruitModify(RecruitVO recruit, Principal principal) {
		String member_id = principal.getName();
		service.recruitModify(recruit, member_id);
		return "redirect:/recruiterList";
	}
	
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
	
	String virtualPath = "/resources/upload/temp";
	// 공고 등록 폼 제출 
	@PostMapping("recruiterRegistForm")
	public String recruiterRegistForm(RecruitVO recruit, Principal principal, HttpServletRequest req) {
		System.out.println("여기다 이놈아 ~~~~~~~~~~~~~~");
		System.out.println(recruit);
		String member_id = principal.getName();
		String context = recruit.getRecruit_context();
		String realPath = req.getServletContext().getRealPath(virtualPath);
//		System.out.println(realPath +"실제 경로");
//		D:\workspace_spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ILLUSION\resources\ upload\temp실제 경로
//		// 본문 내용에서 src 경로 추출해서 real로 수정해야함 
//		// src 경로 추출하기 위한 정규식 

		Pattern pattern = Pattern.compile("src=\"([^\"]+)\"");
//		// 정규식을 바탕으로 본분 값에서 정규식에 매칭 되는 값 찾기 
		Matcher matcher = pattern.matcher(context);
		String imgUrl = matcher.group();
		System.out.println("이미지 경로 가져오기" + imgUrl);
		
		Pattern filePattern = Pattern.compile("(\\d{4}/\\d{2}/\\d{2})/([0-9a-fA-F]{8}(?:-[0-9a-fA-F]{4}){3}-[0-9a-fA-F]{12})_(.+)\\.([A-Za-z0-9]+)\r\n");
		Matcher filematcher = filePattern.matcher(imgUrl);
		String fileUrl = filematcher.group();
		System.out.println("이게 진짠가");
		System.out.println(fileUrl);
//		
//		while(matcher.find()) {
////		<img src="/illusion/upload/temp/2025/08/31/f146cfe3-3433-4ab4-a623-a035a032c63e_스크린샷 2025-08-01 144023.png" style="width: 818.4px;">
////		// 파일 이동 해야함 
//		// 실제로 저장된 경로에서 파일을 이동 해야함 
//		
////		// temp를 real로 수정해야함..
////		
//		}
		
		
		int insertCnt = service.insertRecruitment(recruit, member_id);
		
		
		return "redirect:/recruiterList";
	}
	
	
	

}

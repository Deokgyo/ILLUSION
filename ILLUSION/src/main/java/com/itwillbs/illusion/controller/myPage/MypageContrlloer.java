package com.itwillbs.illusion.controller.myPage;

import java.time.LocalTime;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.service.ResumeService;
import com.itwillbs.illusion.vo.ResumeVO;

@Controller
public class MypageContrlloer {
	@Autowired
	ResumeService service;
	
	@GetMapping("myPage")
	public String myPage(){
		return "myPage/myPage";
	}
	/* 이력서 등록 */
	@GetMapping("resumeWrite")
	public String resumeWriteForm() {
		return "myPage/resumeWrite";
	}
	@PostMapping("resumeWrite")
	public String resumeWrite(@RequestParam Map<String, Object> paramMap) {
	    // 서비스 호출 - insert 시 useGeneratedKeys로 resume_idx 채워줌
	    service.insertResume(paramMap);
	    
	    // 생성된 resume_idx 값 가져와서 상세보기로 이동
	    return "redirect:/savedResumeDetail?resume_idx=" + paramMap.get("resume_idx") 
	       + "&member_idx=" + paramMap.get("member_idx");
	}
	/* 이력서 목록 */
	@GetMapping("savedResumeList")
	public String savedResumeList(Model model) {
		
		return "myPage/savedResumeList";
	}
	/* 자소서 목록 */
	@GetMapping("savedCLList")
	public String savedCLList() {
		return "myPage/savedCLList";
	}
	/* 면접예상질문 리스트 */
	@GetMapping("savedQuestionList")
	public String savedQuestionList() {
		return "myPage/savedQuestionList";
	}
	/* 스크랩공고 목록 */
	@GetMapping("ScraprecruitList")
	public String ScraprecruitList() {
		return "myPage/ScraprecruitList";
	}
	
	/*입사지원현황 */
	@GetMapping("jobapplicationlist")
	public String jobapplicationlist() {
		return "myPage/jobapplicationlist";
	}
	/*내가쓴글*/
	@GetMapping("myPost")
	public String myPost() {
		return "myPage/myPost";
	}
	
	/* 환불 정책  */
	@GetMapping("RefundPolicy")
	public String RefundPolicy() {
		return "myPage/RefundPolicy";
	}
	
	/*회원정보 수정*/
	@GetMapping("UserInfoEdit")
	public String UserInfoEdit() {
		return "myPage/UserInfoEdit";
	}
	
	/*토큰 결제*/
	@GetMapping("tokenpay")
	public String tokenpay() {
		return "myPage/tokenpay";
	}
	/*이력서 상세보기 */
	@GetMapping("savedResumeDetail")
	public String savedResumeDetail(@RequestParam int resume_idx
								   ,@RequestParam int member_idx
								   ,Model model) {
		Map<String, Object> member = service.selectMember(member_idx);
		model.addAttribute("member", member);
        Map<String, Object> resume = service.selectResume(resume_idx);
        model.addAttribute("resume", resume);		
		return "myPage/savedResumeDetail";
	}
	/*자소서 상세보기 */
	@GetMapping("savedCLDetail")
	public String savedCLDetail() {
		return "myPage/savedCLDetail";
	}
	/*비밀번호변경 */
	@GetMapping("changePasswd")
	public String changePasswd() {
		return "myPage/changePasswd";
	}
	/*회원탈퇴 */
	@GetMapping("deleteMember")
	public String deleteMember() {
		return "myPage/deleteMember";
	}
}
       
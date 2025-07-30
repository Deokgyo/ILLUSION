package com.itwillbs.illusion.controller.myPage;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageContrlloer {
	@GetMapping("myPage")
	public String myPage(){
		return "myPage/myPage";
	}
	/* 이력서 등록 */
	@GetMapping("resumeWrite")
	public String resumeWrite() {
		return "myPage/resumeWrite";
	}
	/* 이력서 목록 */
	@GetMapping("saved_ResumeList")
	public String saved_ResumeList() {
		return "myPage/saved_ResumeList";
	}
	/* 자소서 목록 */
	@GetMapping("saved_CLList")
	public String saved_CLList() {
		return "myPage/saved_CLList";
	}
	/* 면접예상질문 리스트 */
	@GetMapping("saved_QuestionList")
	public String saved_QuestionList() {
		return "myPage/saved_QuestionList";
	}
	/* 스크랩공고 목록 */
	@GetMapping("Scrap_recruitList")
	public String Scrap_recruitList() {
		return "myPage/Scrap_recruitList";
	}
	
	/*입사지원현황 */
	@GetMapping("job_application_list")
	public String job_application_list() {
		return "myPage/job_application_list";
	}
	/*내가쓴글*/
	@GetMapping("myPost")
	public String myPost() {
		return "myPage/myPost";
	}
	
	/* 환불 정책  */
	@GetMapping("refund_policy")
	public String refund_policy() {
		return "myPage/refund_policy";
	}
	
	/*회원정보 수정*/
	@GetMapping("User_Info_Edit")
	public String User_Info_Edit() {
		return "myPage/User_Info_Edit";
	}
	
	/*회원정보 수정*/
	@GetMapping("token_pay")
	public String token_pay() {
		return "myPage/token_pay";
	}
}
       
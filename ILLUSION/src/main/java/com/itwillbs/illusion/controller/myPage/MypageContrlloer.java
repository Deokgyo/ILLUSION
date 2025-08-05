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
	@GetMapping("savedResumeList")
	public String savedResumeList() {
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
	@GetMapping("refundpolicy")
	public String refundpolicy() {
		return "myPage/refundpolicy";
	}
	
	/*회원정보 수정*/
	@GetMapping("UserInfoEdit")
	public String UserInfoEdit() {
		return "myPage/UserInfoEdit";
	}
	
	/*회원정보 수정*/
	@GetMapping("tokenpay")
	public String tokenpay() {
		return "myPage/tokenpay";
	}
	/*이력서 상세보기 */
	@GetMapping("savedResumeDetail")
	public String savedResumeDetail() {
		return "myPage/savedResumeDetail";
	}
	/*자소서 상세보기 */
	@GetMapping("savedCLDetail")
	public String savedCLDetail() {
		return "myPage/savedCLDetail";
	}
}
       
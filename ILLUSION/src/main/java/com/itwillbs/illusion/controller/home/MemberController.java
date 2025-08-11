package com.itwillbs.illusion.controller.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.service.MailService;
import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

// @RestController // 해당 클래스의 모든 메서드에 @ResponseBody 가 적용됨
@Controller
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MailService mailService;
	
	@GetMapping("MemberJoin")
	public String memberJoin() {
		return "member/member_join_form";
	}
	
	@GetMapping("MemberLogin")
	public String memberLogin() {
		return "member/member_login_form";
	}
	
	@PostMapping("MemberLogin")
	public String memberLogin(
			MemberVO member, 
			String rememberId,
			Model model,
			HttpSession session,
			HttpServletResponse res) {

		MemberVO dbMember = memberService.getMemberInfo(member.getId());
		
		if (dbMember == null) {
			model.addAttribute("msg", "아이디가 없습니다.");
			return "result/fail";
		} else if (!member.getPasswd().equals(dbMember.getPasswd())) {
			model.addAttribute("msg", "비밀번호가 틀립니다.");
			return "result/fail";
		} else {
			
//			if (rememberId != null) { // 아이디 기억하지 체크 했을때
//				// 1. javax.servlet.http.Cookie 객체 생성
//				Cookie cookie = new Cookie("rememberId", member.getId());
//				// 2. 쿠키 유효기간(만료기간) 설정(초 단위)
//				cookie.setMaxAge(60 * 60 * 24 * 30); // 30일
//				// 3. 클라이언트측으로 쿠키 정보를 전송하기 위해
//				//   응답 정보를 관리하는 HttpServletResponse 객체의 addCookie() 호출
//				res.addCookie(cookie);
//			} else { // 아이디 기억하기 체크 해제 했을 때
//				// 기존 쿠키 중 "rememberId" 라는 이름의 쿠키 삭제
//				// => 쿠키는 삭제의 개념을 MaxAge 값(만료시간)을 0으로 설정 후 전송하여 처리
//				// => 이때, 쿠키 이름은 반드시 삭제해야할 쿠키의 이름을 정확하게 설정
//				Cookie cookie = new Cookie("rememberId", member.getId());
//				// 쿠키의 유효기간을 반드시 0으로 설정
//				// => 이 쿠키를 수신한 클라이언트는 해당 쿠키를 즉시 삭제
//				cookie.setMaxAge(0);
//				res.addCookie(cookie);
//			}
			
			// ----- 쿠키 생성 코드 중복 제거 ------
			int maxAge = (rememberId != null) ? 60 * 60 * 24 * 30 : 0;
			Cookie cookie = new Cookie("rememberId", member.getId());
			cookie.setMaxAge(maxAge);
			res.addCookie(cookie);
			
			session.setAttribute("sId", member.getId());
			// 세션 타이머 설정 (ex. 금융권 사이트의 경우 10분(= 600초)
			session.setMaxInactiveInterval(600);
			// 메인 페이지로 리다이렉트
			return "redirect:/";
		}
	}
	
	@GetMapping("MemberLogout")
	public String memberLogout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	
	@ResponseBody	// 리턴되는 문자열이 데이터가 되도록 변경
	@GetMapping("checkId")
	public Map<String, String> checkId(String id) {
		System.out.println("id: " + id);
		
		// 자바스크립트 success에서 데이터를 사용하려면 json 형태인것이 편리하다.
		// 이때, 가장 비슷한 Map을 리턴하더라도 자동 json으로 파싱이 불가능
		// pom.xml에 jackson 라이브러리를 추가하여 편리하게 json으로 파싱 가능
		// (스프링부트에서는 디폴트 jackson 추가되어있음)
		
//		int cnt = service.checkId(id);
//		
//		Map<String, String> resultMap = new HashMap<String, String>();
//		
//		if (cnt == 0) { // 사용가능
//			resultMap.put("msg", "사용 가능한 아이디");
//			resultMap.put("color", "blue");
//		} else {
//			resultMap.put("msg", "사용 불가능한 아이디(아이디 중복)");
//			resultMap.put("color", "red");
//		}
		
		return memberService.checkIdMap(id);
	}
	
	@PostMapping("MemberJoin")
	public String memberJoin(MemberVO member, Model model) {

		String email = member.getEmail1() + "@" + member.getEmail2();
		member.setEmail(email);
		
		int insertCnt = memberService.insertMember(member);
		
		if (insertCnt > 0) {
			// 이메일 인증메일 전송
			MailAuthInfo mailAutoInfo = mailService.sendAuthMail(member);
			// 메일 인증정보 등록
			memberService.insertMailAuthInfo(mailAutoInfo);
			
			return "redirect:/MemberJoinSuccess";
		} else {
			model.addAttribute("msg", "회원 가입 실패!");
			return "result/fail";
		}
	}
	
	@GetMapping("MemberJoinSuccess")
	public String memberJoinSuccess() {
		return "member/member_join_success";
	}
	
	@GetMapping("MemberEmailAuth")
	public String memberEmailAuth(MailAuthInfo mailAuthInfo, Model model) {
		
		System.out.println("mailAuthInfo: " + mailAuthInfo);
		
		// requestEmailAuth() 메서드 호출하여 인증처리 요청
		boolean isAuthSuccess = memberService.requestEmailAuth(mailAuthInfo);
		
		if (!isAuthSuccess) {
			model.addAttribute("msg", "메일 인증 실패!");
		} else {
			model.addAttribute("msg", "메일 인증 성공!\\n로그인 페이지로 이동합니다.");
			model.addAttribute("url", "MemberLogin");
		}
		
 		return "result/fail";
	}
	
}

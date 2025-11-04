package com.itwillbs.illusion.controller.myPage;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.MypageService;
import com.itwillbs.illusion.vo.MemberVO;
import com.mysql.cj.protocol.x.SyncFlushDeflaterOutputStream;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor

public class MyPageApiController {
	
	@Autowired
	MypageService mypageService;
	
	@Autowired
	MemberService memberService; 
	
	// 채용공고 페이지 스크랩 토글기능
	@PostMapping("api/scraps/{recruitIdx}/toggle")
	public ResponseEntity<Map<String, Object>> toggleScrap(
	        @PathVariable("recruitIdx") int recruitIdx,
	        Principal principal) {
		
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        boolean toggleScrap = mypageService.toggleScrap(member.getMember_idx(), recruitIdx);

        Map<String, Object> map = new HashMap<>();
        map.put("status", "success");
        map.put("toggleScrap", toggleScrap); // 현재 최종 스크랩 상태(true/false)를 알려줌
        
        return ResponseEntity.ok(map);
    }
	
	// 마이페이지에서 체크박스한 관심 채용 공고 삭제
    @PostMapping("/api/mypage/scraps/delete")
    public ResponseEntity<Map<String, Object>> deleteScraps(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
        
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteScraps(member.getMember_idx(), idList);
        
        return createSuccessResponse(deletedCount, "스크랩");
    }

	// 마이페이지에서 체크박스한 입사 지원 삭제 -> 삭제하면 채용 취소?
    @PostMapping("/api/mypage/applys/delete")
    public ResponseEntity<Map<String, Object>> deleteApplys(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
    	
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteApplys(member.getMember_idx(), idList);

        return createSuccessResponse(deletedCount, "지원 내역");
    }
    
	// 마이페이지에서 체크박스한 내가 쓴 글 삭제
    @PostMapping("/api/mypage/myPost/delete")
    public ResponseEntity<Map<String, Object>> deleteMyPosts(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
    	
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteMyPosts(member.getMember_idx(), idList);

        return createSuccessResponse(deletedCount, "내가 쓴 글");
    }
    
	// 마이페이지에서 체크박스한 이력서 목록 삭제
    @PostMapping("/api/mypage/myResume/delete")
    public ResponseEntity<Map<String, Object>> deleteMyResumes(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
    	
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteMyResumes(member.getMember_idx(), idList);

        return createSuccessResponse(deletedCount, "이력서");
    }
    
	// 마이페이지에서 체크박스한 자소서 목록 삭제
    @PostMapping("/api/mypage/myCL/delete")
    public ResponseEntity<Map<String, Object>> deleteMyCLs(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
    	
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteMyCLs(member.getMember_idx(), idList);

        return createSuccessResponse(deletedCount, "자기소개서");
    }
    
	// 마이페이지에서 체크박스한 면접질문 목록 삭제
    @PostMapping("/api/mypage/myQuestionList/delete")
    public ResponseEntity<Map<String, Object>> deleteMyQuestionList(
            @RequestParam("idList") List<Integer> idList,
            Principal principal) {
    	
        if (principal == null) return createUnauthorizedResponse();
        MemberVO member = memberService.getMemberInfoById(principal.getName());
        if (member == null) return createForbiddenResponse();
        
        int deletedCount = mypageService.deleteMyQuestionList(member.getMember_idx(), idList);

        return createSuccessResponse(deletedCount, "면접 질문");
    }


    // 마이페이지 api 공통 메소드

    private ResponseEntity<Map<String, Object>> createSuccessResponse(int count, String itemName) {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", count + "개의 " + itemName + "이(가) 삭제되었습니다.");
        return ResponseEntity.ok(response);
    }
    
    private ResponseEntity<Map<String, Object>> createUnauthorizedResponse() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", "로그인이 필요합니다.");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

    private ResponseEntity<Map<String, Object>> createForbiddenResponse() {
         Map<String, Object> response = new HashMap<>();
        response.put("status", "error");
        response.put("message", "사용자 정보를 찾을 수 없습니다.");
        return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
    }
}


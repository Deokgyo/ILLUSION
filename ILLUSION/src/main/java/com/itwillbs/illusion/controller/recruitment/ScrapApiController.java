package com.itwillbs.illusion.controller.recruitment;

import java.security.Principal;
import java.util.HashMap;
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
import com.itwillbs.illusion.service.ScrapService;
import com.itwillbs.illusion.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/scraps")

public class ScrapApiController {
	
	@Autowired
	ScrapService scrapService;
	
	@Autowired
	MemberService memberService; 
	
	@PostMapping("/{recruitIdx}/toggle")
	public ResponseEntity<Map<String, Object>> toggleScrap(
	        @PathVariable("recruitIdx") int recruitIdx,
	        Principal principal) {
		
	    String memberId = principal.getName();
	    MemberVO member = memberService.getMemberInfoById(memberId);
        
	    // 사용자 정보를 찾을 수 없을때
        if (member == null) {
            Map<String, Object> map = new HashMap<>();
            map.put("status", "error");
            map.put("message", "사용자 정보를 찾을 수 없습니다.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(map); // 403 에러 응답
        }
        
        boolean toggleScrap = scrapService.toggleScrap(member.getMember_idx(), recruitIdx);

        Map<String, Object> map = new HashMap<>();
        map.put("status", "success");
        map.put("toggleScrap", toggleScrap); // 현재 최종 스크랩 상태(true/false)를 알려줌
        
        return ResponseEntity.ok(map);
    }
}

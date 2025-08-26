package com.itwillbs.illusion.controller.myPage;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.service.TokenService;
import com.itwillbs.illusion.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/tokens")
public class TokenApiController {

    private final TokenService tokenService;
    private final MemberService memberService;

    @PostMapping("/charge")
    public ResponseEntity<Map<String, Object>> chargeToken(
            @RequestParam("tokenAmount") int tokenAmount, // JS로부터 충전할 토큰 양을 받음
            Principal principal) {
        
        // 1. 로그인 사용자 확인 (필수)
        if (principal == null) {
            Map<String, Object> response = new HashMap<>();
            response.put("status", "error");
            response.put("message", "로그인이 필요합니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        String memberId = principal.getName();
        MemberVO member = memberService.getMemberInfoById(memberId);
        
        if (member == null) {
             Map<String, Object> response = new HashMap<>();
            response.put("status", "error");
            response.put("message", "사용자 정보를 찾을 수 없습니다.");
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body(response);
        }
        
        Map<String, Object> response = new HashMap<>();
        try {
            // 2. ✨ Service를 호출하여 토큰 충전 로직 실행
            int updatedTokens = tokenService.addTokensToMember(member.getMember_idx(), tokenAmount);
            
            // 3. 성공 응답 생성
            response.put("status", "success");
            response.put("message", tokenAmount + " 토큰이 성공적으로 충전되었습니다.");
            response.put("updatedTokens", updatedTokens); // 사용자의 최종 토큰 개수
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            // 4. 실패 응답 생성
            response.put("status", "error");
            response.put("message", "토큰 충전 중 서버 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
}

package com.itwillbs.illusion.util;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;

import org.springframework.stereotype.Component;

import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.MemberVO;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class PrincipalRefresher {

    private final MemberMapper memberMapper; // 프로젝트의 실제 Mapper 클래스 이름으로 변경 필요

    /**
     * DB에서 최신 사용자 정보를 불러와 현재 로그인 세션에 즉시 적용합니다.
     * 예: 프로필 정보 수정 후, 또는 관리자에 의한 권한 변경 후 호출
     */
    public void refreshPrincipal() {
        // 현재 로그인된 사용자의 Authentication 객체를 가져옴
        var oldAuth = SecurityContextHolder.getContext().getAuthentication();
        if (oldAuth == null || !(oldAuth.getPrincipal() instanceof CustomUserDetails)) {
            return; // 로그인 상태가 아니거나, Principal 타입이 CustomUserDetails가 아니면 중단
        }

        // 현재 사용자의 username(ID) 가져오기
        String username = oldAuth.getName();

        // DB에서 최신 MemberVO 정보를 조회 (메소드 이름은 실제 Mapper에 맞게 확인/변경 필요)
        MemberVO updatedMember = memberMapper.getMemberInfoById(username); 
        if (updatedMember == null) {
            // 사용자가 DB에서 삭제된 경우, 세션을 무효화(로그아웃) 시킬 수도 있음
            SecurityContextHolder.clearContext();
            return;
        }

        // DB에서 가져온 최신 정보로 새로운 CustomUserDetails 객체 생성
        var newPrincipal = new CustomUserDetails(updatedMember);

        // 새로운 Authentication 토큰 생성
        var newAuth = new UsernamePasswordAuthenticationToken(
            newPrincipal,
            oldAuth.getCredentials(),      // 이전 인증의 credentials(보통 null)를 그대로 사용
            newPrincipal.getAuthorities()  // newPrincipal에서 정의된 getAuthorities()가 호출됨
        );
        newAuth.setDetails(oldAuth.getDetails()); // 이전 인증의 부가 정보(IP 등)를 그대로 사용

        // SecurityContextHolder에 새로운 Authentication 객체를 설정하여 세션 정보 갱신
        SecurityContextHolder.getContext().setAuthentication(newAuth);
    }

    /**
     * 비밀번호를 다시 한번 확인하여 사용자를 재인증합니다.
     * 예: 비밀번호 변경, 회원 탈퇴 등 민감한 작업 전에 호출
     */
    public void reauthenticate(String username, String rawPassword, AuthenticationManager am) {
        var reAuth = am.authenticate(new UsernamePasswordAuthenticationToken(username, rawPassword));
        SecurityContextHolder.getContext().setAuthentication(reAuth);
    }
}





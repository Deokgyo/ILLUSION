package com.itwillbs.illusion.handler.home;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

@Component("customLoginSuccessHandler")
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        
        // --- 1. '아이디 저장' 쿠키 처리 로직 (기존과 동일) ---
        handleRememberIdCookie(request, response, authentication);
        
        // --- 2. 역할(Role)에 따라 리다이렉트할 URL 결정 ---
        String targetUrl = determineTargetUrl(authentication);
        
        // 3. 결정된 URL로 리다이렉트
        // sendRedirect는 컨텍스트 경로를 자동으로 처리하지 않으므로, 직접 붙여줘야 합니다.
        response.sendRedirect(request.getContextPath() + targetUrl);
    }
    
    // 아이디 저장 여부에 따라 쿠키 생성 또는 삭제 하는 메서드
    private void handleRememberIdCookie(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        String rememberId = request.getParameter("rememberId");
        String member_id = authentication.getName();
        
        Cookie idCookie = new Cookie("rememberId", member_id);
        idCookie.setPath(request.getContextPath() + "/"); // 컨텍스트 경로를 포함한 루트로 설정
        
        if (rememberId != null && rememberId.equals("true")) {
            // '아이디 저장'을 체크한 경우
            idCookie.setMaxAge(60 * 60 * 24 * 30); // 30일
        } else {
            // '아이디 저장'을 체크하지 않은 경우 (또는 기존 쿠키를 삭제해야 하는 경우)
            idCookie.setMaxAge(0); // 즉시 삭제
        }
        
        response.addCookie(idCookie);
    }
    
    // 사용자 타입 확인 후 이동할 url 정하는 메서드 
    protected String determineTargetUrl(Authentication authentication) {
        // 현재 로그인한 사용자의 모든 역할(Role) 정보를 가져옵니다.
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        for (GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            
            // 역할 이름에 따라 다른 URL을 반환합니다.
            // (security-context.xml의 CONCAT('ROLE_', member_type) 결과와 일치해야 함)
            if (authorityName.equals("ROLE_MEM001")) { 
                return "/adminMain"; 
            } else if (authorityName.equals("ROLE_MEM003")) { 
                return "/recruiterMainLogin"; 
            }
        }

        return "/";
    }
}
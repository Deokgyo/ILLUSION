package com.itwillbs.illusion.handler.home;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

@Component("customLoginFailureHandler")
public class CustomLoginFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        
        // 1. 로그인 실패 시, 에러 메시지를 세션(Session)에 저장합니다.
        //    (URL 파라미터가 아니라 세션에 저장하는 것이 핵심!)
        request.getSession().setAttribute("loginErrorMessage", "아이디 또는 비밀번호가 올바르지 않습니다.");
        
        // 2. 에러 파라미터가 없는 '깨끗한' 로그인 페이지 URL로 리다이렉트합니다.
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
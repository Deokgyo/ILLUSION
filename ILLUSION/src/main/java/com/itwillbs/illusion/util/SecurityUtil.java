package com.itwillbs.illusion.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import com.itwillbs.illusion.service.MemberService;
import com.itwillbs.illusion.vo.MemberVO;

/**
 * Spring Security 관련 유틸리티 메소드를 제공하는 클래스.
 * 프로젝트 전역에서 현재 로그인한 사용자의 정보를 쉽게 가져올 수 있도록 도와줍니다.
 */
@Component // 이 클래스를 스프링 빈(Bean)으로 등록하여 MemberService를 주입받을 수 있게 함
public class SecurityUtil {

    // MemberService를 주입받기 위해 static 변수와 setter를 사용 (static context에 주입하기 위한 방법)
    private static MemberService staticMemberService;

    @Autowired
    public void setMemberService(MemberService memberService) {
        // 주입받은 MemberService 인스턴스를 static 변수에 할당
        SecurityUtil.staticMemberService = memberService;
    }

    /**
     * 현재 Security Context에 저장된 인증 정보(Authentication)를 가져옵니다.
     * @return 인증 정보 객체, 비로그인 시 null
     */
    private static Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }
    
    /**
     * 현재 사용자가 로그인한 상태인지 확인합니다.
     * @return 로그인 상태이면 true, 아니면 false
     */
    public static boolean isAuthenticated() {
        Authentication authentication = getAuthentication();
        // 인증 정보가 존재하고, 인증되었으며, 익명 사용자가 아닌 경우 true
        return authentication != null && authentication.isAuthenticated() && !"anonymousUser".equals(authentication.getPrincipal());
    }

    /**
     * 현재 로그인한 사용자의 MemberVO 객체 전체를 반환하는 메소드.
     * DB 조회가 한 번 발생합니다.
     * @return 로그인한 경우 MemberVO 객체, 비로그인 시 null
     */
    public static MemberVO getLoginUser() {
        Authentication authentication = getAuthentication();

        if (authentication == null || !isAuthenticated()) {
            return null;
        }

        // 인증된 사용자의 ID(username)를 가져옴
        String member_id = authentication.getName();
        
        // 주입받은 MemberService를 사용하여 DB에서 MemberVO를 조회하여 반환
        return staticMemberService.getMemberInfoById(member_id);
    }

    /**
     * 현재 로그인한 사용자의 고유 번호(member_idx)를 직접 반환하는 메소드.
     * 내부적으로 getLoginUser()를 호출하므로 DB 조회가 발생합니다.
     * @return 로그인한 경우 member_idx, 비로그인 시 -1
     */
    public static int getLoginUserIndex() {
        MemberVO loginUser = getLoginUser();
        
        if (loginUser != null) {
            return loginUser.getMember_idx();
        }
        
        // 비로그인 상태이거나 사용자를 찾을 수 없는 경우, 오류를 나타내는 -1 반환
        return -1; 
    }
    
    /**
     * 현재 로그인한 사용자의 아이디(member_id)를 직접 반환하는 메소드.
     * DB 조회 없이 즉시 반환되므로 매우 빠릅니다.
     * @return 로그인한 경우 member_id, 비로그인 시 null
     */
    public static String getLoginUserId() {
        Authentication authentication = getAuthentication();
        
        if (authentication != null && isAuthenticated()) {
            return authentication.getName();
        }
        
        return null;
    }
    
    /**
     * 현재 로그인한 사용자의 회원 타입(member_type)을 직접 반환하는 메소드.
     * 내부적으로 getLoginUser()를 호출하므로 DB 조회가 발생합니다.
     * @return 로그인한 경우 member_type, 비로그인 시 null
     */
    public static String getLoginUserType() {
        MemberVO loginUser = getLoginUser();
        
        if (loginUser != null) {
            return loginUser.getMember_type();
        }
        
        return null;
    }
}
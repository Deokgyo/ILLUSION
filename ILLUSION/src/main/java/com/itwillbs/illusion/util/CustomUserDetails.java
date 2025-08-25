package com.itwillbs.illusion.util; 

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.itwillbs.illusion.vo.MemberVO;

public class CustomUserDetails implements UserDetails {

    private final MemberVO member;

    public CustomUserDetails(MemberVO member) {
        this.member = member;
    }
    
    // 로그인 사용자 정보 getToken메서드 같이 추가해서 사용가능
    public int getToken() {
        return member.getToken();
    }
    
    public MemberVO getMember() {
        return member;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singletonList(new SimpleGrantedAuthority("ROLE_" + member.getMember_type()));
    }

    @Override
    public String getPassword() {
        return member.getMember_pw();
    }

    @Override
    public String getUsername() {
        return member.getMember_id();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
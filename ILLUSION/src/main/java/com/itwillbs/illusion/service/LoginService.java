package com.itwillbs.illusion.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.LoginMapper;

@Service
public class LoginService {
	
	@Autowired
	LoginMapper mapper;
	
    public Map<String, Object> loginMember(Map<String, String> params) {
        Map<String, Object> dbMember = mapper.selectMemberById(params.get("member_id"));
        
        if (dbMember != null && dbMember.get("member_pw").equals(params.get("member_pw"))) {
            return dbMember;
        }
        
        return null;
    }
    
}
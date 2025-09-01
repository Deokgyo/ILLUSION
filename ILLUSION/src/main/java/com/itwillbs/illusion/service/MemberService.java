package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;

import com.itwillbs.illusion.mapper.CompanyMapper;
import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.CompanyVo;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Service
public class MemberService {

	private static final String String = null;
	
	@Autowired
	MemberMapper mapper;
	
	@Autowired
	CompanyMapper companymapper;
	

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo) {
		return mapper.insertMailAuthInfo(mailAuthInfo);
	}

	public int updateMailAuthStatus(Map<String, String> param) {
		return mapper.updateMailAuthStatus(param);
	}

	public int checkIdCount(String member_id) {
		return mapper.checkIdCount(member_id);
	}

	public int checkRecruiterNumber(String recruiterNumber) {
		return mapper.checkRecruiterNumber(recruiterNumber);
	}
	
	// 조영재
	public MemberVO getMemberInfoById(String member_id) {
		return mapper.getMemberInfoById(member_id);
	}
	
	public MemberVO getMemberCompanyInfoById(String member_id) {
		return mapper.getMemberCompanyInfoById(member_id);
	}

	@Transactional
	public boolean requestEmailAuth(MailAuthInfo mailAuthInfo) {

		boolean isAuthSuccess = false;

		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);

		if (dbMailAuthInfo != null) { // 이메일에 대한 인증코드가 존재할 경우
			String auth_code = mailAuthInfo.getAuth_code();
			String db_auth_code = dbMailAuthInfo.getAuth_code();

			if (auth_code.equals(db_auth_code)) {
				mapper.deleteMailAuthInfo(mailAuthInfo);
				isAuthSuccess = true;
			}
		}

		return isAuthSuccess;
	}

	// 회원가입 비즈니스 로직 메서드
	@Transactional
	public boolean insertMember(MemberVO member, CompanyVo company) {
		// 비밀번호 암호화
        String rawPassword = member.getMember_pw();
        if (rawPassword == null || rawPassword.isEmpty()) {
            throw new IllegalArgumentException("비밀번호가 입력되지 않았습니다.");
        }
        String encodedPassword = passwordEncoder.encode(rawPassword);
        member.setMember_pw(encodedPassword);
        
        
        if (member.getMember_type().equals("MEM003")) { // 기업회원인 경우 회사 정보도 저장
        	//기본 로고 넣기 (덕교)
        	company.setCompany_logo("<img src='/illusion/resources/mypage_image/profile.png'>");
        	companymapper.insertMemberCompany(company);
        	member.setCompany_idx(company.getCompany_idx()); // 이 부분 수정 member에 Company_idx set
        }
        
        int memberInsertCount = mapper.insertMember(member);
        
        return memberInsertCount > 0;
    }

}

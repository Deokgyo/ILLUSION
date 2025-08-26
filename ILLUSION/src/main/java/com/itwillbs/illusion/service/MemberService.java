package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;

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
	private BCryptPasswordEncoder passwordEncoder;

	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo) {
		return mapper.insertMailAuthInfo(mailAuthInfo);
	}

	public int updateMailAuthStatus(MailAuthInfo mailAuthInfo) {
		return mapper.updateMailAuthStatus(mailAuthInfo);
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
	public boolean insertMember(MemberVO member) {
		String rawPassword = member.getMember_pw(); // 암호화
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setMember_pw(encodedPassword);

		if (rawPassword == null || rawPassword.isEmpty()) {
			throw new IllegalArgumentException("비밀번호가 입력되지 않았습니다.");

		}

		int insertCount = mapper.insertMember(member);
		return insertCount > 0;
	} // 개인회원


	// 기업회원 가입 처리 (멤버 + 컴퍼니 테이블에 동시에 저장)
	@Transactional
	public boolean insertCompanyMember(MemberVO member) {
		String rawPassword = member.getMember_pw(); // 암호화
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setMember_pw(encodedPassword);

		if (rawPassword == null || rawPassword.isEmpty()) {
			throw new IllegalArgumentException("비밀번호가 입력되지 않았습니다.");
		}
		int insertCompany = mapper.insertCompanyMember(member);
		return insertCompany > 0;
	} // 기업회원
       
}

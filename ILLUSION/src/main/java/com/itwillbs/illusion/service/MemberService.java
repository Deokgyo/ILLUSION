package com.itwillbs.illusion.service;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	MemberMapper mapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo) {
		return mapper.insertMailAuthInfo(mailAuthInfo);
	}

	// 회원가입 비즈니스 로직 메서드
	@Transactional
	public boolean insertMember(MemberVO member) {
		String rawPassword = member.getMember_pw(); // 암호화
		
		if (rawPassword == null || rawPassword.isEmpty()) {
			throw new IllegalArgumentException("비밀번호가 입력되지 않았습니다.");
		}

		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setMember_pw(encodedPassword);


		int insertCount = mapper.insertMember(member);
		return insertCount > 0;
	} // 개인회원

	@Transactional
	public boolean requestEmailAuth(MailAuthInfo mailAuthInfo) {

		boolean isAuthSuccess = false;

		// DB에 인증번호 select
		MailAuthInfo dbMailAuthInfo = mapper.selectMailAuthInfo(mailAuthInfo);

		if (dbMailAuthInfo != null) { // 이메일에 대한 인증코드가 존재할 경우
			String auth_code = mailAuthInfo.getAuth_code();
			String db_auth_code = dbMailAuthInfo.getAuth_code();

			if (auth_code.equals(db_auth_code)) {
				System.out.println("난수 인증 성공!!!");

				// 1. Member 테이블에 mail_auth_status = 'Y'로 바꾸는 작업
				mapper.updateMailAuthStatus(mailAuthInfo);

				// 2. mail_auth_info 테이블에 ROW 삭제
				mapper.deleteMailAuthInfo(mailAuthInfo);

				isAuthSuccess = true;
			}
		}

		return isAuthSuccess;
	}
	
	public MemberVO getMemberById(String member_id) {
        return mapper.getMemberById(member_id);
    }
	
	// 
	public MemberVO getMemberInfoById(String member_id) {
		return mapper.getMemberInfoById(member_id);
	}
	
}

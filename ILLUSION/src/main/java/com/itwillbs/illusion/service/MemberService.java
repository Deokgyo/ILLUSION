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

	private static final String MemberVO = null;
	@Autowired
	MemberMapper mapper;

	public MemberVO getMemberInfo(String id) {
		return mapper.getMemberInfo(id);
	}

	public Map<String, String> checkIdMap(String id) {
		return mapper.checkIdMap(id);
	}

	public int checkId(String id) {
		return mapper.checkId(id);
	}


	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo) {
		return mapper.insertMailAuthInfo(mailAuthInfo);
	}

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

//				// 1. Member 테이블에 mail_auth_status = 'Y'로 바꾸는 작업
//				mapper.updateMailAuthStatus(mailAuthInfo);
//
//				// 2. mail_auth_info 테이블에 ROW 삭제
//				mapper.deleteMailAuthInfo(mailAuthInfo);

				isAuthSuccess = true;
			}

		}

		return isAuthSuccess;
	}
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	// 회원가입 비즈니스 로직 메서드
	@Transactional
	public boolean insertMember(MemberVO member) {
		// 비밀번호 암호화(optional)
		// member.setMember_pw(passwordEncoder.encode(member.getMember_pw()));
		// 기타 유효성 검사 및 초기값 세팅 가능
		
		// 암호화
        String rawPassword = member.getMember_pw();
        String encodedPassword = passwordEncoder.encode(rawPassword);
        member.setMember_pw(encodedPassword);
		
		int insertCount = mapper.insertMember(member);
		return insertCount > 0; // insert 성공시 true 반환
	}


}

package com.itwillbs.illusion.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Service
public class MemberService {

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

	public int insertMember(MemberVO member) {
		return mapper.insertMember(member);
	}

	public int insertMailAuthInfo(MailAuthInfo mailAuthInfo) {
		return mapper.insertMailAuthInfo(mailAuthInfo);
	}

	// 메일 인증 처리 요청
	// => 메일 인증 처리 과정에서 UPDATE & DELETE 작업을 차례대로 수행하는데
	// 이때, 두 작업을 하나의 트렌잭션으로 묶어 처리하기 위해 @Taransactional 어노테이션 사용
	// (개발자가 별도로 commit 또는 rollback 작업을 지시하지 않아도 자동으로 처리)
	// => 주의! root-context.xml 파일에 마이바티스 설정 항목에 트렌잭션 설정 추가 필요!
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

}

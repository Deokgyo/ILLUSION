package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.LoginMapper;
import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.vo.MailAuthInfo;
import com.itwillbs.illusion.vo.MemberVO;

@Service
public class LoginService {
	
	@Autowired
	LoginMapper mapper;

	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	MailService mailService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder; 
	
	// 로그인
    public Map<String, Object> loginMember(Map<String, String> params) {
        Map<String, Object> dbMember = mapper.selectMemberById(params.get("member_id"));
        
        if (dbMember != null && dbMember.get("member_pw").equals(params.get("member_pw"))) {
            return dbMember;
        }
        
        return null;
    }

	// 아이디 찾기 - 인증번호 발송
	public boolean sendIdFindAuthCode(String member_name, String member_email) {
		// 1. 이름과 이메일로 회원 존재 여부 확인
		Map<String, String> findParams = new HashMap<String, String>();
		findParams.put("member_name", member_name);
		findParams.put("member_email", member_email);
		int count = mapper.selectMemberByNameAndEmail(findParams);

		if(count > 0) {
			// 2. 메일 발송을 위한 MemberVO 객체 생성
			MemberVO member = new MemberVO();
			member.setMember_email(member_email);

			// 3. 인증 메일 발송 및 인증 정보 객체 리턴
			MailAuthInfo mailAuthInfo = mailService.sendAuthMail(member);

			// 4. 인증 정보를 DB에 저장
			memberMapper.insertMailAuthInfo(mailAuthInfo);

			return true; // 성공
		}

		return false; // 실패
	}

	// 아이디 찾기 - 인증 확인 및 아이디 반환
	public Map<String, String> verifyIdAndReturnId(String member_email, String auth_code, String member_name) {
		Map<String, String> response = new HashMap<String, String>();

		// 1. 인증번호 일치 확인
		MailAuthInfo mailAuthInfo = new MailAuthInfo();
		mailAuthInfo.setEmail(member_email);
		mailAuthInfo.setAuth_code(auth_code);
		MailAuthInfo storedAuthInfo = memberMapper.selectMailAuthInfo(mailAuthInfo);

		if(storedAuthInfo != null && auth_code.equals(storedAuthInfo.getAuth_code())) {
			// 2. 인증 정보 삭제
			memberMapper.deleteMailAuthInfo(mailAuthInfo);

			// 3. 아이디 조회 (매퍼에서 결과 메시지까지 처리)
			Map<String, String> params = new HashMap<String, String>();
			params.put("member_email", member_email);
			params.put("member_name", member_name);
			response = mapper.selectMemberId(params);

		} else {
			response.put("result", "fail");
			response.put("msg", "인증에 실패했습니다. 인증번호를 다시 확인해주세요.");
		}
		
		return response;
	}

	// 비밀번호 찾기 - 인증번호 발송
	public boolean sendPasswordResetAuthCode(String member_id, String member_email) {
		// 1. 아이디와 이메일로 회원 존재 여부 확인
		Map<String, String> findParams = new HashMap<String, String>();
		findParams.put("member_id", member_id);
		findParams.put("member_email", member_email);
		int count = mapper.checkMemberIdAndEmailExists(findParams);

		if(count > 0) {
			// 2. 메일 발송을 위한 MemberVO 객체 생성
			MemberVO member = new MemberVO();
			member.setMember_email(member_email);

			// 3. 인증 메일 발송 및 인증 정보 객체 리턴
			MailAuthInfo mailAuthInfo = mailService.sendAuthMail(member);

			// 4. 인증 정보를 DB에 저장
			memberMapper.insertMailAuthInfo(mailAuthInfo);

			return true; // 성공
		}

		return false; // 실패
	}

	// 비밀번호 찾기 - 인증 확인 및 비밀번호 재설정
	public Map<String, String> verifyCodeAndResetPassword(String member_id, String member_email, String auth_code) {
		Map<String, String> response = new HashMap<String, String>();

		// 1. 인증번호 일치 확인
		MailAuthInfo mailAuthInfo = new MailAuthInfo();
		mailAuthInfo.setEmail(member_email);
		mailAuthInfo.setAuth_code(auth_code);
		MailAuthInfo storedAuthInfo = memberMapper.selectMailAuthInfo(mailAuthInfo);

		if(storedAuthInfo != null && auth_code.equals(storedAuthInfo.getAuth_code())) {
			// 2. 인증 정보 삭제
			memberMapper.deleteMailAuthInfo(mailAuthInfo);

			// 3. 임시 비밀번호 생성 (8자리)
			String tempPassword = UUID.randomUUID().toString().substring(0, 8);
			
			// 4. 비밀번호 암호화
			String encodedPassword = passwordEncoder.encode(tempPassword);
			
			// 5. DB에 암호화된 비밀번호로 업데이트
			Map<String, String> updateParams = new HashMap<String, String>();
			updateParams.put("member_id", member_id);
			updateParams.put("member_passwd", encodedPassword);
			mapper.updateMemberPassword(updateParams);
			
			// 6. 성공 응답 구성
			response.put("result", "success");
    		response.put("msg", "회원님의 임시 비밀번호는 [ " + tempPassword + " ] 입니다. 로그인 후 비밀번호를 변경해주세요.");
		} else {
			// 7. 실패 응답 구성
			response.put("result", "fail");
    		response.put("msg", "인증에 실패했습니다. 인증번호를 다시 확인해주세요.");
		}
		
		return response;
	}
    
}
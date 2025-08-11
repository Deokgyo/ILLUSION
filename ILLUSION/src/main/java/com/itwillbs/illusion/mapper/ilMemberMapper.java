package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.ilMailAuthInfo;
import com.itwillbs.illusion.vo.ilMemberVO;

@Mapper
public interface ilMemberMapper {
	public Map<String, String> checkIdMap(String id);
	public int checkId(String id);
	public int insertMember(ilMemberVO member);
	// 메일 인증 등록 및 수정
	public int insertMailAuthInfo(ilMailAuthInfo mailAuthInfo);
	// 메일 인증 정보 조회
	public ilMailAuthInfo selectMailAuthInfo(ilMailAuthInfo mailAuthInfo);
	// Member 테이블의 mail_auth_status 컬럼을 'Y'로 변경
	public int updateMailAuthStatus(ilMailAuthInfo mailAuthInfo);
	// mail_auth_info 테이블 row 삭제
	public int deleteMailAuthInfo(ilMailAuthInfo mailAuthInfo);
	public ilMemberVO getMemberInfo(String id);
	
}

package com.itwillbs.illusion.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TokenService {
    private final MemberMapper memberMapper; // Member 테이블을 업데이트할 Mapper

    /**
     * 특정 회원의 토큰을 증가시킵니다.
     * @param memberIdx 토큰을 충전할 회원의 ID
     * @param tokenAmount 충전할 토큰의 양
     * @return 충전 후의 최종 토큰 개수
     */
    @Transactional
    public int addTokensToMember(int memberIdx, int tokenAmount) {
        
        // 1. Mapper를 호출하여 DB의 토큰 값을 업데이트
        memberMapper.updateMemberTokens(memberIdx, tokenAmount);
        
        // 2. (선택사항) 업데이트 후의 최신 토큰 값을 다시 조회하여 반환
        Integer currentTokens = memberMapper.selectMemberTokens(memberIdx);
        
        return (currentTokens != null) ? currentTokens : 0;
    }

}

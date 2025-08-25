package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.ApplyMapper;
import com.itwillbs.illusion.mapper.MemberMapper;
import com.itwillbs.illusion.mapper.MyPostMapper;
import com.itwillbs.illusion.mapper.ScrapMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.BoardVO;
import com.itwillbs.illusion.vo.ScrapVO;

@Service
public class MypageService {
	
	@Autowired
	MemberMapper memberMapper;
		
	@Autowired
	ScrapMapper scrapMapper;
	
	@Autowired
	ApplyMapper applyMapper;
	
	@Autowired
	MyPostMapper myPostMapper;
	
	
	// 마이페이지 스크랩 목록
	public List<ScrapVO> getScrapsByMemberId(int member_idx, int startRow, int listLimit){
		return scrapMapper.getScrapsByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getScrapCountByMember (int member_idx) {
		return scrapMapper.getScrapCountByMember(member_idx);
	}
	
	// 스크랩 기능
    public boolean toggleScrap(int member_idx, int recruit_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("member_idx", member_idx);
        params.put("recruit_idx", recruit_idx);

        // 1. 먼저 이 사용자가 이 공고를 이미 스크랩했는지 DB에서 확인
        if (scrapMapper.selectScrapCount(params) > 0) {
            // 2. 이미 스크랩했다면 -> 삭제(DELETE) 실행
        	scrapMapper.deleteScrap(params);
            return false;
        } else {
        // 3. 스크랩하지 않았다면 -> 추가(INSERT) 실행
        	scrapMapper.insertScrap(params);
        }
        return true;
    }
        
    public boolean isScrapped(int member_idx, int recruit_idx) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("member_idx", member_idx);
        params.put("recruit_idx", recruit_idx);

        // Mapper를 호출하여 스크랩 개수를 조회합니다.
        int scrapCount = scrapMapper.selectScrapCount(params);
        
        return scrapCount > 0;
    }
    
    // 마이페이지 관심공고 리스트 삭제 기능
    @Transactional // 여러 건을 삭제하므로 트랜잭션 처리
    public int deleteScraps(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        return scrapMapper.deleteScraps(params);
    }
	
	// 마이페이지 입사지원 목록
	public List<ApplyVO> getApplyByMemberId(int member_idx, int startRow, int listLimit){
		return applyMapper.getApplyByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getApplyCountByMember (int member_idx) {
		return applyMapper.getApplyCountByMember(member_idx);
	}
	
	// 마이페이지 입사지원 리스트 삭제 기능
    @Transactional 
    public int deleteApplys(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        return applyMapper.deleteApplys(params);
    }
	
	// 마이페이지 내가 쓴 글 목록
	public List<BoardVO> getMyPostByMemberId(int member_idx, int startRow, int listLimit){
		return myPostMapper.getMyPostByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getMyPostCountByMember (int member_idx) {
		return myPostMapper.getMyPostCountByMember(member_idx);
	}
	
	// 마이페이지 내가 쓴 글 삭제 기능
    @Transactional 
    public int deleteMyPosts(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        return myPostMapper.deleteMyPosts(params);
    }
	
	
}

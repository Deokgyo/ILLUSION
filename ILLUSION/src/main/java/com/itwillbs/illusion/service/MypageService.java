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
import com.itwillbs.illusion.mapper.QuestionMapper;
import com.itwillbs.illusion.mapper.ResumeMapper;
import com.itwillbs.illusion.mapper.ScrapMapper;
import com.itwillbs.illusion.vo.ApplyVO;
import com.itwillbs.illusion.vo.BoardVO;
import com.itwillbs.illusion.vo.CoverLetterVO;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.QuestionVO;
import com.itwillbs.illusion.vo.ResumeVO;
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
	
	@Autowired
	ResumeMapper resumeMapper;
	
	@Autowired
	QuestionMapper questionMapper;
	
	// 마이페이지 이력서 목록
	
	public List<ResumeVO> getResumeListByMemberId(int member_idx, int startRow, int listLimit) {
		return resumeMapper.getResumeListByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getResumeListCountByMember(int member_idx) {
		return resumeMapper.getResumeListCountByMember(member_idx);
	}
	
	// 마이페이지 이력서 목록 삭제 기능
    @Transactional 
    public int deleteMyResumes(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        return resumeMapper.deleteMyResumes(params);
    }
    
    public List<ResumeVO> savedResumeDetail(int resumeIdx) {
    	return resumeMapper.savedResumeDetail(resumeIdx);
    }
	
	// 마이페이지 자소서 목록
	
	public List<CoverLetterVO> getCLListByMemberId(int member_idx, int startRow, int listLimit) {
		return resumeMapper.getCLListByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getCLListCountByMember(int member_idx) {
		return resumeMapper.getCLListCountByMember(member_idx);
	}
	
    // 마이페이지 자소서 삭제 기능
    @Transactional // 여러 건을 삭제하므로 트랜잭션 처리
    public int deleteMyCLs(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        questionMapper.deleteAnswersByClIdxList(idList);

        questionMapper.deleteQuestionsByClIdxList(idList);
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        return resumeMapper.deleteMyCLs(params);
    }
    
	// 마이페이지 면접 예상 질문 목록
	public List<QuestionVO> getQuestionListByMemberId(int member_idx, int clIdx, int startRow, int listLimit){
		return questionMapper.getQuestionListByMemberId(member_idx, clIdx, startRow, listLimit);
	}
	
	public int getQuestionListCountByMember(int member_idx) {
		return questionMapper.getQuestionListCountByMember(member_idx);
	}
	
	 // 마이페이지 면접 질문 삭제 기능
    @Transactional 
    public int deleteMyQuestionList(int memberIdx, List<Integer> idList) {
        if (idList == null || idList.isEmpty()) {
            return 0;
        }
        
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        params.put("idList", idList);
        
        questionMapper.deleteMyAnswerList(params);

        int deletedQuestions = questionMapper.deleteMyQuestionList(params);

        return deletedQuestions;
    }
	
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
	public List<BoardVO> getMyPostByMemberId(int member_idx, String categoryCode, int startRow, int listLimit){
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", member_idx);
        params.put("categoryCode", categoryCode);
        params.put("startRow", startRow);
        params.put("listLimit", listLimit);
		return myPostMapper.getMyPostByMemberId(params);
	}
	
	public int getMyPostCountByMember (int member_idx, String categoryCode) {
        Map<String, Object> params = new HashMap<>();
        params.put("memberIdx", member_idx);
        params.put("categoryCode", categoryCode);
		return myPostMapper.getMyPostCountByMember(params);
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

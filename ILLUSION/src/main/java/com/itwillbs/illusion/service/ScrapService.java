package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.ScrapMapper;
import com.itwillbs.illusion.vo.ScrapVO;

@Service
public class ScrapService {
		
	@Autowired
	ScrapMapper mapper;
	
	public List<ScrapVO> getScrapsByMemberId(int member_idx, int startRow, int listLimit){
		return mapper.getScrapsByMemberId(member_idx, startRow, listLimit);
	}
	
	public int getScrapCountByMember (int member_idx) {
		return mapper.getScrapCountByMember(member_idx);
	}
	
	
	// 스크랩 기능
    public boolean toggleScrap(int member_idx, int recruit_idx) {
        Map<String, Object> params = new HashMap<>();
        params.put("member_idx", member_idx);
        params.put("recruit_idx", recruit_idx);

        // 1. 먼저 이 사용자가 이 공고를 이미 스크랩했는지 DB에서 확인
        if (mapper.selectScrapCount(params) > 0) {
            // 2. 이미 스크랩했다면 -> 삭제(DELETE) 실행
        	mapper.deleteScrap(params);
            return false;
        } else {
        // 3. 스크랩하지 않았다면 -> 추가(INSERT) 실행
    	mapper.insertScrap(params);
        }
        return true;
    }
        
    public boolean isScrapped(int member_idx, int recruit_idx) {
        
        Map<String, Object> params = new HashMap<>();
        params.put("member_idx", member_idx);
        params.put("recruit_idx", recruit_idx);

        // Mapper를 호출하여 스크랩 개수를 조회합니다.
        int scrapCount = mapper.selectScrapCount(params);
        
        return scrapCount > 0;
    }
	
}

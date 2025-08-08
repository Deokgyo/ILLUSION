package com.itwillbs.illusion.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.ResumeMapper;
import com.itwillbs.illusion.vo.ResumeVO;



@Service
public class ResumeService {
	@Autowired
	ResumeMapper mapper;
	
	   public int insertResume(Map<String, Object> resumeMap) {
	        return mapper.insertResume(resumeMap);
	    }
	   
	   public Map<String, Object> selectMember(int member_idx) {
		   return mapper.selectMember(member_idx);
	   }
	    public Map<String, Object> selectResume(int resumeIdx) {
	        return mapper.selectResume(resumeIdx);
	    }
}

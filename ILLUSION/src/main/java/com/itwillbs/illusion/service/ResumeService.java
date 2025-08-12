package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.ResumeMapper;
import com.itwillbs.illusion.vo.ResumeVO;



@Service
public class ResumeService {
	@Autowired
	ResumeMapper mapper;

	    @Transactional
	    public void insertResumeAndExpInfo(Map<String, Object> paramMap) {
	        // 1. resume insert - 여기서 resume_idx가 paramMap에 자동 세팅됩니다.
	    	mapper.insertResume(paramMap);

	        // 2. resume_exp_info insert - resume_idx 포함 필수
	    	mapper.insertResume_exp_info(paramMap);
	    }
	   
	   public Map<String, Object> selectMember(int member_idx) {
		   return mapper.selectMember(member_idx);
	   }
	   public Map<String, Object> selectResume(int resumeIdx) {
	        return mapper.selectResume(resumeIdx);
	   }
	   
	  
	   public List<Map<String, Object>> selectResumelist() {
		   return mapper.selectResumelist();
	   }
	   public List<Map<String, Object>> selectResumeExpInfoList(int resume_idx) {
	        return mapper.selectResumeExpInfoList(resume_idx);
	   }
	   
	   
	   
	   
	   
	   
	   
	   
	   /* 예상면접질문 */
	   public List<Map<String, Object>> selectquestList() {
		   return mapper.selectquestList();
	   }
	   
	   
	 
	   
	   
	   	   
	   /*자기소개서*/
	   public Map<String, Object> selectCL(int cl_idx) {
	        return mapper.selectResume(cl_idx);
	   }
	   public List<Map<String, Object>> selectcllist() {
		   return mapper.selectcllist();
	   }
	
	   /* 커뮤니티 */
	   public List<Map<String, Object>> selectboard() {
		   return mapper.selectboard();
	   }
}

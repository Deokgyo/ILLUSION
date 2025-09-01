package com.itwillbs.illusion.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.illusion.mapper.ResumeMapper;
import com.itwillbs.illusion.vo.ResumeVO;
import com.itwillbs.illusion.vo.CommonCodeVO;
import com.itwillbs.illusion.vo.MemberVO;


@Service
public class ResumeService {
	@Autowired
	ResumeMapper mapper;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	// 이력서 작성
    public ResumeVO getResumeForEdit(int memberIdx) {
        
        Map<String, Integer> params = new HashMap<>();
        params.put("memberIdx", memberIdx);
        
        return mapper.getResumeForEdit(params);
    }
    
	// 이력서 수정
    public ResumeVO getResumeForEdit1(int resumeIdx, int memberIdx) {
        
        Map<String, Integer> params = new HashMap<>();
        params.put("resumeIdx", resumeIdx);
        params.put("memberIdx", memberIdx);
        
        return mapper.getResumeForEdit1(params);
    }
    
    public ResumeVO getExpForEdit(int resumeIdx) {
        
        Map<String, Integer> params = new HashMap<>();
        params.put("resumeIdx", resumeIdx);
        
        return mapper.getExpForEdit(params);
    }

	    @Transactional
	    public void insertResumeAndExpInfo(Map<String, Object> paramMap) {
	        // 1. resume insert - 여기서 resume_idx가 paramMap에 자동 세팅됩니다.
	    	mapper.insertResume(paramMap);

	        // 2. resume_exp_info insert - resume_idx 포함 필수
	    	mapper.insertResume_exp_info(paramMap);
	    }
	    @Transactional
	    public void updateResumeAndExpInfo(Map<String, Object> paramMap) {
	    	// 1. resume insert - 여기서 resume_idx가 paramMap에 자동 세팅됩니다.
	    	mapper.updateResume(paramMap);
	    	
	    	// 2. resume_exp_info insert - resume_idx 포함 필수
	    	mapper.updateResume_exp_info(paramMap);
	    }
	   
	   public Map<String, Object> selectMember(int member_idx) {
		   return mapper.selectMember(member_idx);
	   }
	   public Map<String, Object> selectResume(int resumeIdx) {
	        return mapper.selectResume(resumeIdx);
	   }
	   
	   /*이력서 회원정보*/
	   public MemberVO SelectM(String member_id) {
			return mapper.SelectM(member_id);
		}
	   
	   
	   /*이력서 공통코드*/
	   public List<CommonCodeVO> getCodes(String groupId) {
	        return mapper.getCommonCodeList(groupId);
	    }
	   public List<CommonCodeVO> getCodes1(String groupId) {
		   return mapper.getCommonCodeList1(groupId);
	   }
	  
	   
	   /*이력서 목록*/
	   public List<Map<String, Object>> selectResumelist() {
		   return mapper.selectResumelist();
	   }
	   public List<Map<String, Object>> selectResumeExpInfoList(int resume_idx) {
	        return mapper.selectResumeExpInfoList(resume_idx);
	   }
	   
	   
	   public void updateuserInfoEdit(Map<String, Object> paramMap) {
	        mapper.updateuserInfoEdit(paramMap);
	    }
	   public Map<String, Object> selectuserInfoEdit(int member_idx) {
		   return mapper.selectuserInfoEdit(member_idx);
	   }
	   public String getProfilePicturePath(int memberIdx) {
		    return	mapper.getProfilePicturePath(memberIdx);
		}
	   /*비밀번호 변경*/
	   public void changePasswd(int member_idx, String member_pw) {
		   
		   	String encodedPw = passwordEncoder.encode(member_pw);
	        mapper.changePasswd(member_idx, encodedPw);
	    }
	// ResumeService.java
	   public boolean deleteMember(int memberIdx) {
	       return mapper.deleteMember(memberIdx) > 0; // Mapper 쿼리와 일치
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

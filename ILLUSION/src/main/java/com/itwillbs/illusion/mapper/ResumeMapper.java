package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface ResumeMapper {
	

	int insertResume(Map<String, Object> resumeMap);
	int insertResume_exp_info(Map<String, Object> resumeMap);
    Map<String, Object> selectResume(int resumeIdx);
	Map<String, Object> selectMember(int member_idx);
	
	List<Map<String, Object>> selectResumeExpInfoList(int resume_idx);
	List<Map<String, Object>> selectResumelist();
	
	
	/* 예상면접질문 */
	List<Map<String, Object>> selectquestList();

	/* 커뮤니티 */
	List<Map<String, Object>> selectboard();
	
	
	
	
	
	
	
	/* 자기소개서 */
	Map<String, Object> selectcl(int cl_idx);
	List<Map<String, Object>> selectcllist();
	
}

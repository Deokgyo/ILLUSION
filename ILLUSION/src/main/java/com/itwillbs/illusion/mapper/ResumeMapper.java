package com.itwillbs.illusion.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.illusion.vo.ResumeVO;
@Mapper
public interface ResumeMapper {
	

	int insertResume(Map<String, Object> resumeMap);
    Map<String, Object> selectResume(int resumeIdx);
	Map<String, Object> selectMember(int member_idx);
}

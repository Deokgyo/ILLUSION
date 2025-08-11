package com.itwillbs.illusion.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface RecruiterMapper {
	// 대분류 값 가져오기 
	public List<Map<String, String>> getLocation();
	
	// 소분류 값 가져오기 
	public List<Map<String, String>> getlocDetailList(@Param("location") String location);
	
	// 직무 대분류 값 가져오기 
	public List<Map<String, String>> getOccupation();
	
	// 직무 소분류 값 가져오기 
	public List<Map<String, String>> getJobList(@Param("occupation") String occupation);
}

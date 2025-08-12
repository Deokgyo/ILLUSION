package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.illusion.mapper.JobToolsMapper;

@Service
public class JobToolsService {
	
	@Autowired
	JobToolsMapper mapper;
	
	// 직무 대분류 가져오기 
	public List<Map<String, String>> getOccupation() {
		return mapper.getOccupation();
	}
	
	// 직무 소분류 가져오기 
	public List<Map<String, String>> getJobList(String occupation) {
		return mapper.getJobList(occupation);
	}
	
	// 경력 가져오기
	public List<Map<String, String>> getExperience() {
		return mapper.getExperience();
	}
}

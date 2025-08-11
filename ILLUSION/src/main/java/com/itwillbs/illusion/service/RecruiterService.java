package com.itwillbs.illusion.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.illusion.mapper.RecruiterMapper;

@Service
public class RecruiterService {
	
	@Autowired
	RecruiterMapper mapper;
	
	// 대분류 값 가져오기 
	public List<Map<String, String>> getLocation() {
		return mapper.getLocation();
	}
	
	//소분류 값 가져오기 
	public List<Map<String, String>> getlocDetailList(String location) {
		return mapper.getlocDetailList(location);
	}
	
	
	// 직무 대분류 가져오기 
	public List<Map<String, String>> getOccupation() {
		return mapper.getOccupation();
	}
	
	// 직무 소분류 가져오기 
	
	public List<Map<String, String>> getJobList(String occupation) {
		return mapper.getJobList(occupation);
	}
}

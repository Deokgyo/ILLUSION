package com.itwillbs.illusion.controller.recruiter;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.illusion.service.RecruiterService;

@RestController
public class OccupationController {
	
	@Autowired
	RecruiterService service;
	
	@GetMapping("getJobList")
	public List<Map<String, String>> getJobList(@RequestParam String occupation) {
		// location 대분류 val 값을 가져와서 이거 쿼리문에 써야함 
		// 값을 보내기 위해 리스트에 담음 
		List<Map<String, String>> getJobList = service.getJobList(occupation);
		
		System.out.println(getJobList);
//		List<Map<String, String>> locDetailList = new ArrayList<Map<String,String>>();
		
		return getJobList;
	}
}

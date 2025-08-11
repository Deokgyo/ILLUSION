package com.itwillbs.illusion.controller.recruiter;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.itwillbs.illusion.service.RecruiterService;

@RestController
public class LocationController {
	
	@Autowired
	RecruiterService service;
	
	@GetMapping("getlocDetailList")
	public List<Map<String, String>> getlocDetailList(@RequestParam String location) {
		// location 대분류 val 값을 가져와서 이거 쿼리문에 써야함 
		// 값을 보내기 위해 리스트에 담음 
		List<Map<String, String>> locDetailList = service.getlocDetailList(location);
		
		System.out.println(locDetailList);
//		List<Map<String, String>> locDetailList = new ArrayList<Map<String,String>>();
		
		return locDetailList;
	}
}

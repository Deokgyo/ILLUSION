package com.itwillbs.illusion.controller.recruiter;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.itwillbs.illusion.service.RecruiterService;

@RestController
public class AjaxController {
	
	@Autowired
	RecruiterService service;
	
	@GetMapping("getlocDetailList")
	public List<Map<String, String>> getlocDetailList(@RequestParam String location) {
		List<Map<String, String>> locDetailList = service.getlocDetailList(location);
		return locDetailList;
	}
	
	@GetMapping("getJobList")
	public List<Map<String, String>> getJobList(@RequestParam String occupation) {
		List<Map<String, String>> getJobList = service.getJobList(occupation);
		return getJobList;
	}
}

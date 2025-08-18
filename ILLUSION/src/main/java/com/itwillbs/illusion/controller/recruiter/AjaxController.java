package com.itwillbs.illusion.controller.recruiter;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.RecruiterService;
import com.itwillbs.illusion.vo.RecruitVO;

@RestController
public class AjaxController {
	
	@Autowired
	RecruiterService service;
	// 업로드 할 가상 경로 
	String virtualPath = "/resources/upload";
	
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
	
	@GetMapping("getRecruitmentList")
	public List<Map<String, Object>> getRecruitmentList(@RequestParam(defaultValue = "RECS%") String status) {
		List<Map<String, Object>> recruitmentList = service.getRecruitmentList(status);
		return recruitmentList;
	}
//	public List<RecruitVO> getRecruitmentList() {
//		List<RecruitVO> recruitmentList = service.getRecruitmentList();
//		return recruitmentList;
//	}
	
	
	@PostMapping("imgUpload")
	public Map<String,String> imgUpload(
			RecruitVO recruit,
			HttpServletRequest req) {
		
		String realPath = req.getServletContext().getRealPath(virtualPath);
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		
		MultipartFile file = recruit.getFile();
		
		String fileName = "";
		String origin = file.getOriginalFilename();
		
		if(!origin.equals("")) {
			fileName = UUID.randomUUID().toString() + "_" + origin;
		}
		
		try {
			if(!file.getOriginalFilename().equals("")) {
				file.transferTo(new File(realPath, fileName));
			} 
		} catch (Exception e) {
			e.printStackTrace();
		}
		Map<String, String> data = new HashMap<String, String>();
		data.put("url", "resources/upload/" + subDir + "/" + fileName);
		return data;
	}
	
	private String createDirectories(String realPath) {
		LocalDate today = LocalDate.now();
		String datePattern = "yyyy/MM/dd";
		DateTimeFormatter dft = DateTimeFormatter.ofPattern(datePattern);
		String subDir = today.format(dft);
		realPath += "/" + subDir;
		try {
			// 5-1) java.nio.file.Paths 클래스의 get() 메서드 호출 Path 객체 리턴 
			Path path = Paths.get(realPath);
			// 5-2) Files 클래스의 createDirectories() 호출하여 실제 경로 생성 
			Files.createDirectories(path);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return subDir;
	}
	
}

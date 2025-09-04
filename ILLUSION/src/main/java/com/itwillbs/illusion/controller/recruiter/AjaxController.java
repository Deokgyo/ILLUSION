package com.itwillbs.illusion.controller.recruiter;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
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

import com.itwillbs.illusion.service.CompanyService;
import com.itwillbs.illusion.service.RecruiterService;
import com.itwillbs.illusion.util.SecurityUtil;
import com.itwillbs.illusion.vo.RecruitVO;

@RestController
public class AjaxController {
	
	@Autowired
	RecruiterService service;
	
	@Autowired
	CompanyService companyService;
	
	// 업로드 할 가상 경로 
	String virtualPath = "/resources/upload/";
	
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
	public List<Map<String, Object>> getRecruitmentList(@RequestParam(defaultValue = "RECS%") String status, Principal principal) {
		String member_id = principal.getName();
		List<Map<String, Object>> recruitmentList = service.getRecruitmentList(status, member_id);
		return recruitmentList;
	}
	
	@PostMapping("getCompanyInfo") 
	public Map<String, String> getCompanyInfo(Principal principal) {
		String member_id = principal.getName();
		Map<String, String> companyInfoMap = service.getCompanyInfo(member_id);
		return companyInfoMap;
	}
	
	@PostMapping("getApply")
	public List<Map<String, Object>> getApply() {
		int member_idx = SecurityUtil.getLoginUserIndex();
		List<Map<String, Object>> applyList = service.getApply(member_idx);
		return applyList; 
	}
	
	@PostMapping("updateApplyStatus") 
	public boolean updateApplyStatus(
			@RequestParam("apply_idx") int apply_idx, 
			@RequestParam("status") String apply_status) {
		boolean isSuccess = service.updateApplyStatus(apply_idx, apply_status);
		return isSuccess;
	}
	
	@PostMapping("uploadCompanyLogo") 
	public Map<String, Object> uploadCompanyLogo(
			@RequestParam("logo") MultipartFile file,
			@RequestParam("company_idx") int company_idx,
			HttpServletRequest req) {
		
	    Map<String, Object> result = new HashMap<>();
		String realPath = req.getServletContext().getRealPath(virtualPath);
		String subDir = createDirectories(realPath);
		realPath += "/" + subDir;
		
	    try {
	        // 1. 파일 저장
	        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
	        file.transferTo(new File(realPath, fileName));
	        String contextPath = req.getContextPath(); 
	        String savePath = contextPath + virtualPath + subDir + "/" + fileName;
//	        // 2. DB 업데이트
	        String logoTag = "<img src='" + savePath + "'>";
	        companyService.updateCompanyLogo(company_idx, logoTag);

	        // 3. URL 반환
	        result.put("logoUrl", savePath);
	    } catch (Exception e) {
	        e.printStackTrace();
	        result.put("error", "파일 업로드 실패");
	    }
	    return result;
	}
	
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
		String contextPath = req.getContextPath();
		data.put("url", contextPath + "/upload/" + subDir + "/" + fileName);
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

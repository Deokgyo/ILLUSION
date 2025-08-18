package com.itwillbs.illusion.controller.jobTools;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.service.GeminiService;
import com.itwillbs.illusion.service.JobToolsService;

@Controller
public class CoverletterController {

	
	@Autowired
	JobToolsService service;
	
	@Autowired
	private GeminiService geminiService;
	
	// 자소서 생성 페이지 이동
	@GetMapping("coverletterCreate")
	public String coverletterCreate(Model model) {
		
		List<Map<String, String>> occupationList = service.getOccupation();
		model.addAttribute("occupationList", occupationList);
		
		
		List<Map<String, String>> expList = service.getExperience();
		model.addAttribute("expList", expList);
		
		
		return "jobTools/coverletterCreate";
	}
	
	// 자소서 생성
	// TODO 로그인 권한검사
	@ResponseBody
	@PostMapping("coverletterGenerate")
	public Map<String, Object> coverletterGenerate(Model model, HttpSession session,
	                                    String title, String company, 
	                                    String prevCompany, String prevJob, String occupation,
	                                    String maxLength, String keywords, String question, String experience) {
	    
	    String prompt = String.format(
	        "너는 이제부터 채용을 위한 자기소개서를 작성해주는 전문가야. 아래 조건에 맞춰서 자기소개서를 완벽하게 작성해줘.\n" +
	        "- 지원 회사: %s\n" +
	        "- 지원 직무: %s\n" +
	        "- 자기소개서 문항: %s\n" +
	        "- 이전 회사 및 직무 경험: %s에서 %s로 근무\n" +
	        "- 나의 핵심 경험/역량: %s\n" +
	        "- 반드시 포함할 키워드: %s\n" +
	        "- 글자 수 제한: %s자 이내\n" +
	        "- 위의 모든 조건을 충실하게 반영해서 자연스럽고 설득력 있는 어투로 자기소개서를 작성해줘. 결과는 자소서 내용만 출력해줘",
	        company, occupation, question, prevCompany, prevJob, experience, keywords, maxLength
	    );

	    System.out.println("--- 생성된 프롬프트 ---");
	    System.out.println(prompt);
	    
	    String aiResult = geminiService.callGeminiApi(prompt);
	    
	    
	    // 1. 공백 포함 글자 수 계산
	    String generated_char_count = Integer.toString(aiResult.length());
	    // 2. 공백 미포함 글자 수 계산
	    int generated_char_count_no_space = aiResult.replaceAll("\\s", "").length();

	    
	    
	    Map<String, Object> coverletterMap = new HashMap<String, Object>();
	    coverletterMap.put("aiResult", aiResult);
	    coverletterMap.put("company", company);
	    coverletterMap.put("title", title);
	    coverletterMap.put("generated_char_count", generated_char_count);
	    coverletterMap.put("generated_char_count_no_space", generated_char_count_no_space);
	    
	    int generatedClIdx = service.saveCoverletter(coverletterMap);
	    
	    // 성공 여부와 이동할 URL을 JSON 형태로 반환
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    response.put("redirectUrl", "coverletterResult?cl_idx=" + generatedClIdx); // 이동할 URL
	    
	    return response;
	}
	
	// 자소서 결과 페이지 이동
	@GetMapping("coverletterResult")
	public String showCoverletterResult(Model model, @RequestParam("cl_idx") int cl_idx) {
	    System.out.println("조회할 자소서 ID: " + cl_idx);

	    Map<String, Object> coverletter = service.getCoverletterById(cl_idx);
	    System.out.println(coverletter);
	    model.addAttribute("coverletter", coverletter);
	    
	    return "jobTools/coverletterResult";
	}
	
	// 자소서 저장 여부 수정
	@ResponseBody
	@PostMapping("saveToMypage")
	public Map<String, String> saveToMypage(@RequestParam("cl_idx") int cl_idx) {
	    String newStatus = service.toggleSaveToMypage(cl_idx);

	    Map<String, String> map = new HashMap<>();
	    if ("BOL001".equals(newStatus)) {
	        map.put("message", "마이페이지에 저장되었습니다.");
	        map.put("status", "saved");
	    } else {
	        map.put("message", "마이페이지 저장이 취소되었습니다.");
	        map.put("status", "unsaved");
	    }
	    return map;
	}
	
	// 자소서 수정 페이지 이동
	@GetMapping("coverletterModify")
	public String coverletterModify() {
		return "jobTools/coverletterModify";
	}
	
	// 자소서 다듬기 메인페이지 이동
	@GetMapping("coverletterRefiner")
	public String coverletterRefiner(Model model) {
		
		// TODO 로그인한 사용자로 변경해야함
		int member_idx = 1;
		
		List<Map<String, String>> clList = service.getCoverletterTitlesByMember(member_idx);
		
		System.out.println(clList);
		
		model.addAttribute("clList", clList);
		
		return "jobTools/coverletterRefiner";
	}
	
	
	// 자소서 다듬기 
	@PostMapping("refineNewCoverletter")
    @ResponseBody
    public Map<String, Object> refineNewCoverletter(
            @RequestParam String cl_input_method, // 'file' 또는 'text'
            @RequestParam(required = false) MultipartFile uploadedFile, // 파일 업로드
            @RequestParam(required = false) String coverletterText ) { // 직접 입력
        String originalContent = "";

        try {
            if ("file".equals(cl_input_method) && uploadedFile != null && !uploadedFile.isEmpty()) {
                // 1. 파일 업로드 방식일 경우
                // 파일의 내용을 byte 배열로 읽어와서 UTF-8 문자열로 변환
                originalContent = new String(uploadedFile.getBytes(), "UTF-8");
                System.out.println("업로드된 파일 내용: " + originalContent);
                
                // (선택) 실제 서버에 파일 저장 로직
                // String fileName = uploadedFile.getOriginalFilename();
                // File targetFile = new File("D:/upload/", fileName);
                // uploadedFile.transferTo(targetFile);

            } else if ("text".equals(cl_input_method) && coverletterText != null) {
                // 2. 직접 입력 방식일 경우
                originalContent = coverletterText;
                System.out.println("직접 입력된 내용: " + originalContent);
            }
            
            // TODO: originalContent를 GeminiService에 넘겨서 다듬기 로직 실행
            // String refinedContent = geminiService.refineCoverletter(originalContent);
            
        } catch (IOException e) {
            e.printStackTrace();
            // 에러 처리
        }

        Map<String, Object> response = new HashMap<>();
        response.put("success", true);
        // response.put("refinedContent", refinedContent);
        return response;
    }
	
	@GetMapping("interviewCreate")
	public String interviewCreate() {
		return "jobTools/interviewCreate";
	}
	
	@GetMapping("interviewResult")
	public String interviewResult() {
		return "jobTools/interviewResult";
	}
	
}
       
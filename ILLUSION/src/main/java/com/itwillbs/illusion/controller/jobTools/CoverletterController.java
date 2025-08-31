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

import com.itwillbs.illusion.service.JobToolsService;
import com.itwillbs.illusion.util.JobToolsConstants;
import com.itwillbs.illusion.util.SecurityUtil;
import com.itwillbs.illusion.validator.CoverletterValidator;
import com.itwillbs.illusion.vo.MemberVO;
import com.itwillbs.illusion.vo.CoverletterResponse;
import com.itwillbs.illusion.exception.ValidationException;


// 자소서 생성 및 첨삭 전용 컨트롤러

@Controller
public class CoverletterController {

    @Autowired
    private JobToolsService service;
    
    @Autowired
    private CoverletterValidator validator;

    // ===================================================================
    // 페이지 이동 (GET Mappings)
    // ===================================================================
    
    // 자소서 생성 페이지 이동
    @GetMapping("coverletterCreate")
    public String coverletterCreate(Model model) {
        model.addAttribute("occupationList", service.getOccupation());
        model.addAttribute("expList", service.getExperience());
        return "jobTools/coverletterCreate";
    }
    
    // 자소서 결과 페이지 이동 (통합)
    @GetMapping("coverletterResult")
    public String showCoverletterResult(Model model, @RequestParam("cl_idx") int cl_idx,
            @RequestParam(value = "original_cl_idx", required = false) Integer original_cl_idx) {
        
        Map<String, Object> coverletter = service.getCoverletterById(cl_idx);
        model.addAttribute("coverletter", coverletter);
        
        // CL002(첨삭된 자소서)인 경우에만 원본 자소서 정보 추가
        if (coverletter != null && "CL002".equals(coverletter.get("cl_type")) && original_cl_idx != null) {
            Map<String, Object> originalCoverletter = service.getCoverletterById(original_cl_idx);
            model.addAttribute("originalCoverletter", originalCoverletter);
        }
        
        return "jobTools/coverletterResult";
    }

    
    // 자소서 다듬기
    @GetMapping("coverletterRefiner")
    public String coverletterRefiner(Model model) {
        int member_idx = SecurityUtil.getLoginUserIndex();
        if (member_idx != -1) {
            List<Map<String, String>> clList = service.getCoverletterTitlesByMember(member_idx);
            model.addAttribute("clList", clList);
        }
        return "jobTools/coverletterRefiner";
    }
    

    // ===================================================================
    // 자소서 기능 처리 (POST Mappings - @ResponseBody)
    // ===================================================================
    // 자소서 생성
    @PostMapping("coverletterGenerate")
    @ResponseBody
    public CoverletterResponse coverletterGenerate(@RequestParam Map<String, String> params, HttpSession session) {
        try {
            // 검증 로직
            validator.validateLoginStatus();
            validator.validateGenerationRequest(params);
            validator.validateTokenBalance(SecurityUtil.getLoginUserIndex(), JobToolsConstants.COVER_LETTER_GENERATION_COST);
            
            // 비즈니스 로직
            Map<String, Object> serviceResult = service.generateAndSaveCoverletter(params);
            updateSessionToken(session, (Integer) serviceResult.get("newTokenCount"));
            
            int generatedClIdx = (int) serviceResult.get("generatedClIdx");
            Integer newToken = (Integer) serviceResult.get("newTokenCount");
            
            return CoverletterResponse.success(generatedClIdx, generatedClIdx, newToken);
        } catch (ValidationException e) {
            return CoverletterResponse.failure(e.getMessage());
        } catch (RuntimeException e) {
            return CoverletterResponse.failure(e.getMessage());
        }
    }

    // 새 자소서 다듬기
    @PostMapping("refineNewCoverletter")
    @ResponseBody
    public CoverletterResponse refineNewCoverletter(@RequestParam String cl_input_method,
            @RequestParam(required = false) MultipartFile uploadedFile,
            @RequestParam(required = false) String coverletterText, 
            @RequestParam("cl_title")String cl_title,
            @RequestParam("company_name")String company_name,
            HttpSession session) {

        try {
            // 기본 검증
            validator.validateLoginStatus();
            validator.validateTokenBalance(SecurityUtil.getLoginUserIndex(), JobToolsConstants.COVER_LETTER_REFINEMENT_COST);
            
            String originalContent = "";
            
            // 입력 방식별 검증 및 처리
            if ("file".equals(cl_input_method)) {
                validator.validateFileUpload(uploadedFile);
                originalContent = new String(uploadedFile.getBytes(), "UTF-8");
            } else if ("text".equals(cl_input_method)) {
                validator.validateRefinementTextRequest(coverletterText, cl_title, company_name);
                originalContent = coverletterText;
            } else {
                throw new ValidationException("올바르지 않은 입력 방식입니다.");
            }

            // 1. 원본 자소서 저장
            Map<String, Object> originalClMap = buildCoverletterMap(SecurityUtil.getLoginUserIndex(), cl_title, company_name, originalContent, JobToolsConstants.CL_TYPE_ORIGINAL_FOR_REFINEMENT);
            int originalClIdx = service.saveCoverletterOnly(originalClMap);

            // 2. 서비스 호출
            Map<String, Object> params = new HashMap<>();
            params.put("original_content", originalContent);
            params.put("member_idx", SecurityUtil.getLoginUserIndex());
            params.put("title", cl_title);
            params.put("company_name", company_name);
            params.put("original_cl_idx", originalClIdx);

            Map<String, Object> result = service.refineAndSaveCoverletter(params);
            updateSessionToken(session, (Integer) result.get("newTokenCount"));

            // 3. 성공 응답 반환
            int refinedClIdx = (int) result.get("refinedClIdx");
            Integer newToken = (Integer) result.get("newTokenCount");
            
            return CoverletterResponse.success(refinedClIdx, originalClIdx, newToken);

        } catch (ValidationException e) {
            return CoverletterResponse.failure(e.getMessage());
        } catch (IOException e) {
            return CoverletterResponse.failure("파일을 읽는 중 오류가 발생했습니다.");
        } catch (RuntimeException e) {
            return CoverletterResponse.failure(e.getMessage());
        }
    }
    
    // 저장된 자소서 다듬기
    @PostMapping("refineSavedCoverletter")
    @ResponseBody
    public CoverletterResponse refineSavedCoverletter(@RequestParam int cl_idx, HttpSession session) {
        try {
            // 기본 검증
            validator.validateLoginStatus();
            int currentMemberIdx = SecurityUtil.getLoginUserIndex();
            validator.validateTokenBalance(currentMemberIdx, JobToolsConstants.COVER_LETTER_REFINEMENT_COST);
            
            // 자소서 조회 및 권한 검증
            Map<String, Object> originalCoverletter = service.getCoverletterById(cl_idx);
            validator.validateRefinementPermission(originalCoverletter);

            // 비즈니스 로직
            Map<String, Object> params = new HashMap<>();
            params.put("original_content", originalCoverletter.get("generated_cl_content"));
            params.put("member_idx", currentMemberIdx);
            params.put("title", (String) originalCoverletter.get("cl_title"));
            params.put("company_name", (String) originalCoverletter.get("company_name"));
            params.put("original_cl_idx", cl_idx);

            Map<String, Object> result = service.refineAndSaveCoverletter(params);
            updateSessionToken(session, (Integer) result.get("newTokenCount"));

            int refinedClIdx = (int) result.get("refinedClIdx");
            int originalClIdx = (int) result.get("originalClIdx");
            Integer newToken = (Integer) result.get("newTokenCount");
            
            return CoverletterResponse.success(refinedClIdx, originalClIdx, newToken);
        } catch (ValidationException e) {
            return CoverletterResponse.failure(e.getMessage());
        } catch (RuntimeException e) {
            return CoverletterResponse.failure(e.getMessage());
        }
    }
    
    // 저장버튼 토글 기능
    @PostMapping("saveToMypage")
	@ResponseBody
	public Map<String, String> saveToMypage(@RequestParam("cl_idx") int cl_idx) {
		return service.toggleSaveToMypage(cl_idx);
	}

    // ===================================================================
    // Helper Methods
    // ===================================================================
    
    private Map<String, Object> buildCoverletterMap(int memberIdx, String title, String companyName, String aiResult, String clType) {
        Map<String, Object> map = new HashMap<>();
        map.put("member_idx", memberIdx);
        map.put("title", title);
        map.put("company_name", companyName);
        map.put("aiResult", aiResult);
        map.put("generated_char_count", aiResult.length());
        map.put("generated_char_count_no_space", aiResult.replaceAll("\\s", "").length());
        map.put("cl_type", clType);
        return map;
    }
    
    private void updateSessionToken(HttpSession session, Integer newTokenCount) {
        if (newTokenCount != null) {
            MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
            if (loginUser != null) {
                loginUser.setToken(newTokenCount);
                session.setAttribute("loginUser", loginUser);
            }
        }
    }

    
	
}

package com.itwillbs.illusion.validator;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.illusion.exception.ValidationException;
import com.itwillbs.illusion.service.JobToolsService;
import com.itwillbs.illusion.util.JobToolsConstants;
import com.itwillbs.illusion.util.SecurityUtil;

/**
 * 자소서 관련 입력값 검증을 담당하는 Validator
 */
@Component
public class CoverletterValidator {
    
    @Autowired
    private JobToolsService jobToolsService;
    
    // 허용되는 파일 확장자
    private static final List<String> ALLOWED_EXTENSIONS = Arrays.asList("txt", "doc", "docx", "pdf");
    
    // 최대 파일 크기 (10MB)
    private static final long MAX_FILE_SIZE = 10 * 1024 * 1024;
    
    /**
     * 자소서 생성 요청 검증
     */
    public void validateGenerationRequest(Map<String, String> params) {
        validateRequired(params.get("title"), "제목");
        validateRequired(params.get("company"), "회사명");
        validateRequired(params.get("occupation"), "직무");
        
        // 'experience_period'는 경력 선택 시에만 값이 존재함
        // 따라서 이 값이 있을 때만 'experience' (경력 상세 내용) 필드를 검증
//        if (StringUtils.hasText(params.get("experience_period"))) {
//            validateRequired(params.get("experience"), "경력 상세 내용");
//        }
        
        validateLength(params.get("title"), "제목", 1, 100);
        validateLength(params.get("company"), "회사명", 1, 50);
        
        // 최대 글자 수 검증
        String maxLength = params.get("maxLength");
        if (StringUtils.hasText(maxLength)) {
            try {
                int length = Integer.parseInt(maxLength);
                if (length < 100 || length > 5000) {
                    throw new ValidationException("글자 수는 100자 이상 5000자 이하여야 합니다.");
                }
            } catch (NumberFormatException e) {
                throw new ValidationException("글자 수는 숫자여야 합니다.");
            }
        }
    }
    
    /**
     * 자소서 첨삭 요청 검증 (텍스트 입력)
     */
    public void validateRefinementTextRequest(String coverletterText, String title, String companyName) {
        validateRequired(coverletterText, "첨삭할 자소서 내용");
        validateRequired(title, "제목");
        validateRequired(companyName, "회사명");
        
        validateLength(title, "제목", 1, 100);
        validateLength(companyName, "회사명", 1, 50);
        validateLength(coverletterText, "자소서 내용", 50, 10000);
    }
    
    /**
     * 파일 업로드 검증
     */
    public void validateFileUpload(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new ValidationException("파일이 선택되지 않았습니다.");
        }
        
        // 파일 크기 검증
        if (file.getSize() > MAX_FILE_SIZE) {
            throw new ValidationException("파일 크기는 10MB를 초과할 수 없습니다.");
        }
        
        // 파일 확장자 검증
        String originalFilename = file.getOriginalFilename();
        if (!StringUtils.hasText(originalFilename)) {
            throw new ValidationException("파일명이 유효하지 않습니다.");
        }
        
        String extension = getFileExtension(originalFilename).toLowerCase();
        if (!ALLOWED_EXTENSIONS.contains(extension)) {
            throw new ValidationException("지원하지 않는 파일 형식입니다. (허용: txt, doc, docx, pdf)");
        }
    }
    
    /**
     * 저장된 자소서 첨삭 권한 검증
     */
    public void validateRefinementPermission(Map<String, Object> coverletter) {
        if (coverletter == null) {
            throw new ValidationException("존재하지 않는 자소서입니다.");
        }
        
        String clType = (String) coverletter.get("cl_type");
        if (JobToolsConstants.CL_TYPE_REFINED.equals(clType)) {
            throw new ValidationException(JobToolsConstants.ERROR_ALREADY_REFINED);
        }
        
        int writerIdx = (Integer) coverletter.get("member_idx");
        int currentMemberIdx = SecurityUtil.getLoginUserIndex();
        
        if (writerIdx != currentMemberIdx) {
            throw new ValidationException(JobToolsConstants.ERROR_ACCESS_DENIED);
        }
        
        String content = (String) coverletter.get("generated_cl_content");
        if (!StringUtils.hasText(content)) {
            throw new ValidationException("자소서 내용이 비어있어 첨삭할 수 없습니다.");
        }
    }
    
    /**
     * 토큰 보유량 검증
     */
    public void validateTokenBalance(int memberIdx, int requiredTokens) {
        Integer currentTokens = jobToolsService.getMemberToken(memberIdx);
        if (currentTokens == null || currentTokens < requiredTokens) {
            throw new ValidationException(String.format("토큰이 부족합니다. (필요: %d, 보유: %d)", 
                requiredTokens, currentTokens != null ? currentTokens : 0));
        }
    }
    
    /**
     * 로그인 상태 검증
     */
    public void validateLoginStatus() {
        int memberIdx = SecurityUtil.getLoginUserIndex();
        if (memberIdx == -1) {
            throw new ValidationException(JobToolsConstants.ERROR_LOGIN_REQUIRED);
        }
    }
    
    // ===================================================================
    // Private Helper Methods
    // ===================================================================
    
    /**
     * 필수 입력 검증
     */
    private void validateRequired(String value, String fieldName) {
        if (!StringUtils.hasText(value)) {
            throw new ValidationException(fieldName + "은(는) 필수입니다.");
        }
    }
    
    /**
     * 길이 검증
     */
    private void validateLength(String value, String fieldName, int min, int max) {
        if (!StringUtils.hasText(value)) {
            return; // 필수 검증은 별도로 처리
        }
        
        int length = value.trim().length();
        if (length < min || length > max) {
            throw new ValidationException(String.format("%s은(는) %d자 이상 %d자 이하여야 합니다.", 
                fieldName, min, max));
        }
    }
    
    /**
     * 파일 확장자 추출
     */
    private String getFileExtension(String filename) {
        int lastDotIndex = filename.lastIndexOf('.');
        if (lastDotIndex == -1 || lastDotIndex == filename.length() - 1) {
            return "";
        }
        return filename.substring(lastDotIndex + 1);
    }
}
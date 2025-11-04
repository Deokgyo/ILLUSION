package com.itwillbs.illusion.vo;

import lombok.Data;
import com.itwillbs.illusion.util.JobToolsConstants;

// 자소서 관련 API 응답을 위한 DTO
 
@Data
public class CoverletterResponse {
    private boolean success;
    private String message;
    private String redirectUrl;
    private Integer newToken;
    
    // 기본 생성자
    public CoverletterResponse() {}
    
    // 전체 생성자
    public CoverletterResponse(boolean success, String message, String redirectUrl, Integer newToken) {
        this.success = success;
        this.message = message;
        this.redirectUrl = redirectUrl;
        this.newToken = newToken;
    }
    
    // 성공 응답 팩토리 메소드
    public static CoverletterResponse success(int clIdx, int originalClIdx, Integer newToken) {
        String redirectUrl = String.format(JobToolsConstants.COVERLETTER_RESULT_URL_FORMAT, clIdx, originalClIdx);
        return new CoverletterResponse(true, "성공", redirectUrl, newToken);
    }
    
    public static CoverletterResponse success(String redirectUrl, Integer newToken) {
        return new CoverletterResponse(true, "성공", redirectUrl, newToken);
    }
    
    // 실패 응답 팩토리 메소드
    public static CoverletterResponse failure(String message) {
        return new CoverletterResponse(false, message, null, null);
    }
}
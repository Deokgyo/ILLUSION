package com.itwillbs.illusion.handler;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.illusion.exception.ValidationException;
import com.itwillbs.illusion.vo.CoverletterResponse;

/**
 * 자소서 관련 예외 처리 핸들러
 * 자소서 관련 컨트롤러에서만 적용
 */
@ControllerAdvice(assignableTypes = {
    com.itwillbs.illusion.controller.jobTools.CoverletterController.class
})
public class GlobalExceptionHandler {
    
    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    /**
     * ValidationException 처리
     * 자소서 관련 검증 실패 시 호출
     */
    @ExceptionHandler(ValidationException.class)
    @ResponseBody
    public CoverletterResponse handleValidationException(ValidationException e) {
        logger.warn("Validation failed: {}", e.getMessage());
        return CoverletterResponse.failure(e.getMessage());
    }
    
    /**
     * 일반 RuntimeException 처리
     * 예상치 못한 서버 에러 시 호출
     */
    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public CoverletterResponse handleRuntimeException(RuntimeException e) {
        logger.error("Unexpected error occurred", e);
        return CoverletterResponse.failure("서버에서 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    }
    
    /**
     * IOException 처리
     * 파일 처리 등 IO 작업 중 예외 발생 시 호출
     */
    @ExceptionHandler(IOException.class)
    @ResponseBody
    public CoverletterResponse handleIOException(IOException e) {
        logger.error("IO error occurred", e);
        return CoverletterResponse.failure("파일 처리 중 오류가 발생했습니다. 다시 시도해주세요.");
    }
}
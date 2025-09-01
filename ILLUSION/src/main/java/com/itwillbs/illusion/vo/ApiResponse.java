package com.itwillbs.illusion.vo;

import lombok.Data;

/**
 * API 응답 표준화를 위한 Response 클래스
 */
@Data
public class ApiResponse<T> {
    private boolean success;
    private String message;
    private T data;
    
    // 기본 생성자
    public ApiResponse() {}
    
    // 전체 생성자
    public ApiResponse(boolean success, String message, T data) {
        this.success = success;
        this.message = message;
        this.data = data;
    }
    
    // 성공 응답 팩토리 메소드
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>(true, "성공", data);
    }
    
    public static <T> ApiResponse<T> success(String message, T data) {
        return new ApiResponse<>(true, message, data);
    }
    
    // 실패 응답 팩토리 메소드
    public static <T> ApiResponse<T> failure(String message) {
        return new ApiResponse<>(false, message, null);
    }
    
    public static <T> ApiResponse<T> failure(String message, T data) {
        return new ApiResponse<>(false, message, data);
    }
}
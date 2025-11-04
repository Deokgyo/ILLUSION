package com.itwillbs.illusion.util;

public class JobToolsConstants {

    // 토큰 수
    public static final int COVER_LETTER_GENERATION_COST = 30;
    public static final int COVER_LETTER_REFINEMENT_COST = 30;
    public static final int COVER_LETTER_INTERVIEW_COST = 30;
    public static final int CHATBOT_QUERY_COST = 5;

    // 자소서 타입
    public static final String CL_TYPE_GENERATED = "CL001";
    public static final String CL_TYPE_REFINED = "CL002";
    public static final String CL_TYPE_ORIGINAL_FOR_REFINEMENT = "CL003";

    // 자소서 제목 TODO 
    public static final String TITLE_ORIGINAL_FOR_REFINEMENT = "원본 자기소개서 (첨삭용)";
    public static final String TITLE_ORIGINAL_FOR_INTERVIEW = "원본 자기소개서 (예상질문생성용)";
    public static final String TITLE_REFINED = "첨삭된 자기소개서";
    public static final String TITLE_REFINED_SUFFIX = " (첨삭본)";

    // 저장 상태 (Common Code)
    public static final String SAVE_STATUS_NOT_SAVED = "BOL001";  // 저장 안함
    public static final String SAVE_STATUS_SAVED = "BOL002";      // 저장함

    // URL 패턴
    public static final String COVERLETTER_RESULT_URL_FORMAT = "coverletterResult?cl_idx=%d&original_cl_idx=%d";

    // AI 응답 상태
    public static final String AI_SERVICE_UNAVAILABLE = "SERVICE_UNAVAILABLE";
    public static final String AI_SAFETY_BLOCK = "SAFETY";
    public static final String AI_FAILURE = "실패.";

    // 에러 메시지
    public static final String ERROR_TOKEN_INSUFFICIENT = "토큰이 부족하여 작업을 완료할 수 없습니다.";
    public static final String ERROR_CHATBOT_TOKEN_INSUFFICIENT = "토큰이 부족하여 챗봇을 이용할 수 없습니다.";
    public static final String ERROR_LOGIN_REQUIRED = "로그인이 필요합니다.";
    public static final String ERROR_COVERLETTER_SAVE_FAILED = "자소서 저장 후 PK를 가져오는 데 실패했습니다.";
    public static final String ERROR_AI_SERVICE_OVERLOAD = "AI 서비스가 현재 과부하 상태입니다. 잠시 후 다시 시도해주세요.";
    public static final String ERROR_AI_SAFETY_BLOCK = "AI가 안전상의 이유로 응답을 거부했습니다. 다른 내용으로 시도해주세요.";
    public static final String ERROR_AI_SERVICE_FAILED = "AI 서비스 호출에 실패했습니다.";
    public static final String ERROR_ALREADY_REFINED = "이미 첨삭된 자소서는 다시 다듬을 수 없습니다.";
    public static final String ERROR_ACCESS_DENIED = "자신이 작성한 자소서만 다듬을 수 있습니다.";

}

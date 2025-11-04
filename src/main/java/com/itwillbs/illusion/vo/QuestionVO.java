package com.itwillbs.illusion.vo;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class QuestionVO {
    // Question 테이블 필드
    private int question_idx;
    private int cl_idx;
    private String question_text;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime question_create_at;

    // Answer 테이블 필드
    private int answer_idx;
    private int member_idx;
    private String answer_text;
    private String ai_feedback;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime answer_create_at;

}

package com.itwillbs.illusion.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ApplyVO {
	private int apply_idx;
	private int member_idx;
	private int recruit_idx;
	private int resume_idx;
	private int cl_idx;
	private MultipartFile apply_file;
	private String apply_files_path;
	private LocalDateTime apply_date; // 지원 일시
	private String apply_status; // 지원 상태
	private String is_viewed; // 기업 열람 여부
	private String resume_title;
	private String cl_title;
	private String recruit_subject; // 공고 주제
	private String rec_status; // 공고 상태
	
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime end_date; // 채용 마감일
	
    public String getApplyDateFormatted() {
        if (apply_date == null) return "";
        return apply_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
	
    public String getEndDateFormatted() {
        if (end_date == null) return "";
        return end_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
	
}

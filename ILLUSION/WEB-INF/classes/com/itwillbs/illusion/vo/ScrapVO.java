package com.itwillbs.illusion.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ScrapVO {
	
	private int scrap_idx;
	private int member_idx;
	private int recruit_idx; // 공고 idx
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime start_date; // 채용 시작일 
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime end_date; // 채용 마감일
	private String recruit_subject; // 공고 주제
	private String rec_status; // 공고 상태
	
    private int startRow = 0;
    private int listLimit = 10;
    
//  ----------------------------------
//    	채용 시작일, 마감일 날짜 관련 포맷팅  
    public String getStartDateFormatted() {
        if (start_date == null) return "";
        return start_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
    
    public String getEndDateFormatted() {
        if (end_date == null) return "";
        return end_date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
    
}



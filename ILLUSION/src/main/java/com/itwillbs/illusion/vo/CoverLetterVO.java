package com.itwillbs.illusion.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CoverLetterVO {
	private int cl_idx;
	private int member_idx;
	private String cl_title;
	private String company_name;
	private String generated_cl_content;
	private int generated_char_count;
	private int generated_char_count_no_space;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate generation_date;
	private String is_saved_to_mypage;
	private String cl_type;
}

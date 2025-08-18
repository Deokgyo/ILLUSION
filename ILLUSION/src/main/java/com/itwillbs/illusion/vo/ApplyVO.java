package com.itwillbs.illusion.vo;

import java.time.LocalDateTime;

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
	private String apply_files_path;
	private LocalDateTime apply_date;
	private String apply_status;
	private String is_viewed;
	private String resume_title;
	private String cl_title;
}

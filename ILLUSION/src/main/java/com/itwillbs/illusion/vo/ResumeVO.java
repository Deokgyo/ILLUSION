package com.itwillbs.illusion.vo;


import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ResumeVO {
	private int resume_idx;
	private int member_idx;
	private String resume_title;
	private LocalTime resume_create_at;
	private String resume_img;
	private String school_name;
	private String major;
	private double grade;
	private String degree;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate enroll_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate graduation_date;
		
}

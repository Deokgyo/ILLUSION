package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecruitVO {
	private int recruit_idx;
	private int recruiter_member_idx;
	private String occupation;
	private String location;
	private String experience;
	private String salary;
	private String degree;
	private LocalDate start_date;
	private LocalDate end_date;
	private int views_count;
	private int app_count;
	private String recruit_context;
	private String recruit_subject;
	private String recruit_type;
	private int recruit_hiring_num;
	private LocalTime start_time;
	private LocalTime end_time;
	private String recruiter_member_pnum;
	private LocalDateTime post_create_at;
	private String company_name;
}

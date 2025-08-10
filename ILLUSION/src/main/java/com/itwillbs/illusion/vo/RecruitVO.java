package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
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
    private String province;
	private String city_district;
	private String road_address;
	private String detail_address;
	private String full_address;
	private String ceo_name;
	private String company_type;
	private LocalDate company_estab_date;
	private String recruiter_member_email;
	
}

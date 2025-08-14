package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecruitVO {
	private int recruit_idx; // 공고 idx
	private int recruiter_member_idx; // 멤버 idx
	private String occupation;	// 세부 직무 
	private String location; // 근무 지역
	private String experience; // 경력 요건 
	private String salary; // 연봉 
	private String degree; // 학력 
	private String position; // 직급 
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate start_date; // 채용 시작일 
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
	private LocalDate end_date; // 채용 마감일
	private int views_count; // 조회수 
	private int app_count; // 지원수 
	private String recruit_context; // 공고 내용 
	private String recruit_subject; // 공고 주제 
	private String recruit_type;  	// 채용 유형 
	private int recruit_hiring_num; // 채용 인원 
	private String work_start_day; // 근무 시작 요일
	private String work_end_day;   // 근무 종료 요일 
	private LocalTime start_time;  // 근무 시작 시간
	private LocalTime end_time;    // 근무 종료 시간 
	private String recruiter_member_pnum; // 회사 담당자 번호 
	private LocalDateTime post_create_at; // 공고 등록 시간 
	private String company_name; // 회사 이름 
    private String province;
	private String city_district;
	private String road_address;
	private String detail_address;
	private String full_address;
	private String ceo_name; // 대표 이름 
	private String company_type; // 
	private LocalDate company_estab_date;
//	private String recruiter_member_email; // 회워 담당자 이메일, 안써도 될거 같음 
	private MultipartFile file;
	private String recruit_file;
	private String preferred;	// 우대 사항
	private String apply_doc;	// 제출 서류 
	private String apply_method; // 지원 방법
}

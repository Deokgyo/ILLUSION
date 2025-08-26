package com.itwillbs.illusion.vo;


import java.time.LocalDate;
import java.time.LocalTime;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ResumeVO {
	private int resume_idx; // 이력서 인덱스
	private int member_idx; // 멤버 인덱스
	private String member_name; // 회원 이름
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate resume_birth; // 회원 생일
	private String resume_title; // 이력서 제목
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate resume_create_at; // 이력서 생성일
	private String resume_img; // 프로필 사진
	private String school_name; // 학교명
	private String major; // 전공
	private double grade; // 학점
	private String degree; // 최종학력
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate enroll_date; // 입학일
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate graduation_date; // 졸업일
	private String member_phone; // 회원 전화번호
	private String member_email; // 회원 이메일
	private String address_name; // 주소
	private int address_num; // 주소번호
	private String company_name; // 회사 이름
	private String position; // 직위
	private String experience; // 경력
	private String occupation; // 직종
	
	
		
}

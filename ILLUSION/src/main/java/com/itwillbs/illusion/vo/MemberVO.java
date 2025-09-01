package com.itwillbs.illusion.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MemberVO {
	private int member_idx;
	private String member_name;
	private String member_id;
	private String member_pw;
	private String member_email;
	private String member_phone;
	private int address_num;
	private String address_name;
	private String member_type;
	private Date member_signup_date;
	private String member_status;
	private String email_verified;
	private String member_marketing_agreed;
	private String profile_picture_url;
	private String gender;
	private Date resume_birth;
	private int token;
	private String recruiter_number;
	private String recruiter_member_email;
	private int company_idx;
	private String mail_auth_status;
	private String company_name;
}

package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class CompanyVo {
	 private int company_idx;
	 private String company_name;
	 private String ceo_name; 
	 private String company_type;
	 private String company_industry; 
	 private String company_estab_date;
	 private int address_idx; 
	 private String company_logo;
	 private String company_link;
	 private String company_desc;

}

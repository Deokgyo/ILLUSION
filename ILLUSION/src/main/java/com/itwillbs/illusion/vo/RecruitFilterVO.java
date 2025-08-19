package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecruitFilterVO {
	
    private String sort = "latest"; // 정렬 기본값
    private List<String> location;
    private List<String> occupation;
    private List<String> experience;
    private List<String> salary;
    private List<String> degree;

}

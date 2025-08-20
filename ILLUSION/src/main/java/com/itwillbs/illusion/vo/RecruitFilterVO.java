package com.itwillbs.illusion.vo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecruitFilterVO {
	
    private String sort = "latest"; // 정렬 기본값
    private List<String> location = new ArrayList<>();
    private List<String> occupation = new ArrayList<>();
    private List<String> salary = new ArrayList<>();
    private List<String> experience = new ArrayList<>();
    private List<String> degree = new ArrayList<>();
    
    private int startRow = 0;
    private int listLimit = 10;
    
}

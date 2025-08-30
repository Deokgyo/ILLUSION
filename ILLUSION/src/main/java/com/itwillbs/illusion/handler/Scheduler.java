package com.itwillbs.illusion.handler;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itwillbs.illusion.service.RecruiterService;

@Component
public class Scheduler {
	
	@Autowired
	RecruiterService recruiterService;
	
	@Scheduled(cron = "0 0 0 * * ?")
	public void expiredRecruiteClose() {
		recruiterService.expiredRecruiteClose();
	}
	
	// 게시글에 없지만,서버에 저장된 파일 삭제 하려면 .. 
	// 서버에 저장된 파일명을 다들고오고, 디비에 파일 명도 다 들고와서 일일이 다 비교 작업...???? 
	
	
}

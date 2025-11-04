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
	
	
	
}

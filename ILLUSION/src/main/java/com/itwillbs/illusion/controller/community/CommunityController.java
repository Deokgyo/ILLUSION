package com.itwillbs.illusion.controller.community;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CommunityController {
	
	@GetMapping("communityMain")
	public String communityMain() {
		return "community/communityMain";
	}
	@GetMapping("communityWrite")
	public String communityWrite() {
		return "community/communityWrite";
	}
	@GetMapping("communityDetail")
	public String communityDetail() {
		return "community/communityDetail";
	}
}

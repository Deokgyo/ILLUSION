package com.itwillbs.illusion.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("adminMain")
	public String adminMain() {
		return "admin/adminMain";
	}
	
}

package com.itwillbs.illusion.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

	@GetMapping("adminMain")
	public String adminMain() {
		return "admin/adminMain";
	}
	
	@GetMapping("adminMember")
	public String adminMember() {
		return "admin/adminMember";
	}
	
	@GetMapping("adminRecuritment")
	public String adminRecuritment() {
		return "admin/adminRecuritment";
	}
	
	@GetMapping("adminCommunity")
	public String adminCommunity() {
		return "admin/adminCommunity";
	}
	
	@GetMapping("adminSupport")
	public String adminSupport() {
		return "admin/adminSupport";
	}
	
	@GetMapping("adminPayment")
	public String adminPayment() {
		return "admin/adminPayment";
	}
	
	@GetMapping("comcodeRegist")
	public String comcodeRegist() {
		return "admin/comcodeRegist";
	}
	
}

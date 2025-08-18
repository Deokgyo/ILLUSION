package com.itwillbs.illusion.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class Test {
	
	@PostMapping("pwFind") 
	public String pwFind () {
		return "myPage/changePasswd";
	}
}

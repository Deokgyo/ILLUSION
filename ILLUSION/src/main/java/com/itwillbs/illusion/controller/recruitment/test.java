package com.itwillbs.illusion.controller.recruitment;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class test {

	@GetMapping("test")
	public String test() {
		return "recuritment/test";
	}
	

}

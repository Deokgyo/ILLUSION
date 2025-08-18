package com.itwillbs.illusion.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itwillbs.illusion.vo.MemberVO;

// 

@Controller
public class HomeController {

   private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

   @RequestMapping(value = "/", method = RequestMethod.GET)
   public String home() {
      return "home";
   }

   @GetMapping("errorPage")
   public String errorPage() {
      return "errorPage";
   }

   // 로그인 이동
   @GetMapping("login")
   public String login() {
      return "home/login";
   }

   // 로그인 이동
   @GetMapping("idPwFind")
   public String idPwFind() {
      return "home/idPwFind";
   }

   // 회원가입 이동
   @GetMapping("register")
   public String register() {
      return "home/register";
   }

   // 회원가입 이동
   @PostMapping("registersu")
   public String registersu(MemberVO membervo) {
      // UserVO의 필드명 == form의 name 속성과 일치하면 자동 매핑됨
      System.out.println("회원가입 요청: " + membervo);

      // TODO: 여기에서 DB 저장 로직 작성
      // 예: userService.register(user);

      // 회원가입 완료 후 이동할 페이지 (예: 로그인 페이지)
      return "home/login";
      // ViewResolver가 /WEB-INF/views/home/login.jsp 로 찾아감 (prefix, suffix 설정에 따라 다름)
   }

}

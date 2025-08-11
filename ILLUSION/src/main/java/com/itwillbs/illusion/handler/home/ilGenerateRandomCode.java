package com.itwillbs.illusion.handler.home;

import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.RandomStringUtils;

public class ilGenerateRandomCode {

	public static String getRandomCode(int length) {
		
		// [ 난수 생성 방법 ]
		// 1. java.util.Random 클래스 활용
		//   (또는 java.lang.Math 클래스의 random() 메서드)
//		Random r = new Random();
//		int rNum = r.nextInt(10000); // 0 ~ 9999	
//		return String.valueOf(rNum);
		
		// 파라미터로 전달받은 length 값을 자릿수로 활용
//		(int)Math.pow(10, 4); -> 10000
		
//		int rNum = r.nextInt((int)Math.pow(10, length));
//		return String.valueOf(rNum);
		
		// 2. 난수 생성에 관한 다양한 기능을 제공하는 외부 라이브러리 활용
		// => Apache 의 commons-lang3 라이브러리 추가하여 RandomXXX 클래스 활용
		return RandomStringUtils.randomAlphanumeric(length);
	}
	
}

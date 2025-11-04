package com.itwillbs.illusion.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class GeminiService {

 @Value("${gemini.api.key}")
 private String apiKey;
 

 @Value("${gemini.api.url}")
 private String apiUrl;
 
 
 public GeminiService() {
//     System.out.println("GeminiService 객체가 생성되었습니다.");
 }

 public String callGeminiApi(String prompt)  {

	    RestTemplate restTemplate = new RestTemplate();
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);

	    // Gemini API 요청 JSON 구조 (공식 문서 기준)
	    String requestBody = "";
	    try {
	        requestBody = String.format(
	            "{\"contents\":[{\"parts\":[{\"text\":%s}]}]}",
	            new ObjectMapper().writeValueAsString(prompt) // JSON escape
	        );
	    } catch (IOException e) {
	        e.printStackTrace();
	        return "실패."; // 요청 본문 만들기 실패
	    }

	    HttpEntity<String> entity = new HttpEntity<>(requestBody, headers);
	    String fullApiUrl = apiUrl + "?key=" + apiKey;

	    try {
	        ResponseEntity<String> response = restTemplate.postForEntity(fullApiUrl, entity, String.class);

	        System.out.println("### Raw Response: " + response.getBody()); // 응답 전체 확인

	        ObjectMapper mapper = new ObjectMapper();
	        JsonNode root = mapper.readTree(response.getBody());
	        String text = root.path("candidates").get(0)
	                          .path("content").path("parts").get(0)
	                          .path("text").asText();

	        return text;

	    } catch (Exception e) {
	        e.printStackTrace(); 
	        return "실패.";
	    }
	}
}
package com.itwillbs.illusion.handler.home;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class MailClient {

	@Autowired
	private MailAuth mailAuth;

	// 메일 발송에 사용될 설정 정보
	private final String HOST = "smtp.gmail.com"; 
	private final String PORT = "587"; 
	private final String SENDER_ADDRESS = "wldnjs010309@gmail.com";

	public void sendMail(String receiver, String subject, String content) {

		try {

			Properties props = System.getProperties();

			props.put("mail.smtp.host", HOST); 
			props.put("mail.smtp.port", PORT); 
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.ssl.protocols", "TLSv1.2");
			props.put("mail.smtp.ssl.trust", HOST); 

			Session mailSession = Session.getDefaultInstance(props, mailAuth);
	
			Message message = new MimeMessage(mailSession);
			
			Address senderAddr = new InternetAddress(SENDER_ADDRESS, "일루션");
			
			Address receiverAddr = new InternetAddress(receiver);
			
			message.setHeader("content-type", "text/html; charset=UTF-8");

			message.setFrom(senderAddr);

			message.setRecipient(RecipientType.TO, receiverAddr);

			message.setSubject(subject);

			message.setContent("<h3>" + content + "</h3>", "text/html; charset=UTF-8");

			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

package com.itwillbs.illusion.handler.home;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

import org.springframework.stereotype.Component;

@Component
public class MailAuth extends Authenticator {

	PasswordAuthentication passwordAuthentication;

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {

		passwordAuthentication = new PasswordAuthentication(
				"wldnjs010309@gmail.com", "xngkkyszqrgquybg");
		
		return passwordAuthentication;
		
	}
	
	
	
	
}

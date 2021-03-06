package com.an.auctionara.rest;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.CertDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.CertService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/async")
public class CertRestController {

	@Autowired
	private CertService certService;	
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private MemberDao memberDao;
			
	@PostMapping("/emailExists")
	public int emailExists(@RequestParam String certTarget) {
		return memberDao.checkEmail(certTarget);
		
	}
	
	@PostMapping("/asyncSend")
	public void sendCert(@RequestParam String certTarget) {
		certService.sendCert(certTarget);
	}
	
	@PostMapping("/asyncCheck")
	public boolean certifyCert(@ModelAttribute CertDto certDto) {
		return certDao.certifyCert(certDto);
	}
	
	@PostMapping("/nickExists")
	public boolean nickExists(@RequestParam String memberNick) {
		int result = memberDao.checkNick(memberNick);
		
		if(result==1) {
			return true;
		}
		else return false;
	}
	
	
	@PostMapping("/asyncPw")
	public boolean sendPw(@RequestParam String memberEmail
			) throws MessagingException {
			certService.sendPwResetMail(memberEmail);
			return true;
	}
	

}

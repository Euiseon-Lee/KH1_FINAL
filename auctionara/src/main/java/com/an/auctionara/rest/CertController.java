package com.an.auctionara.rest;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.CertDto;
import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.service.CertService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class CertController {

	@Autowired
	private CertService certService;	
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private MemberDao memberDao;
			
	@GetMapping("/emailExists")
	public boolean emailExists(@RequestParam String certTarget) {
		boolean memberNo = memberDao.checkMemberNo(certTarget);
		
		if (memberNo) {
			return true;
		}
		else {
			return false;
		}
	}
	
	@PostMapping("/asyncSend")
	public void sendCert(@RequestParam String certTarget) {
		certService.sendCert(certTarget);
	}
	
	@PostMapping("/asyncCheck")
	public boolean vertifyCert(@ModelAttribute CertDto certDto) {
		return certDao.certifyCert(certDto);
	}
	
	
//	@PostMapping("/asyncPw")
//	public String sendPw(@ModelAttribute MemberDto targetDto) throws MessagingException {
//		boolean isMember = memberDao.checkMemberNo(targetDto.getMemberEmail());
//		
//		if(!isMember) {
//			return "redirect:change_pw?fail";
//		}
//		
//		else {
//			certService.sendPwResetMail(targetDto);
//			return "change_pw?success";
//		}
//	}
	

}

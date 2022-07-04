package com.an.auctionara.rest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.CertDto;
import com.an.auctionara.repository.CertDao;
import com.an.auctionara.service.CertService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class CertController {

	@Autowired
	private CertService certService;	
	
	@Autowired
	CertDao certDao;
			
	
	
	@PostMapping("/asyncSend")
	public void sendCert(@RequestParam String certTarget) {
		certService.sendCert(certTarget);
	}
	
	@PostMapping("/asyncCheck")
	public boolean vertifyCert(@ModelAttribute CertDto certDto) {
		return certDao.certifyCert(certDto);
	}
	
}

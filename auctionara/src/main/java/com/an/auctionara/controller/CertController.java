package com.an.auctionara.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.an.auctionara.repository.CertDao;

@Controller
public class CertController {

	@Autowired
	CertDao certDao;
	
//	@GetMapping("/makeCert")
//	public String cert() {
//
//	}
	
}

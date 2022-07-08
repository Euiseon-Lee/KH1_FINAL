package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.an.auctionara.entity.AutologinDto;
import com.an.auctionara.repository.AutologinDao;
import com.an.auctionara.repository.TokenDao;

@Service
public class AutologinServiceImpl implements AutologinService {

	@Autowired
	private AutologinDao autologinDao;
	
	@Autowired
	private TokenDao tokenDao;
	
	
	@Override
	public void issueToken(int memberNo, String autoDeviceSerial) {
		
		//토큰 만들기
		String autoToken = tokenDao.makeToken();
		
		//DB에 토큰 저장
		autologinDao.insertToken(memberNo, autoToken, autoDeviceSerial);
		
	}

	
	

	
}

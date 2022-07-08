package com.an.auctionara.service;

import com.an.auctionara.entity.AutologinDto;

public interface AutologinService {
	
	void issueToken(int memberNo, String autoDeviceSerial);
	
	
}

package com.an.auctionara.repository;

import com.an.auctionara.entity.CertDto;

public interface CertDao {
	void makeCert(CertDto certDto);
	boolean certifyCert(CertDto certDto);
	void timeover();
}
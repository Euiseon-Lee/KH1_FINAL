package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.AuctionReportDto;
import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.repository.ManagerRestrictionDao;

@Service
public class AdminRestrictServiceImpl implements AdminRestrictService{

	@Autowired
	private ManagerRestrictionDao managerRestrictionDao;
	private AuctionReportDto auctionReportDto;
	private AuctionReportDao auctionReportDao; 
	
	@Override
	@Transactional
	public void restrictMember(ManagerRestrictionDto managerRestrictionDto, int auctionReportNo) {
		
		System.out.println(managerRestrictionDto.getMemberNo());
		System.out.println(auctionReportNo);
		
		// 관리자의 회원 제재 service 
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		// auction_report 테이블의 제재 여부 컬럼 update 
		auctionReportDto = auctionReportDao.setRestrict(auctionReportNo);
	}
}

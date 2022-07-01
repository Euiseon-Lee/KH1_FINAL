package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.AuctionReportDto;
import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.repository.ManagerRestrictionDao;
import com.an.auctionara.repository.MemberDao;

@Service
public class AdminRestrictServiceImpl implements AdminRestrictService{

	@Autowired
	private ManagerRestrictionDao managerRestrictionDao;
	
	@Autowired
	private AuctionReportDao auctionReportDao; 
	
	@Autowired
	private MemberDao memberDao; 
	
	@Override
	@Transactional
	public void restrictMember(ManagerRestrictionDto managerRestrictionDto, int auctionReportNo, int memberNo) {
		// 관리자의 회원 제재 service 
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		// auction_report 테이블의 제재 여부 컬럼 update 
		AuctionReportDto auctionReportDto = auctionReportDao.setRestrict(auctionReportNo);
		
		// member에 red_count column update
		memberDao.plusRedCount(memberNo);
	}
}


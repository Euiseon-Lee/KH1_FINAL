package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.entity.AuctionReportDto;
import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.repository.AuctionReportDao;
import com.an.auctionara.repository.ChatReportDao;
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
	
	@Autowired 
	private ChatReportDao chatReportDao; 
	
	@Override
	@Transactional
	public void restrictAuction(ManagerRestrictionDto managerRestrictionDto, int auctionReportNo, int memberNo) {
		// 관리자의 회원 제재 service 
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		// auction_report 테이블의 제재 여부 컬럼 update 
		AuctionReportDto auctionReportDto = auctionReportDao.setRestrict(auctionReportNo);
		
		// member에 red_count column update
		memberDao.plusRedCount(memberNo);
	}
	
	@Override
	public void restrictChat(ManagerRestrictionDto managerRestrictionDto, int chatReportNo, int memberNo) {
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		ChatReportDto chatReportDto = chatReportDao.setRestrict(chatReportNo);

		memberDao.plusRedCount(memberNo);
	}
}


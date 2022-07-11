package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.repository.MonthlyBidDao;
import com.an.auctionara.repository.SuccessfulBidDao;

@Service
public class MonthlyBidServiceImpl implements MonthlyBidService{

	@Autowired
	private SuccessfulBidDao successfulBidDao; 
	
	@Autowired
	private MonthlyBidDao monthlyBidDao; 
	
	@Scheduled(cron = "0 0 0 1 * *")
	@Transactional
	@Override
	public void insertMonthlyBid() {
		int totalBid = successfulBidDao.getMonthlyTotalBid();
		 
		monthlyBidDao.insertMonthlyTotalBid(totalBid);
	}
}

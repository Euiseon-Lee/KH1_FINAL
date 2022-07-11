package com.an.auctionara.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.repository.MonthlyChargedPointsDao;
import com.an.auctionara.repository.PaymentDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MonthlyChargedPointsServiceImpl implements MonthlyChargedPointsService{

	@Autowired
	private PaymentDao paymentDao;
	
	@Autowired
	private MonthlyChargedPointsDao monthlyChargedPointsDao; 
	
	@Scheduled(cron = "0 0 0 1 * *")
	@Transactional
	@Override
	public void insertMonthlyChargedPoints() {
		 int totalPoints = paymentDao.getMonthlyTotalChargedPoints();
		 
//		 System.out.println(totalPoints);
		 
		 monthlyChargedPointsDao.insertMonthlyChargedPoints(totalPoints);
		 
//		 log.debug("실행");
	}
}

package com.an.auctionara.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.an.auctionara.repository.MonthlyNetSalesDao;
import com.an.auctionara.repository.NetSalesDao;

@Service
public class MonthlyNetSalesServiceImpl implements MonthlyNetSalesService{

	@Autowired
	private NetSalesDao netSalesDao; 
	
	@Autowired
	private MonthlyNetSalesDao monthlyNetSalesDao; 
	
	@Scheduled(cron = "0 0 0 1 * *")
	@Transactional
	@Override
	public void insertMonthlyNetSalesService() {
		int totalNetSales = netSalesDao.getMonthlyTotalNetSales();
		 
		monthlyNetSalesDao.insertMonthlyTotalNetSales(totalNetSales);
	}
}

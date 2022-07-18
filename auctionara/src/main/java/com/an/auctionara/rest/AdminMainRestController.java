package com.an.auctionara.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.MemberDao;
import com.an.auctionara.repository.MonthlyBidDao;
import com.an.auctionara.repository.MonthlyChargedPointsDao;
import com.an.auctionara.repository.MonthlyNetSalesDao;
import com.an.auctionara.vo.MonthlyBidVO;
import com.an.auctionara.vo.MonthlyChargedPointsVO;
import com.an.auctionara.vo.MonthlyNetSalesVO;

@RestController
@RequestMapping("/rest/admin_main")
public class AdminMainRestController {

	@Autowired
	private MonthlyNetSalesDao monthlyNetSalesDao; 
	
	@Autowired
	private MemberDao memberDao; 
	
	@Autowired
	private AuctionDao auctionDao; 
	
	@Autowired
	private MonthlyChargedPointsDao monthlyChargedPointsDao; 
	
	@Autowired
	private MonthlyBidDao monthlyBidDao; 
	
	@GetMapping("/monthly_net_sales")
	public int netSales() {
		return monthlyNetSalesDao.netSales();
	}
	
	@GetMapping("/count_member")
	public int countMember() {
		return memberDao.countMember();
	}
	
	@GetMapping("/count_auction")
	public int countAuction() {
		return auctionDao.countAuction();
	}
	
	@GetMapping("/monthly_total_net_sales")
	public List<MonthlyNetSalesVO> monthlyTotalNetSales() {
		return monthlyNetSalesDao.monthlyNetSales();
	}
	
	@GetMapping("/monthly_total_points")
	public List<MonthlyChargedPointsVO> monthlyTotalPoints() {
		return monthlyChargedPointsDao.monthlyTotalPoints();
	}
	
	@GetMapping("/monthly_bid")
	public List<MonthlyBidVO> monthlyBid() {
		return monthlyBidDao.monthlyBid(); 
	}
}

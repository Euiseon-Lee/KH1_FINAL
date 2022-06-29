package com.an.auctionara.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.CashingPointsDto;
import com.an.auctionara.repository.CashingPointsDao;

@RestController
@RequestMapping("/rest/cashing_points")
public class CashingPointsRestController {

	@Autowired
	private CashingPointsDao cashingPointsDao;
	
	@GetMapping("/")
	public List<CashingPointsDto> requestList() {
		return cashingPointsDao.requestList();
	}
	
}

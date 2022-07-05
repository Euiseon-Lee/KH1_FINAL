package com.an.auctionara.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.an.auctionara.entity.GpsAddressDto;
import com.an.auctionara.repository.GpsAddressDao;

@Controller
@RequestMapping("/address")
public class GpsAddressController {
	
	@Autowired
	private GpsAddressDao gpsAddressDao;
	
	@GetMapping
	public String gps(HttpSession session, Model model) {
//		int memberNo = (int) session.getAttribute("whoLogin");
		List<GpsAddressDto> gpsAddressList =  gpsAddressDao.list(13); // 임시
		model.addAttribute("gpsAddressList", gpsAddressList);
		return "/address/gps";
	}
	
	@ResponseBody
	@PostMapping
	public void postAddress(@RequestBody GpsAddressDto gpsAddressDto) {
		gpsAddressDao.insert(gpsAddressDto);
	}
	
	@ResponseBody
	@PutMapping("/change1")
	public void putAddress1(@RequestBody GpsAddressDto gpsAddressDto) {
		gpsAddressDao.change1(gpsAddressDto);
	}
	
	@ResponseBody
	@PutMapping("/change2")
	public void putAddress2(@RequestBody GpsAddressDto gpsAddressDto) {
		gpsAddressDao.change2(gpsAddressDto);
	}	
}

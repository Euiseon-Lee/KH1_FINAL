package com.an.auctionara.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/sales")
public class AdminSalesController {

	@GetMapping("/chart")
	public String sales() {
		return "admin/sales/chart";
	}
}

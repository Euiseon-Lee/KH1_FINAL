package com.an.auctionara.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.repository.ManagerRestrictionDao;
import com.fasterxml.jackson.databind.annotation.JsonAppend.Attr;

@Controller
@RequestMapping("/admin/restriction")
public class AdminRestrictController {

	@Autowired
	private ManagerRestrictionDao managerRestrictionDao; 
	
	@GetMapping("/restrict_member/{memberNo}")
	public String restrictMember(@PathVariable int memberNo, Model model) {
		model.addAttribute("memberNo", memberNo);
		
		return "admin/restriction/restrict_member";
	}
	
	@PostMapping("/restrict_member/{memberNo}")
	public String restrictMember(@ModelAttribute ManagerRestrictionDto managerRestrictionDto) {
		managerRestrictionDao.restrictMember(managerRestrictionDto);
		
		return "redirect: /auctionara/admin/restriction/list";
	}
}

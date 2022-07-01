package com.an.auctionara.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.an.auctionara.entity.AuctionDto;
import com.an.auctionara.entity.CategoryDto;
import com.an.auctionara.entity.PhotoDto;
import com.an.auctionara.repository.AttachmentDao;
import com.an.auctionara.repository.AuctionDao;
import com.an.auctionara.repository.CategoryDao;
import com.an.auctionara.repository.PhotoDao;
import com.an.auctionara.vo.WriteAuctionVO;

@Controller
@RequestMapping("/auction")
public class AuctionController {
	
	@Autowired
	CategoryDao categoryDao;
	
	@Autowired
	AuctionDao auctionDao;
	
	@Autowired
	PhotoDao photoDao;
	
	@Autowired
	private AttachmentDao attachmentDao;

	@GetMapping("/write")
	public String write(Model model) {
		List<CategoryDto> categoryList = categoryDao.list();
		model.addAttribute("categoryList", categoryList);		
		return "/auction/write";
	}
	
	@GetMapping("/search")
	public String search() {
		
		return "/auction/search";
	}
	
	@GetMapping("/type/{categoryNo}")
	public String type(@PathVariable int categoryNo) {
		
		return "/auction/type";
	}

	@GetMapping("/detail")
	public String detail(
			@RequestParam int auctionNo) {
		return "/auction/detail";
	}
	
	
	@GetMapping("/detail/{auctionNo}")
	public String detail2(@PathVariable int auctionNo) {
		return "/auction/detail";
	}

	@PostMapping("/write")
	public void write2(@ModelAttribute WriteAuctionVO writeAuctionVO, HttpSession session) throws IllegalStateException, IOException {	
//		int memberNo = (int) session.getAttribute("whoLogin");
		writeAuctionVO.setAuctionClosedTime(writeAuctionVO.getAuctionClosedTime().replace("T", " "));
	
		AuctionDto auctionDto = AuctionDto.builder()
									.auctioneerNo(13) // 임시
									.categoryNo(writeAuctionVO.getCategoryNo())
									.auctionTitle(writeAuctionVO.getAuctionTitle())
									.auctionContent(writeAuctionVO.getAuctionContent())
									.auctionClosedTime(writeAuctionVO.getAuctionClosedTime())
									.auctionOpeningBid(writeAuctionVO.getAuctionOpeningBid())
									.auctionClosingBid(writeAuctionVO.getAuctionClosingBid())
									.auctionBidUnit(writeAuctionVO.getAuctionBidUnit())
									.auctionStatus(writeAuctionVO.getAuctionStatus())
									.build();

		int auctionNo = auctionDao.write(auctionDto);
		
		for(int i = 0; i < writeAuctionVO.getAttachment().size(); i++) {
			int attachmentNo = attachmentDao.save(writeAuctionVO.getAttachment().get(i));
			
			PhotoDto photoDto = PhotoDto.builder() 
					.photoAuctionNo(auctionNo)
					.photoAttachmentNo(attachmentNo)
					.build();
			photoDao.insert(photoDto);
		}	

	}
	
	@PostMapping("/submit")
	public String submit(HttpSession session, RedirectAttributes attr) {
//		int memberNo = (int) session.getAttribute("whoLogin");
		attr.addAttribute("auctionNo", auctionDao.recent(13)); // 임시	
		return "redirect:/auction/detail";
	}
}

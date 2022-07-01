package com.an.auctionara.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.an.auctionara.entity.RatingDto;
import com.an.auctionara.repository.RatingDao;

import oracle.jdbc.proxy.annotation.Post;

@RestController
@RequestMapping("/rest/rating")
public class RatingRestController {
	
	@Autowired
	private RatingDao ratingDao;
	
	// 등록 
	@PostMapping("/")
	public RatingDto insert(@RequestBody RatingDto ratingDto) {
		return ratingDao.insert(ratingDto);
	}
	
	// 수정 
	@PutMapping("/")
	public RatingDto update(@RequestBody RatingDto ratingDto) {
		return ratingDao.update(ratingDto);
	}
	
	// 삭제
	@DeleteMapping("/{ratingItemNo}")
	public void delete(@PathVariable int ratingItemNo) {
		ratingDao.delete(ratingItemNo);
	}
	
	// 목록 
	@GetMapping("/")
	public List<RatingDto> list() {
		return ratingDao.list();
	}
}

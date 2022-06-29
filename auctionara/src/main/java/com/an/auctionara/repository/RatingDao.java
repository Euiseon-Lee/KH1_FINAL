package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.RatingDto;

public interface RatingDao {

	// 등록 
	RatingDto insert(RatingDto ratingDto);

	// 수정 
	RatingDto update(RatingDto ratingDto);

	// 삭제 
	void delete(int ratingItemNo);

	// 목록 
	List<RatingDto> list();

}

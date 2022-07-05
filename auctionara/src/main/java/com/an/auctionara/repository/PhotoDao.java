package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.PhotoDto;

public interface PhotoDao {
	void insert(PhotoDto photoDto);
	List<PhotoDto> list(int photoAuctionNo);
}

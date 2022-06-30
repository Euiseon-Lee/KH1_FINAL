package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.CategoryDto;

public interface CategoryDao {
	List<CategoryDto> list();
}

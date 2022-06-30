package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.CategoryDto;

@Repository
public class CategoryDaoImpl implements CategoryDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<CategoryDto> list() {
		List<CategoryDto> list = sqlSession.selectList("category.list");
		return list;
	}	
}

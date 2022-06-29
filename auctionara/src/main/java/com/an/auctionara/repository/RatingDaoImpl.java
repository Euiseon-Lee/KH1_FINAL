package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.RatingDto;

@Repository
public class RatingDaoImpl implements RatingDao{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public RatingDto insert(RatingDto ratingDto) {
		// 등록 메소드 
		int ratingItemNo = sqlSession.selectOne("rating.sequence");
		ratingDto.setRatingItemNo(ratingItemNo);
		sqlSession.insert("rating.insert", ratingDto);
		
		return ratingDto; 
	}
	
	@Override
	public RatingDto update(RatingDto ratingDto) {
		// 수정 메소드 
		int count = sqlSession.update("rating.update", ratingDto);
//		if(count == 0) throw new CannotFindException();
		
		return sqlSession.selectOne("rating.one", ratingDto.getRatingItemNo());
	}
	
	@Override
	public void delete(int ratingItemNo) {
		// 삭제 메소드 
		sqlSession.delete("rating.delete", ratingItemNo);
	}
	
	@Override
	public List<RatingDto> list() {
		// 목록 메소드 
		return sqlSession.selectList("rating.list");
	}
}

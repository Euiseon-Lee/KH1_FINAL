package com.an.auctionara.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.MemberRatingDto;

@Repository
public class MemberRatingDaoImpl implements MemberRatingDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void save(MemberRatingDto memberRatingDto) {
		int ratingNo = sqlSession.selectOne("member_rating.sequence");
		memberRatingDto.setRatingNo(ratingNo);
		sqlSession.insert("member_rating.insert", memberRatingDto);
	}
}

package com.an.auctionara.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.an.auctionara.entity.PhotoDto;

@Repository
public class PhotoDaoImpl implements PhotoDao {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insert(PhotoDto photoDto) {
		int photoNo = sqlSession.selectOne("photo.sequence");
		sqlSession.insert("photo.insert", PhotoDto.builder() 
										.photoNo(photoNo) 
										.photoAuctionNo(photoDto.getPhotoAuctionNo())
										.photoAttachmentNo(photoDto.getPhotoAttachmentNo()) 
										.build());
	}

	@Override
	public List<PhotoDto> list(int photoAuctionNo) {
		List<PhotoDto> list = sqlSession.selectList("photo.list", photoAuctionNo);
		return list;
	}
}

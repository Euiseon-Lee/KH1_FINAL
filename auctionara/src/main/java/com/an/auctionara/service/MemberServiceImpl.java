package com.an.auctionara.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	
	//첨부파일(프로필) 없이 구현 후 사용할 것
	@Override
	@Transactional
	public void join(MemberDto memberDto, MultipartFile attachmentNo) throws IllegalStateException, IOException {
		memberDao.join(memberDto);
		
		//프로필 등록코드
		if(!attachmentNo.isEmpty())	{
			
		}
		
		
	}

}

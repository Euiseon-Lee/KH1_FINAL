package com.an.auctionara.service;

import java.io.IOException;
import java.sql.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.repository.GpsAddressDao;
import com.an.auctionara.repository.MemberDao;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private GpsAddressDao gpsAddressDao;
	
	
	//첨부파일(프로필) 없이 구현함 이후 추가 구현 필요
	@Override
	@Transactional
	public void join(MemberDto memberDto, MultipartFile attachmentNo) throws IllegalStateException, IOException {
		memberDao.join(memberDto);
		
		//프로필 등록코드
		if(!attachmentNo.isEmpty())	{
			
		}
		
	}

	@Scheduled(cron = "0 0 12 * * *") // 매일 오후 12시마다 인증 후 30일이 지난 주소 미인증 처리
	@Override
	public void changeGpsStaus() {
		Date limit = new java.sql.Date(System.currentTimeMillis() - (1000 * 60 * 60 * 24 * 30L));
		gpsAddressDao.changeGpsStaus(limit);
	}
}

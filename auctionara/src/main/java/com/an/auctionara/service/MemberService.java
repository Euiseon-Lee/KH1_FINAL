package com.an.auctionara.service;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;

public interface MemberService {
	
	//첨부파일(프로필) 없이 구현 후 사용할 것
	void join(MemberDto memberDto, MultipartFile attachment) throws IllegalStateException, IOException;
	void changeGpsStaus();
	boolean info(MemberDto memberDto, MultipartFile attachment) throws IllegalStateException, IOException;
}

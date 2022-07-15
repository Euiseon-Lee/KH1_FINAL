package com.an.auctionara.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.an.auctionara.entity.MemberDto;
import com.an.auctionara.vo.MemberVO;

public interface MemberService {
	
	//첨부파일(프로필) 없이 구현 후 사용할 것
	void join(MemberDto memberDto, MultipartFile attachment) throws IllegalStateException, IOException;
	void changeGpsStaus();
	boolean info(MemberDto memberDto, MultipartFile attachment) throws IllegalStateException, IOException;
	MemberVO mypage(int memberNo);
}

package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.MemberDto;

public interface MemberDao {
	
	void join(MemberDto memberDto);

	MemberDto login(String memberEmail, String memberPw);
	
	MemberDto memberSearch(int memberNo);

	int checkEmail(String memberEmail);

	void plusRedCount(int memberNo);
	
}

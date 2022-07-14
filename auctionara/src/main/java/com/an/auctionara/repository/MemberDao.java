package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.MemberDto;

public interface MemberDao {
	
	void join(MemberDto memberDto);

	MemberDto login(String memberEmail, String memberPw);
	
	MemberDto memberSearch(int memberNo);

	int checkEmailNum(String memberEmail);
	
	int checkEmail(String memberEmail);

	void plusRedCount(int memberNo);

	// 관리자 - 회원 목록 조회 메소드 
	List<MemberDto> list(String type, String keyword, int p, int s);

	// 관리자 - 회원 목록 페이징을 위한 count 메소드 
	int count(String type, String keyword);

	// 관리자 - 일반회원 등록 메소드 
	MemberDto setGeneral(int memberNo);

	// 관리자 - 블랙회원 등록 메소드 
	MemberDto setBlock(int memberNo);

	boolean resetPw(MemberDto memberDto);

	int checkNick(String memberNick);

	boolean exit(String memberEmail, String memberPw);
	
	// 관리자 - 회원 수 count 
	int countMember();

	// 관리자 - 현금화 승인 후 보유 포인트 차감 메소드 
	MemberDto deductPoints(int memberNo, int cashingMoney);
	
}

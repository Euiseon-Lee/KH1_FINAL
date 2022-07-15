package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ChatReportDto;
import com.an.auctionara.vo.ChatReportVO;
import com.an.auctionara.vo.ManagerRestrictionListVO;

public interface ChatReportDao {

	List<ChatReportVO> list(String type, String keyword, int p, int s);

	int count(String type, String keyword);

	ChatReportDto setRestrict(int chatReportNo);

}

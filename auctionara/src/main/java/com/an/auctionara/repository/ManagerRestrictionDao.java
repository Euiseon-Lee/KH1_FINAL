package com.an.auctionara.repository;

import java.util.List;

import com.an.auctionara.entity.ManagerRestrictionDto;
import com.an.auctionara.vo.ManagerRestrictionListVO;

public interface ManagerRestrictionDao {

	void restrictMember(ManagerRestrictionDto managerRestrictionDto);

	List<ManagerRestrictionListVO> list(String type, String keyword, int p, int s);

	int count(String type, String keyword);

}

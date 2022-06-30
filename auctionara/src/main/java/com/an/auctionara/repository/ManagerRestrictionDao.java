package com.an.auctionara.repository;

import com.an.auctionara.entity.ManagerRestrictionDto;

public interface ManagerRestrictionDao {

	void restrictMember(ManagerRestrictionDto managerRestrictionDto);

}

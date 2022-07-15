package com.an.auctionara.service;

import com.an.auctionara.entity.ManagerRestrictionDto;

public interface AdminRestrictService {

	void restrictAuction(ManagerRestrictionDto managerRestrictionDto, int auctionReportNo, int memberNo);

	void restrictChat(ManagerRestrictionDto managerRestrictionDto, int chatReportNo, int memberNo);

}

package com.an.auctionara.service;

import com.an.auctionara.entity.ManagerRestrictionDto;

public interface AdminRestrictService {

	void restrictMember(ManagerRestrictionDto managerRestrictionDto, int auctionReportNo, int memberNo);

}

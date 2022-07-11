package com.an.auctionara.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class AutologinDto {

	private int memberNo;
	private String autoToken;
	private String autoIssuetime;
	private String autoIp;

}

package com.an.auctionara.entity;

import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class CertDto {
	int memberNo;
	String certTarget;
	String certNo;
	String certTime;
}

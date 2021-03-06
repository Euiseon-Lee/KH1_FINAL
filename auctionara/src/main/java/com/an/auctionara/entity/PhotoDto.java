package com.an.auctionara.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PhotoDto {
	private int photoNo;
	private int photoAuctionNo;
	private int photoAttachmentNo;
}

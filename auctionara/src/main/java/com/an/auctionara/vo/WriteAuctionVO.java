package com.an.auctionara.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data@Builder@NoArgsConstructor@AllArgsConstructor
public class WriteAuctionVO {
	private int categoryNo;
	private String auctionTitle;
	private String auctionContent;
	private String auctionClosedTime;	
	private int auctionOpeningBid;
	private int auctionClosingBid;
	private int auctionBidUnit;
	private int auctionStatus;
	List<MultipartFile> attachment;
}

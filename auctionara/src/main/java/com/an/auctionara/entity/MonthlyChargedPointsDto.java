package com.an.auctionara.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MonthlyChargedPointsDto {
	private String renewalDate;
	private int totalPoints; 
}

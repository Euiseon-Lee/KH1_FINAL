package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class RatingDto {
	private int ratingItemNo;
	private String ratingSortNo; 
	private String ratingContent;
}

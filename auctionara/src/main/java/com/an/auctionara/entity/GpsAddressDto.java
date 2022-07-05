package com.an.auctionara.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class GpsAddressDto {
	private int gpsNo;
	private int memberNo;
	private double gpsLatitude;
	private double gpsLongitude;
	private Date gpsRegistTime;
	private int gpsCircle;
}

package com.an.auctionara.repository;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Repository;

@Repository
public class TokenDaoImpl implements TokenDao {

	@Override
	public String makeToken() {
		Random r = new Random();
		List<String> items = new ArrayList<>(
				Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
						"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
						"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));
		StringBuffer makeToken = new StringBuffer();
		

		
		for(int i = 0; i < 16; i++) {
			int randomitem = r.nextInt(items.size());
			String element = items.get(randomitem);
			makeToken.append(element);
		}
		
		String autoToken = makeToken.toString();
		
		return autoToken;
		
		
	}
}

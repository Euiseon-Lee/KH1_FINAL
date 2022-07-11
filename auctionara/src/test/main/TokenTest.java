import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import org.junit.Test;


public class TokenTest {
	
	@Test
	public void test() {
		Random r = new Random();
		List<String> items = new ArrayList<>(
				Arrays.asList("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", 
						"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
						"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"));
		StringBuffer makeToken = new StringBuffer();
		

		
		for(int i = 0; i < 60; i++) {
			int randomitem = r.nextInt(items.size());
			String element = items.get(randomitem);
			makeToken.append(element);
		}
		
		String autoToken = makeToken.toString();
		
		System.out.println(autoToken);


	}
}

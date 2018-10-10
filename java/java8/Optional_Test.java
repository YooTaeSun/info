package zJavaTest;

import java.util.Optional;

public class Optional_Test {
	public static void main(String[] args) {

		String str = "hello";
		str = null;
		Optional<String> o1 = Optional.ofNullable(str);
		
		System.out.println("o1 >> " + o1);
		
		System.out.println(
			"\n >> " + o1.orElse("aaa")
			+ "\n >> " + o1.orElse(new String("bbb"))
			+ "\n >> " + o1.orElseGet(() -> new String("ccc"))
			+ "\n >> " + o1.orElseGet(String::new)
			
			);
		
	}
}

package www.townsi.com.e02_function;

import java.util.function.Function;

/**
 * 
 *
 */
public class FunctionExamples {

  private static void functionExamples() {

	    Function<String, Integer> aaa = (value) -> Integer.parseInt(value);
		Function<String,String> ccc = Function.identity();
		Function<String,String> ccc2 = t -> t;
		
		System.out.println(aaa.apply("001"));
		System.out.println(ccc.apply("999"));
		System.out.println(aaa.apply("1000"));
  }

  public static void main(String[] args) {
	  functionExamples();
  }

}

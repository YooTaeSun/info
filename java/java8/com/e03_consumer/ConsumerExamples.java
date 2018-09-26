package www.townsi.com.e03_consumer;

import java.util.function.Consumer;

/**
 * 
 *
 */
public class ConsumerExamples {

  private static void consumerExamples() {

	  Consumer<String> print = new Consumer<String>() {
			@Override
			public void accept(String value) {
				System.out.println(value);
			}
		  };
		  
	  print.accept("hello");
	  
	  Consumer<String> print2 = value -> System.out.println("Hello " + value);
	  print2.accept("hello2");

  }

  public static void main(final String[] args) {
    consumerExamples();
  }

}

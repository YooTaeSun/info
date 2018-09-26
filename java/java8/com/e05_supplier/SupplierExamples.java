package www.townsi.com.e05_supplier;

import java.util.concurrent.TimeUnit;
import java.util.function.Supplier;

/**
 * 
 */
public class SupplierExamples {

  private static String getVeryExpensiveValue() {
    try {
      TimeUnit.SECONDS.sleep(3);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    return "ebonggu005";
  }

  private static void callingExpensiveMethodWithSupplier() {
    final long start = System.currentTimeMillis();
    
    printIfValidIndex(0, new Supplier<String>() {
		@Override
		public String get() {
			return getVeryExpensiveValue();
		}
	});
    printIfValidIndex(-1, () -> getVeryExpensiveValue());
    printIfValidIndex(-2, () -> getVeryExpensiveValue());
    System.out.println("It took " + ((System.currentTimeMillis() - start) / 1000) + " seconds.");
  }


  private static void printIfValidIndex(final int number, final Supplier<String> valueSupplier) {
    if (number >= 0) {
      System.out.println("The value is " + valueSupplier.get() + ".");
    } else {
      System.out.println("Invalid");
    }
  }


  private static void supplierExamples() {
    System.out.println("SupplierExamples.supplierExamples()");
    final Supplier<String> helloSupplier = () -> "Hello ";
    System.out.println(helloSupplier.get() + "world");
  }


  public static void main(final String[] args) {
    supplierExamples();

    callingExpensiveMethodWithSupplier();
  }

}

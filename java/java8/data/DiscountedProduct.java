package www.townsi.data;

import java.math.BigDecimal;

import lombok.ToString;

@ToString(callSuper = true) 
public class DiscountedProduct extends Product {
  public DiscountedProduct(final Long id, final String name, final BigDecimal price) {
    super(id, name, price);
  }
}

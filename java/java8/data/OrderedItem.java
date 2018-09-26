package www.townsi.data;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class OrderedItem {
  private Long id;
  private Product product;
  private int quantity;

  public BigDecimal getItemTotal() {
    return product.getPrice().multiply(new BigDecimal(quantity));
  }
}
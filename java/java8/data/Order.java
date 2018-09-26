package www.townsi.data;

import java.math.BigDecimal;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import www.townsi.com.e07_functionalinterface_examples.FunctionalInterfaceExamples;

@AllArgsConstructor
@Data 
public class Order {
  private Long id;
  private String orderNumber;
  private List<OrderedItem> items;

  public BigDecimal totalPrice() {
    return FunctionalInterfaceExamples.total(items, item -> item.getItemTotal());
  }
}

package www.townsi.data;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data 
public class Product {
  private Long id;
  private String name;
  private BigDecimal price;
}
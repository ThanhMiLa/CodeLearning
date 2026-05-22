package com.thanhmila.codelearning.dto.response;

import com.thanhmila.codelearning.entity.enums.OrderStatus;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class OrderCheckoutResponse {

    Long orderId;
    BigDecimal totalAmount;
    OrderStatus status;

}

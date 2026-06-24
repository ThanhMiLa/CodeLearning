package com.thanhmila.codelearning.mapper;

import com.thanhmila.codelearning.dto.response.CartItemResponse;
import com.thanhmila.codelearning.dto.response.CartResponse;
import com.thanhmila.codelearning.entity.payment.CartEntity;
import com.thanhmila.codelearning.entity.payment.CartItemEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring", uses = {CourseMapper.class})
public interface CartMapper {

    CartResponse toCartResponse(CartEntity cartEntity);

    CartItemResponse toCartItemResponse(CartItemEntity cartItemEntity);

}

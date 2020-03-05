package com.itlabs.api.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Value;

@Builder
@Value
@AllArgsConstructor
public class ProductModel {
   private String name ;
   private int id ;

}

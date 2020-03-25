package com.itlabs.api.models;

import lombok.AllArgsConstructor;
import lombok.Value;

@Value
@AllArgsConstructor
public class ItemEditModel {
  private String name;
  private ItemStatus status;
  private String description;
}

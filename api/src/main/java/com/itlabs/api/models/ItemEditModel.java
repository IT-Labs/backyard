package com.itlabs.api.models;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Value;
import org.springframework.validation.annotation.Validated;

@Value
@AllArgsConstructor
public class ItemEditModel {
  @NotEmpty
  private String name;
  private ItemStatus status;
  private String description;
}

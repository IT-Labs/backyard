package com.itlabs.api.models;

import java.time.LocalDateTime;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Value;

@Builder
@Value
@AllArgsConstructor
public class ItemModel {

  private String name;

  private ItemStatus status;

  private String description;

  private String id;

  private boolean publiclyAvailable;

  private LocalDateTime published;
}

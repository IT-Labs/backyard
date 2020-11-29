package com.itlabs.api.models;

import javax.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Value;

@Value
@AllArgsConstructor
public class ItemEditModel {

	@NotEmpty
	private String name;

	private ItemStatus status;

	private String description;

}

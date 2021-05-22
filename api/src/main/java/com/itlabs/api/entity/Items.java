package com.itlabs.api.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.itlabs.api.common.GlobalConstants;
import com.itlabs.api.models.ItemStatus;
import java.time.LocalDateTime;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "items")
public class Items extends BaseEntity {

	String name;

	String description;

	@Enumerated(EnumType.STRING)
	ItemStatus status;

	String type;

	@JsonFormat(pattern = GlobalConstants.DATE_FORMAT)
	LocalDateTime published;

	boolean isPublic;

}

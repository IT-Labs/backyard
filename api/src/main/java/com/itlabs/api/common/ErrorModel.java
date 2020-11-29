package com.itlabs.api.common;

import com.fasterxml.jackson.annotation.JsonFormat;
import java.util.Date;
import lombok.Builder;
import lombok.Data;
import org.springframework.http.HttpStatus;

@Data
@Builder
public class ErrorModel {

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = GlobalConstants.DATE_FORMAT)
	private Date timestamp;

	private String message;

	private HttpStatus code;

}

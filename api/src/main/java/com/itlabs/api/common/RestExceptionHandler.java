package com.itlabs.api.common;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.web.util.WebUtils;

@Order(Ordered.HIGHEST_PRECEDENCE)
@ControllerAdvice
@Slf4j
public class RestExceptionHandler extends ResponseEntityExceptionHandler {

	@Override
	protected ResponseEntity<Object> handleExceptionInternal(Exception ex, Object body, HttpHeaders headers,
			HttpStatus status, WebRequest request) {
		log.error("Internal Error with request {}", new RequestLogModel(request).toString(), ex);
		if (HttpStatus.INTERNAL_SERVER_ERROR.equals(status)) {
			request.setAttribute(WebUtils.ERROR_EXCEPTION_ATTRIBUTE, ex, RequestAttributes.SCOPE_REQUEST);
		}
		return buildResponseEntity(ex, HttpStatus.BAD_REQUEST);
	}

	@ExceptionHandler(Exception.class)
	protected ResponseEntity<Object> handleException(Exception ex, HttpServletRequest request) {
		return logAndBuildResponseEntity(ex, request, HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@ExceptionHandler({ EmptyResultDataAccessException.class })
	protected ResponseEntity<Object> handleItemNotFound(EmptyResultDataAccessException ex, HttpServletRequest request) {
		return logAndBuildResponseEntity(ex, request, HttpStatus.NOT_FOUND);
	}

	private ResponseEntity<Object> buildResponseEntity(Exception exception, HttpStatus status) {
		final ErrorModel errorModel = ErrorModel.builder().code(status).timestamp(new Date())
				.message(exception.getMessage()).build();
		return new ResponseEntity<>(errorModel, status);
	}

	private ResponseEntity<Object> logAndBuildResponseEntity(Exception exception, HttpServletRequest request,
			HttpStatus httpStatus) {
		log.error("Error with request {}", new RequestLogModel(request).toString(), exception);
		return buildResponseEntity(exception, httpStatus);
	}

}

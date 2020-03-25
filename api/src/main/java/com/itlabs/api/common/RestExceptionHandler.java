package com.itlabs.api.common;

import lombok.extern.slf4j.Slf4j;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;
import org.springframework.web.util.WebUtils;

@Order(Ordered.HIGHEST_PRECEDENCE)
@ControllerAdvice
@Slf4j
public class RestExceptionHandler extends ResponseEntityExceptionHandler {

  @Override
  protected ResponseEntity<Object> handleExceptionInternal(
      Exception ex, Object body, HttpHeaders headers, HttpStatus status, WebRequest request) {
    log.error("Response Entity Exception Handler for {}", ex.getClass().getName(), ex);
    if (HttpStatus.INTERNAL_SERVER_ERROR.equals(status)) {
      request.setAttribute(WebUtils.ERROR_EXCEPTION_ATTRIBUTE, ex, WebRequest.SCOPE_REQUEST);
    }
    return buildResponseEntity(ex, HttpStatus.BAD_REQUEST);
  }

  private ResponseEntity<Object> logAndBuildResponseEntity(
      Exception exception, HttpStatus httpStatus) {
    log.error(exception.getClass().getName(), exception);
    return buildResponseEntity(exception, httpStatus);
  }

  @ExceptionHandler(Exception.class)
  protected ResponseEntity<Object> handleException(Exception ex) {
    return logAndBuildResponseEntity(ex, HttpStatus.INTERNAL_SERVER_ERROR);
  }

  @ExceptionHandler({EmptyResultDataAccessException.class})
  protected ResponseEntity<Object> handleItemNotFound(EmptyResultDataAccessException ex) {
    return logAndBuildResponseEntity(ex, HttpStatus.NOT_FOUND);
  }

  private ResponseEntity<Object> buildResponseEntity(Exception exception, HttpStatus status) {
    return new ResponseEntity<>(exception.getMessage(), status);
  }
}

package com.itlabs.api.common;

public class GeneralRuntimeException extends RuntimeException {

  public GeneralRuntimeException(Exception exception) {
    super(exception);
  }

  public GeneralRuntimeException(String message, Exception exception) {
    super(message, exception);
  }
}

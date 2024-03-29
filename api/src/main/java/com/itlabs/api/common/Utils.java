package com.itlabs.api.common;

import com.fasterxml.jackson.databind.ObjectMapper;

public class Utils {

  private Utils() {
    // hide constructor
  }

  public static String asJsonString(final Object obj) {
    try {
      return new ObjectMapper().writeValueAsString(obj);
    } catch (Exception e) {
      throw new GeneralRuntimeException(e);
    }
  }
}

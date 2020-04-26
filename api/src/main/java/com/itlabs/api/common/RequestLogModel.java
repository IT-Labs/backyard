package com.itlabs.api.common;

import javax.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.ToString;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.context.request.WebRequest;

@ToString
@Getter
public class RequestLogModel {



  private RequestLogModel() {

  }
  public RequestLogModel(WebRequest request) {
    this(((ServletWebRequest) request).getRequest());
  }

  public RequestLogModel(HttpServletRequest request) {
    if (request == null) {
      return;
    }
    setUrl(request);
    setUser(request);
    setRemoteAddress(request);
    setHttpHeaders(request);
  }
  private String action;
  private String remoteAddress;
  private String user;
  private String url;
  private HttpHeaders headers;

  private void setHttpHeaders(HttpServletRequest request) {
    headers = new ServletServerHttpRequest(request).getHeaders();
  }

  private void setRemoteAddress(HttpServletRequest request) {
    remoteAddress = request.getRemoteAddr();
  }

  private void setUser(HttpServletRequest request) {
    user = request.getRemoteUser();
  }

  private void setUrl(HttpServletRequest request) {
    url = request.getRequestURI();
    action=request.getMethod();
    String queryString = request.getQueryString();
    if (StringUtils.isEmpty(queryString)) {
      return;
    }
    url = String.format("%s?%s", url, queryString);
  }
}

package com.ej.integration;

import static com.ej.common.config.SecurityConfig.APP_MONITOR;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.ej.BaseTestIT;
import com.ej.common.config.HealthMetricsExportConfiguration;
import org.junit.jupiter.api.Test;
import org.junit.platform.commons.util.StringUtils;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

class ActuatorITTest extends BaseTestIT {
  protected RestTemplate getManagementRestTemplate() {
    return new RestTemplateBuilder().build();
  }

  public static final String PROMETHEUS = APP_MONITOR + "/prometheus";
  public static final String ENV = APP_MONITOR + "/env";

  @Test
  void testPrometheusEndPoint() {
    final String url = getManagementRootUri() + PROMETHEUS;
    ResponseEntity<String> response = getManagementRestTemplate().getForEntity(url, String.class);
    assertTrue(response.getStatusCode().is2xxSuccessful());
    assertTrue(StringUtils.isNotBlank(response.getBody()));
    assertTrue(
        response.getBody().contains(HealthMetricsExportConfiguration.ACTUATOR_HEALTH_METRIC_NAME));
    assertTrue(
        response
            .getBody()
            .contains(HealthMetricsExportConfiguration.ACTUATOR_HEALTH_TAG_SERVICE_NAME));
  }

  @Test
  void testPrometheusEndPointBaseUrl() {
    final String url = getBaseUrl() + PROMETHEUS.replaceFirst("/", "");
    RestTemplate restTemplate = getManagementRestTemplate();
    assertNotEquals(port, localManagementPort);
    assertThrows(
        HttpClientErrorException.class, () -> restTemplate.getForEntity(url, String.class));
  }

  @Test
  void testEnvEndPoint() {
    final String url = getManagementRootUri() + ENV;
    ResponseEntity<String> response = getManagementRestTemplate().getForEntity(url, String.class);
    assertTrue(response.getStatusCode().is2xxSuccessful());
    assertTrue(StringUtils.isNotBlank(response.getBody()));
  }
}

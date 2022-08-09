package com.itlabs.api.integration;

import static org.junit.jupiter.api.Assertions.assertTrue;

import com.itlabs.api.configuration.HealthMetricsConfiguration;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.junit.platform.commons.util.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

class ActuatorTest extends BaseIntegration {
  public ActuatorTest() {
    super(null);
  }

  @Value("${local.management.port}")
  private int localManagementPort;

  private String getManagementRootUri() {
    return "http://localhost:" + localManagementPort;
  }

  public static final String ACTUATOR = "/actuator";

  protected RestTemplate getManagementRestTemplate() {
    return new RestTemplateBuilder().build();
  }

  public static final String PROMETHEUS = ACTUATOR + "/prometheus";
  public static final String ENV = ACTUATOR + "/env";

  @Test
  @Disabled
  void testPrometheusEndPoint() {
    final String url = getManagementRootUri() + PROMETHEUS;
    ResponseEntity<String> response = getManagementRestTemplate().getForEntity(url, String.class);

    assertTrue(response.getStatusCode().is2xxSuccessful());
    assertTrue(StringUtils.isNotBlank(response.getBody()));
    assertTrue(response.getBody().contains(HealthMetricsConfiguration.ACTUATOR_HEALTH_METRIC_NAME));
    assertTrue(
        response.getBody().contains(HealthMetricsConfiguration.ACTUATOR_HEALTH_TAG_SERVICE_NAME));
  }

  @Test
  void testEnvEndPoint() {
    final String url = getManagementRootUri() + ENV;
    ResponseEntity<String> response = getManagementRestTemplate().getForEntity(url, String.class);
    assertTrue(response.getStatusCode().is2xxSuccessful());
    assertTrue(StringUtils.isNotBlank(response.getBody()));
  }
}

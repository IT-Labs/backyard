package com.itlabs.api.common.autoconfigure;

import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.CompositeHealthContributor;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthContributor;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.boot.actuate.health.Status;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.context.annotation.Configuration;

@Configuration(proxyBeanMethods = false)
@Slf4j
@ConditionalOnClass({MeterRegistry.class, Gauge.class, Health.class, HealthIndicator.class})
public class HealthMetricsConfiguration {

  private static final int UNKNOWN = 0;

  private static final int SERVICE_DOWN = 1;

  private static final int OUT_OF_SERVICE = 2;

  private static final int SERVICE_UP = 3;

  public static final String ACTUATOR_HEALTH_METRIC_NAME = "actuator_health_sample";

  public static final String ACTUATOR_HEALTH_TAG_SERVICE_NAME = "service";

  public static final String ACTUATOR_HEALTH_TAG_INDICATOR_NAME = "indicator";

  private final MeterRegistry registry;

  private final String applicationName;

  public HealthMetricsConfiguration(
      MeterRegistry registry,
      Map<String, HealthContributor> healthContributors,
      @Value("${spring.application.name}") String applicationName) {
    this.registry = registry;
    this.applicationName = applicationName;
    setMeterStatusFromHealthContributors(healthContributors);
  }

  private void setMeterStatusFromHealthContributors(
      Map<String, HealthContributor> healthContributors) {
    healthContributors.forEach(
        (name, contributor) -> {
          if (contributor instanceof HealthIndicator) {

            setHealthStatusInMeterRegistry(name, (HealthIndicator) contributor);
          } else if (contributor instanceof CompositeHealthContributor) {
            CompositeHealthContributor healthContributor = (CompositeHealthContributor) contributor;
            healthContributor.forEach(
                x ->
                    setHealthStatusInMeterRegistry(
                        x.getName(), (HealthIndicator) x.getContributor()));
          } else {
            throwIllegalStateException(name);
          }
        });
  }

  private void throwIllegalStateException(String name) {
    throw new IllegalStateException(String.format("Unknown HealthContributor type: %s", name));
  }

  private void setHealthStatusInMeterRegistry(String name, HealthIndicator contributor) {
    setHealthStatusInMeterRegistry(name, contributor.health());
  }

  private void setHealthStatusInMeterRegistry(String name, Health health) {
    log.debug("setting {} service health status in meter registry ", name);
    Gauge.builder(ACTUATOR_HEALTH_METRIC_NAME, health, this::getStatusCode)
        .strongReference(true)
        .tag(ACTUATOR_HEALTH_TAG_SERVICE_NAME, applicationName)
        .tag(ACTUATOR_HEALTH_TAG_INDICATOR_NAME, name)
        .register(registry);
  }

  private int getStatusCode(Health health) {
    Status status = health.getStatus();
    if (Status.UP.equals(status)) {
      return SERVICE_UP;
    }
    if (Status.OUT_OF_SERVICE.equals(status)) {
      return OUT_OF_SERVICE;
    }
    if (Status.DOWN.equals(status)) {
      return SERVICE_DOWN;
    }
    return UNKNOWN;
  }
}

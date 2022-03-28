package com.itlabs.api.common.autoconfigure;

import io.micrometer.core.instrument.Gauge;
import io.micrometer.core.instrument.MeterRegistry;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.CompositeHealthContributor;
import org.springframework.boot.actuate.health.CompositeReactiveHealthContributor;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthContributor;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.boot.actuate.health.ReactiveHealthContributor;
import org.springframework.boot.actuate.health.ReactiveHealthIndicator;
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
  public static final String ACTUATOR_HEALTH_METRIC_NAME = "actuator_health_sample-1.0.0";
  public static final String ACTUATOR_HEALTH_TAG_SERVICE_NAME = "service";
  public static final String ACTUATOR_HEALTH_TAG_INDICATOR_NAME = "indicator";
  private final MeterRegistry registry;
  private final String applicationName;

  public HealthMetricsConfiguration(
      MeterRegistry registry,
      Map<String, HealthContributor> healthContributors,
      Map<String, ReactiveHealthContributor> reactiveHealthContributors,
      @Value("${spring.application.name}") String applicationName) {
    this.registry = registry;
    this.applicationName = applicationName;
    setMeterStatusFromHealthContributors(healthContributors);
    setMeterStatusFromReactiveHealthContributors(reactiveHealthContributors);
  }

  private void setMeterStatusFromHealthContributors(
      final Map<String, HealthContributor> healthContributors) {
    healthContributors.forEach(
        (name, contributor) -> {
          if (contributor instanceof HealthIndicator) {
            setHealthStatusInMeterRegistry(name, (HealthIndicator) contributor);
          } else if (contributor instanceof CompositeHealthContributor) {
            var healthContributor = (CompositeHealthContributor) contributor;
            healthContributor.forEach(
                x ->
                    setHealthStatusInMeterRegistry(
                        x.getName(), (HealthIndicator) x.getContributor()));
          } else {
            throw new IllegalStateException(
                String.format("Unknown HealthContributor type: %s", name));
          }
        });
  }

  private void setMeterStatusFromReactiveHealthContributors(
      final Map<String, ReactiveHealthContributor> reactiveHealthContributors) {
    reactiveHealthContributors.forEach(
        (name, contributor) -> {
          if (contributor instanceof ReactiveHealthIndicator) {

            setHealthStatusInMeterRegistry(name, ((ReactiveHealthIndicator) contributor));
          } else if (contributor instanceof CompositeReactiveHealthContributor) {
            var healthContributor = (CompositeReactiveHealthContributor) contributor;
            healthContributor.forEach(
                x ->
                    setHealthStatusInMeterRegistry(
                        x.getName(), ((ReactiveHealthIndicator) x.getContributor())));
          } else {
            throw new IllegalStateException(
                String.format("Unknown HealthContributor type: %s", name));
          }
        });
  }

  private void setHealthStatusInMeterRegistry(
      final String name, final HealthIndicator contributor) {
    setHealthStatusInMeterRegistry(name, contributor.health());
  }

  private void setHealthStatusInMeterRegistry(
      final String name, final ReactiveHealthIndicator contributor) {
    setHealthStatusInMeterRegistry(name, contributor.health().block());
  }

  private void setHealthStatusInMeterRegistry(final String name, final Health health) {
    log.debug("setting {} service health status in meter registry ", name);
    Gauge.builder(ACTUATOR_HEALTH_METRIC_NAME, health, this::getStatusCode)
        .strongReference(true)
        .tag(ACTUATOR_HEALTH_TAG_SERVICE_NAME, applicationName)
        .tag(ACTUATOR_HEALTH_TAG_INDICATOR_NAME, name)
        .register(registry);
  }

  private int getStatusCode(final Health health) {
    var status = health.getStatus();
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

package com.itlabs.api.common;

import com.itlabs.api.common.autoconfigure.HealthMetricsConfiguration;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;

@SpringBootTest
@ContextConfiguration(classes = HealthMetricsConfiguration.class)
class ApiCommonApplicationTests {

  @Test
  void whenSpringLoad_Then_No_Execution() {}
}

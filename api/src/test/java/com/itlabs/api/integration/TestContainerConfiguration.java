package com.itlabs.api.integration;

import javax.sql.DataSource;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.wait.strategy.Wait;

@TestConfiguration
public class TestContainerConfiguration {
  static final PostgreSQLContainer POSTGRE_SQL_CONTAINER;

  static {
    POSTGRE_SQL_CONTAINER = new PostgreSQLContainer("postgres:12.2");
    POSTGRE_SQL_CONTAINER.start();
    POSTGRE_SQL_CONTAINER.waitingFor(Wait.forHealthcheck()).waitingFor(Wait.forHttp("/"));
  }

  @Primary
  @Bean
  public DataSource dataSource() {
    final String url = POSTGRE_SQL_CONTAINER.getJdbcUrl();
    DataSource bean =
        DataSourceBuilder.create()
            .driverClassName(POSTGRE_SQL_CONTAINER.getDriverClassName())
            .url(url)
            .username(POSTGRE_SQL_CONTAINER.getUsername())
            .password(POSTGRE_SQL_CONTAINER.getPassword())
            .build();
    return bean;
  }
}

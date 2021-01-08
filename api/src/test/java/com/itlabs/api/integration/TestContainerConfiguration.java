package com.itlabs.api.integration;

import dasniko.testcontainers.keycloak.KeycloakContainer;
import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.adapters.springboot.KeycloakSpringBootProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.testcontainers.containers.Container.ExecResult;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.containers.wait.strategy.Wait;
import org.testcontainers.utility.MountableFile;

@TestConfiguration
@Slf4j
public class TestContainerConfiguration {

	static final PostgreSQLContainer POSTGRE_SQL_CONTAINER;
	static final KeycloakContainer KEYCLOAK_CONTAINER;

	static {
		POSTGRE_SQL_CONTAINER = new PostgreSQLContainer("postgres:12.5-alpine");
		POSTGRE_SQL_CONTAINER.start();
		POSTGRE_SQL_CONTAINER.waitingFor(Wait.forHealthcheck()).waitingFor(Wait.forHttp("/"));
		KEYCLOAK_CONTAINER = new KeycloakContainer("jboss/keycloak:12.0.1").withRealmImportFile("sample-realm.json")
				.withCopyFileToContainer(MountableFile.forClasspathResource("create-keycloak-user.sh", 700),
						"create-keycloak-user.sh");

		KEYCLOAK_CONTAINER.start();
		KEYCLOAK_CONTAINER.waitingFor(Wait.forHealthcheck()).waitingFor(Wait.forHttp("/"));
		try {
			ExecResult result = KEYCLOAK_CONTAINER.execInContainer("sh", "create-keycloak-user.sh");
			log.info(result.toString());
		}
		catch (Exception e) {
			log.error("error during executing script", e);
		}
	}

	@Autowired
	KeycloakSpringBootProperties keycloakSpringBootProperties;

	@PostConstruct
	void init() {
		keycloakSpringBootProperties.setAuthServerUrl(KEYCLOAK_CONTAINER.getAuthServerUrl());
	}

	@Primary
	@Bean
	public DataSource dataSource() {
		final String url = POSTGRE_SQL_CONTAINER.getJdbcUrl();
		DataSource bean = DataSourceBuilder.create().driverClassName(POSTGRE_SQL_CONTAINER.getDriverClassName())
				.url(url).username(POSTGRE_SQL_CONTAINER.getUsername()).password(POSTGRE_SQL_CONTAINER.getPassword())
				.build();
		return bean;
	}

}

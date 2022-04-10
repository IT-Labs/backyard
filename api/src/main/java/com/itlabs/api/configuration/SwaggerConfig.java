package com.itlabs.api.configuration;

import static com.itlabs.api.controllers.Routes.API_ROOT_ROUTE;
import static com.itlabs.api.controllers.Routes.HOME_ROUTE;
import static springfox.documentation.builders.PathSelectors.regex;
import static springfox.documentation.spi.DocumentationType.SWAGGER_2;

import java.util.Collections;
import java.util.Date;
import java.util.List;
import org.springframework.boot.info.BuildProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ApiKey;
import springfox.documentation.service.AuthorizationScope;
import springfox.documentation.service.Contact;
import springfox.documentation.service.SecurityReference;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;

@Configuration
public class SwaggerConfig {

  private final BuildProperties buildProperties;
  static final String ACTUATOR = ".*/actuator.*";

  public SwaggerConfig(BuildProperties buildProperties) {
    this.buildProperties = buildProperties;
  }

  @Bean
  public Docket api() {
    return new Docket(SWAGGER_2)
        .groupName("api")
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(regex(String.format(".*%s.*", API_ROOT_ROUTE)))
        .build()
        .apiInfo(apiInfo(buildProperties.getName()))
        .securitySchemes(Collections.singletonList(apiKey()))
        .securityContexts(Collections.singletonList(securityContext()));
  }

  @Bean
  public Docket publicApi() {
    return new Docket(SWAGGER_2)
        .groupName("public api")
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(regex(String.format(".*%s.*", HOME_ROUTE)))
        .build()
        .apiInfo(apiInfo(buildProperties.getName()));
  }

  @Bean
  public Docket actuatorApi() {
    return new Docket(SWAGGER_2)
        .groupName("monitoring-api")
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(regex(ACTUATOR))
        .build()
        .apiInfo(apiInfo("Actuator"))
        .securitySchemes(Collections.singletonList(apiKey()))
        .securityContexts(Collections.singletonList(securityContext()));
  }

  private ApiInfo apiInfo(String name) {

    return new ApiInfo(
        name,
        String.format(
            " Application Build at %s and Started at %s",
            buildProperties.getTime(), new Date().toInstant()),
        buildProperties.getVersion(),
        "",
        new Contact("Jovica Krstevski", "http://it-labs.com", "jovica.krstevski@it-labs.com"),
        "MIT",
        "https://github.com/IT-Labs/backyard/blob/master/LICENSE",
        Collections.emptyList());
  }

  private ApiKey apiKey() {

    return new ApiKey("bearer", "Authorization", "header");
  }

  private SecurityContext securityContext() {
    return SecurityContext.builder().securityReferences(defaultAuth()).build();
  }

  List<SecurityReference> defaultAuth() {
    AuthorizationScope authorizationScope = new AuthorizationScope("global", "accessEverything");
    AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
    authorizationScopes[0] = authorizationScope;
    return Collections.singletonList(new SecurityReference("Authorization", authorizationScopes));
  }
}

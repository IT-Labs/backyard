package com.itlabs.api.configuration;

import java.util.Collections;
import java.util.Date;
import org.springframework.boot.info.BuildProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
  private final BuildProperties buildProperties;

  public SwaggerConfig(BuildProperties buildProperties){
    this.buildProperties = buildProperties;
  }
  @Bean
  public Docket api() {
    return new Docket(DocumentationType.SWAGGER_2)
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(PathSelectors.any())
        .build().apiInfo(apiInfo());
  }
  private ApiInfo apiInfo() {
    return new ApiInfo(
            buildProperties.getName(),
            String.format(" Application Build at %s and Started at %s", buildProperties.getTime(), new Date().toInstant()),
            buildProperties.getVersion(),
            "",
            new Contact("Jovica Krstevski", "http://it-labs.com", "jovica.krstevski@it-labs.com"),
            "MIT", "https://github.com/IT-Labs/backyard/blob/master/LICENSE", Collections.emptyList());
  }
}

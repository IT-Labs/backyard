package com.itlabs.api.configuration;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.security.SecurityScheme;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import lombok.val;
import org.springframework.boot.info.BuildProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ApiKey;
import springfox.documentation.service.AuthorizationScope;
import springfox.documentation.service.Contact;
import springfox.documentation.service.GrantType;
import springfox.documentation.service.ImplicitGrant;
import springfox.documentation.service.LoginEndpoint;
import springfox.documentation.service.OAuth;
import springfox.documentation.service.SecurityReference;
import springfox.documentation.spi.service.contexts.SecurityContext;
import springfox.documentation.spring.web.plugins.Docket;
import static com.itlabs.api.controllers.Routes.API_ROOT_ROUTE;
import static springfox.documentation.builders.PathSelectors.regex;
import static springfox.documentation.spi.DocumentationType.SWAGGER_2;

@Configuration
public class SwaggerConfig {

	private final BuildProperties buildProperties;
	static final String ACTUATOR = ".*/actuator.*";

	public SwaggerConfig(BuildProperties buildProperties) {
		this.buildProperties = buildProperties;
	}

	@Bean
	public Docket api() {
		return new Docket(SWAGGER_2).groupName("api").select().apis(RequestHandlerSelectors.any())
				.paths(regex(String.format(".*%s.*", API_ROOT_ROUTE))).build()
				.apiInfo(apiInfo(buildProperties.getName())).securitySchemes(Collections.singletonList(apiKey()))
				.securityContexts(Collections.singletonList(securityContext()));
	}

	@Bean
	public Docket actuatorApi() {
		return new Docket(SWAGGER_2).groupName("monitoring-api").select().apis(RequestHandlerSelectors.any())
				.paths(regex(ACTUATOR)).build().apiInfo(apiInfo("Actuator"))
				.securitySchemes(Collections.singletonList(apiKey()))
				.securityContexts(Collections.singletonList(securityContext()));
	}

	private ApiInfo apiInfo(String name) {

		return new ApiInfo(name,
				String.format(" Application Build at %s and Started at %s", buildProperties.getTime(),
						new Date().toInstant()),
				buildProperties.getVersion(), "",
				new Contact("Jovica Krstevski", "http://it-labs.com", "jovica.krstevski@it-labs.com"), "MIT",
				"https://github.com/IT-Labs/backyard/blob/master/LICENSE", Collections.emptyList());
	}

	// private OAuth securitySchema1() {
	// AuthorizationScope authorizationScope = new
	// AuthorizationScope(authorizationScopeGlobal, authorizationScopeGlobal);
	// LoginEndpoint loginEndpoint = new LoginEndpoint("http://localhost:6871/sso/login");
	// GrantType grantType = new ImplicitGrant(loginEndpoint, "access_token");
	// return new OAuth(securitySchemaOAuth2, newArrayList(authorizationScope),
	// newArrayList(grantType));
	//
	//
	// var login =
	// LoginEndpointBuilder().url("니꺼/auth/realms/니꺼/protocol/openid-connect/auth").build()
	// var gTypes: MutableList<GrantType> =ArrayList<GrantType> ()
	// gTypes.add(ImplicitGrant(login, "acces_token"))
	// lst.add(OAuth("oauth2", scopes(), gTypes))
	// return lst
	// }
	//
	// private SecurityContext securityContext1() {
	// return SecurityContext.builder()
	// .securityReferences(defaultAuth1())
	// .forPaths(internalPaths())
	// .build();
	// }
	//
	// private List<SecurityReference> defaultAuth1() {
	// AuthorizationScope authorizationScope
	// = new AuthorizationScope(authorizationScopeGlobal, authorizationScopeGlobalDesc);
	// AuthorizationScope[] authorizationScopes = new AuthorizationScope[1];
	// authorizationScopes[0] = authorizationScope;
	// return newArrayList(
	// new SecurityReference(securitySchemaOAuth2, authorizationScopes));
	// }

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

	// @Bean
	// public GroupedOpenApi customApi() {
	// return GroupedOpenApi.builder().group("api").pathsToMatch("/api/**").build();
	// }
	//
	// @Bean
	// public GroupedOpenApi actuatorApi() {
	// return
	// GroupedOpenApi.builder().group("actuator").pathsToMatch("/actuator/**").build();
	// }
	//
	@Bean
	public OpenAPI customOpenAPI() {
		return new OpenAPI().components(new Components().addSecuritySchemes("bearer-key",
				new SecurityScheme().type(SecurityScheme.Type.HTTP).scheme("bearer").bearerFormat("JWT")));
	}

}

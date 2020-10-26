package itlabs.apigateway;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {



  @Bean
  public RouteLocator internalRoutesLocator(RouteLocatorBuilder builder,
                                            InternalServiceConfiguration internalServiceConfiguration) {
    return builder
        .routes()
            .route(r -> r.path("/items/**")
                    .filters(f -> f.rewritePath("/items", "/api/v1/items"))
                    .uri(internalServiceConfiguration.getInternalApiUrl())
                    .id("itemsModule"))
                    .build();
  }
}

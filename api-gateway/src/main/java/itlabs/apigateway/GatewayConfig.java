package itlabs.apigateway;

import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class GatewayConfig {

  @Bean
  public RouteLocator microserviceRoutes(RouteLocatorBuilder builder) {
    return builder
        .routes()
        .route(
            mailer ->
                mailer
                    .path("/internal-api/**")
                    .filters(f -> f.rewritePath("/internal-api/(?<remains>.*)", "/${remains}"))
                    .uri("http://localhost:5000/")
                    .id("api"))
        .build();
  }
}

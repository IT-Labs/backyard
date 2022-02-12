package itlabs.apigateway;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.reactive.CorsConfigurationSource;
import org.springframework.web.cors.reactive.CorsWebFilter;
import org.springframework.web.cors.reactive.UrlBasedCorsConfigurationSource;
import org.springframework.web.reactive.config.EnableWebFlux;

@Configuration
@EnableWebFlux
public class WebFluxCORSFilter {

  @Bean
  public CorsWebFilter corsFilter(CorsConfigurationSource corsConfigurationSource) {
    return new CorsWebFilter(corsConfigurationSource);
  }

  @Bean
  CorsConfigurationSource corsConfigurationSource() {
    final UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    CorsConfiguration config = new CorsConfiguration().applyPermitDefaultValues();
    config.setMaxAge(5000L);
    config.addAllowedMethod(HttpMethod.PATCH.name());
    config.addAllowedMethod(HttpMethod.DELETE.name());
    config.addAllowedMethod(HttpMethod.OPTIONS.name());
    config.addAllowedMethod(HttpMethod.PUT.name());
    source.registerCorsConfiguration("/**", config);
    return source;
  }
}

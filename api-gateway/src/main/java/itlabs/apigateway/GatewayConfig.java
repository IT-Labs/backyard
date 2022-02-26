package itlabs.apigateway;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.logging.LogFactory;
import org.springframework.cloud.config.client.ConfigClientProperties;
import org.springframework.cloud.config.client.ConfigClientRequestTemplateFactory;
import org.springframework.cloud.config.client.ConfigServicePropertySourceLocator;
import org.springframework.cloud.gateway.filter.factory.DedupeResponseHeaderGatewayFilterFactory.Strategy;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.route.Route;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.Buildable;
import org.springframework.cloud.gateway.route.builder.PredicateSpec;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import reactor.core.publisher.Mono;

@Configuration
@Slf4j
public class GatewayConfig {

  @Bean
  public ConfigServicePropertySourceLocator configServicePropertySourceLocator(
      ConfigClientProperties clientProperties) {

    ConfigServicePropertySourceLocator configServicePropertySourceLocator =
        new ConfigServicePropertySourceLocator(clientProperties);
    ConfigClientRequestTemplateFactory requestTemplateFactory =
        new ConfigClientRequestTemplateFactory(
            LogFactory.getLog(this.getClass()), clientProperties);
    var restTemplate = requestTemplateFactory.create();
    restTemplate.getInterceptors().add(getInterceptor("token"));
    // restTemplate.setInterceptors(Arrays.asList());
    configServicePropertySourceLocator.setRestTemplate(restTemplate);
    // configServicePropertySourceLocator.setRestTemplate(customRestTemplate("clientProperties"));

    return configServicePropertySourceLocator;
  }

  private RestTemplate customRestTemplate(String jwtToken) {
    Map<String, String> headers = new HashMap<>();
    headers.put("Authorization", "Bearer " + jwtToken);
    var requestFactory = new SimpleClientHttpRequestFactory();
    requestFactory.setReadTimeout((60 * 1000 * 3) + 5000);

    RestTemplate template = new RestTemplate(requestFactory);
    template.setInterceptors(
        Arrays.asList(
            new ConfigClientRequestTemplateFactory.GenericRequestHeaderInterceptor(headers)));
    return template;
  }

  private ClientHttpRequestInterceptor getInterceptor(String jwtToken) {
    Map<String, String> headers = new HashMap<>();
    headers.put("Authorization", "Bearer " + jwtToken);
    return new ConfigClientRequestTemplateFactory.GenericRequestHeaderInterceptor(headers);
  }

  @Bean
  KeyResolver ipKeyResolver() {
    return exchange -> {
      final String host = exchange.getRequest().getURI().getHost();
      return Mono.just(host);
    };
  }

  @Bean
  public RouteLocator internalRoutesLocator(
      RouteLocatorBuilder builder, InternalServiceConfiguration internalServiceConfiguration) {
    return builder
        .routes()
        .route(getItemsRoute(internalServiceConfiguration))
        .route(getPublicRoute(internalServiceConfiguration))
        .build();
  }

  private Function<PredicateSpec, Buildable<Route>> getItemsRoute(
      InternalServiceConfiguration internalServiceConfiguration) {
    log.info(" internal api uri {}", internalServiceConfiguration.getInternalApiUrl());
    final Function<PredicateSpec, Buildable<Route>> predicateSpecAsyncBuilderFunction =
        r ->
            r.path("/items/**")
                .filters(
                    f ->
                        f.rewritePath("/items", "/api/v1/items")
                            .removeRequestHeader("Cookie")
                            .dedupeResponseHeader(
                                "Access-Control-Allow-Headers", Strategy.RETAIN_UNIQUE.toString())
                            .dedupeResponseHeader(
                                "Access-Control-Allow-Origin", Strategy.RETAIN_UNIQUE.toString())
                    // .requestRateLimiter(c ->
                    // c.setRateLimiter(getItemsRateLimiter())).retry(5).fallbackHeaders(
                    // x ->
                    // x.setName("FallbackInternal").setFallbackUri("forward:/fallback/message"))
                    // .hystrix(x ->
                    // x.setName("FallbackInternal").setFallbackUri("forward:/fallback/message"))
                    )
                .uri(internalServiceConfiguration.getInternalApiUrl()) // .id("PublicModule")
        ;
    // forward is not performed due cors issues
    return predicateSpecAsyncBuilderFunction;
  }

  private Function<PredicateSpec, Buildable<Route>> getPublicRoute(
      InternalServiceConfiguration internalServiceConfiguration) {
    final Function<PredicateSpec, Buildable<Route>> predicateSpecAsyncBuilderFunction =
        r ->
            r.path("/home/**")
                .filters(
                    f ->
                        f.rewritePath("/home", "/public/home")
                            .removeRequestHeader("Cookie")
                            .dedupeResponseHeader(
                                "Access-Control-Allow-Headers", Strategy.RETAIN_UNIQUE.toString())
                            .dedupeResponseHeader(
                                "Access-Control-Allow-Origin", Strategy.RETAIN_UNIQUE.toString())
                            .requestRateLimiter(
                                c ->
                                    c.setRateLimiter(getItemsRateLimiter())
                                        .setKeyResolver(ipKeyResolver()))
                            .retry(3)
                    // .hystrix(x ->
                    // x.setName("FallbackPublic").setFallbackUri("forward:/fallback/message"))
                    )
                .uri(internalServiceConfiguration.getInternalApiUrl()) // .id("itemsModule")
        ;
    return predicateSpecAsyncBuilderFunction;
  }

  @Bean
  public RedisRateLimiter getItemsRateLimiter() {
    return new RedisRateLimiter(2, 5);
  }
}
// https://sdoxsee.github.io/blog/2019/12/17/merry-microservices-part2-ui-gateway

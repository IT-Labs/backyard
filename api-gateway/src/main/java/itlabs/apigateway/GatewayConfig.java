package itlabs.apigateway;

import org.springframework.cloud.gateway.filter.factory.DedupeResponseHeaderGatewayFilterFactory.Strategy;
import org.springframework.cloud.gateway.filter.ratelimit.KeyResolver;
import org.springframework.cloud.gateway.filter.ratelimit.RedisRateLimiter;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import reactor.core.publisher.Mono;

@Configuration
public class GatewayConfig {

	@Bean
	KeyResolver ipKeyResolver() {
		return exchange -> {
			final String host = exchange.getRequest().getURI().getHost();
			return Mono.just(host);
		};
	}

	@Bean
	public RouteLocator internalRoutesLocator(RouteLocatorBuilder builder,
			InternalServiceConfiguration internalServiceConfiguration// ,
																		// TokenRelayGatewayFilterFactory
																		// filterFactory
	) {
		final RouteLocator itemsModule = builder.routes()
				.route(r -> r.path("/items/**").filters(f -> f.rewritePath("/items", "/api/v1/items")
						// .filter(filterFactory.apply())
						.removeRequestHeader("Cookie")
						.dedupeResponseHeader("Access-Control-Allow-Headers", Strategy.RETAIN_UNIQUE.toString())
						.dedupeResponseHeader("Access-Control-Allow-Origin", Strategy.RETAIN_UNIQUE.toString())
						.requestRateLimiter((c) -> c.setRateLimiter(getRateLimiter())
						// .setKeyResolver(ipKeyResolver())
						).hystrix(x -> x.setName("Hystrix").setFallbackUri("forward:/fallback/message") // forward
																										// is
																										// not
																										// performed
																										// due
																										// cors
																										// issues
						)).uri(internalServiceConfiguration.getInternalApiUrl()).id("itemsModule")).build();
		return itemsModule;
	}

	@Bean
	public RedisRateLimiter getRateLimiter() {
		return new RedisRateLimiter(1, 1);
	}

}
// https://sdoxsee.github.io/blog/2019/12/17/merry-microservices-part2-ui-gateway
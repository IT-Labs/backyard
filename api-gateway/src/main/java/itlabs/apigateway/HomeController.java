package itlabs.apigateway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.WebSession;
import reactor.core.publisher.Mono;

@RestController
public class HomeController {

	// @GetMapping(value = "/token")
	// public Mono<String> getToken(@RegisteredOAuth2AuthorizedClient
	// OAuth2AuthorizedClient authorizedClient) {
	// return Mono.just(authorizedClient.getAccessToken().getTokenValue());
	// }

	@GetMapping("/")
	public Mono<String> index(WebSession session) {

		return Mono.just(session.getId());
	}

}

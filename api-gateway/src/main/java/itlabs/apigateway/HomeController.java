package itlabs.apigateway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.WebSession;
import reactor.core.publisher.Mono;

@RestController
public class HomeController {

	@GetMapping("/")
	public Mono<String> index(WebSession session) {

		return Mono.just(session.getId());
	}

}

package itlabs.apigateway;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.WebSession;
import reactor.core.publisher.Mono;

@RestController
@Slf4j
public class HomeController {

  private final CloudConfigs configs;

  public HomeController(CloudConfigs configs) {
    this.configs = configs;
  }

  @GetMapping("/")
  public Mono<String> index(WebSession session) {

    return Mono.just(session.getId());
  }

  @GetMapping("/config-location")
  public Mono<String> index() {
    log.info("getting data {}", configs);
    return Mono.just(configs.getLocation());
  }
}

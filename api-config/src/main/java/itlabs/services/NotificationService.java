package itlabs.services;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.config.monitor.PropertyPathEndpoint;
import org.springframework.http.HttpHeaders;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class NotificationService {

	private final PropertyPathEndpoint propertyPathEndpoint;

	public NotificationService(PropertyPathEndpoint propertyPathEndpoint) {
		this.propertyPathEndpoint = propertyPathEndpoint;
	}

	@Async
	public void notifyApplicationsForConfigurationChange(HttpHeaders headers, String applicationName) {
		var result = propertyPathEndpoint.notifyByForm(headers, List.of(applicationName));
		log.debug("notify {} {}", applicationName, result.stream().collect(Collectors.joining(",")));
	}

}

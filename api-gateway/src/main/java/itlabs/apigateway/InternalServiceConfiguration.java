package itlabs.apigateway;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Conditional;
import org.springframework.context.annotation.Configuration;

@Configuration
@Getter
public class InternalServiceConfiguration {

	@Value("${sample.internal-api}")
	private String internalApiUrl;

}

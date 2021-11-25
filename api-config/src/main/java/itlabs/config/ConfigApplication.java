package itlabs.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.monitor.GithubPropertyPathNotificationExtractor;
import org.springframework.cloud.config.server.EnableConfigServer;

@SpringBootApplication
@EnableConfigServer
public class ConfigApplication {

	public static void main(String[] args) {
		SpringApplication.run(ConfigApplication.class, args);
	}
	// https://towardsaws.com/how-to-externalize-spring-boot-properties-to-an-aws-system-manager-parameter-store-2a945b1e856f
	// https://medium.com/trendyol-tech/automating-dynamic-config-management-with-spring-cloud-config-bus-a34e15397b15
	// https://medium.com/swlh/spring-cloud-config-bus-auto-refresh-properties-for-clients-d18fa4c036cb
	// https://blog.marcosbarbero.com/integrating-vault-spring-cloud-config/
	// https://docs.pivotal.io/spring-cloud-services/3-1/config-server/writing-client-applications.html
	// https://www.youtube.com/watch?v=n0kmSftlesE
	// https://www.javainuse.com/spring/cloud-vault
	// https://blog.trifork.com/2018/07/20/integrating-the-aws-parameter-store-with-spring-cloud/
	// https://spencer.gibb.us/blog/2015/09/24/spring-cloud-config-push-notifications/
	// https://zoltanaltfatter.com/2016/06/30/centralized-configuration-with-spring-cloud-config/

}

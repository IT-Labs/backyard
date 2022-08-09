package com.itlabs.api.configuration;

import java.util.HashMap;
import java.util.Map;
import lombok.Getter;
import org.apache.kafka.clients.admin.AdminClientConfig;
import org.apache.kafka.clients.admin.NewTopic;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.KafkaAdmin;

@Configuration
public class KafkaTopicConfig {

  public static final String SAMPLE_TOPIC = "topic-sample";

  @Value(value = "${kafka.bootstrapAddress}")
  @Getter
  private String bootstrapAddress;

  @Bean
  public KafkaAdmin kafkaAdmin() {
    Map<String, Object> configs = new HashMap<>();
    configs.put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapAddress);
    var kafkaAdmin = new KafkaAdmin(configs);

    return kafkaAdmin;
  }

  @Bean
  public NewTopic sampleTopic() {
    return new NewTopic(SAMPLE_TOPIC, 1, (short) 1);
  }
}

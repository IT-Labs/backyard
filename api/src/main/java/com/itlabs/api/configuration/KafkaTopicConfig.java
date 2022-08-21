package com.itlabs.api.configuration;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class KafkaTopicConfig {

  public static final String SAMPLE_TOPIC = "topic-sample";

  @Value(value = "${kafka.bootstrapAddress}")
  @Getter
  private String bootstrapAddress;

  //  @Bean
  //  public KafkaAdmin kafkaAdmin() {
  //    Map<String, Object> configs = new HashMap<>();
  //    configs.put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapAddress);
  //    var kafkaAdmin = new KafkaAdmin(configs);
  //
  //    return kafkaAdmin;
  //  }
  //
  //  @Bean
  //  public NewTopic sampleTopic() {
  //    return new NewTopic(SAMPLE_TOPIC, 1, (short) 1);
  //  }
}

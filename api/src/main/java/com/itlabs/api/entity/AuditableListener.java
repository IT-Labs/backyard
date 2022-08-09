package com.itlabs.api.entity;

import com.itlabs.api.configuration.KafkaTopicConfig;
import com.itlabs.api.iam.IAMService;
import java.time.LocalDateTime;
import javax.persistence.PostPersist;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.SendResult;
import org.springframework.util.concurrent.ListenableFuture;
import org.springframework.util.concurrent.ListenableFutureCallback;

@Slf4j
public class AuditableListener {

  @Autowired IAMService iamService;
  @Autowired KafkaTemplate<String, BaseEntity> entityKafkaTemplate;

  @PrePersist
  protected void onCreate(BaseEntity entity) {
    final LocalDateTime created = LocalDateTime.now();
    entity.setCreated(created);
    entity.setUpdated(created);
    var userID = iamService.getIAMUserIdUUID();
    entity.setCreatedBy(userID);
    entity.setUpdatedBy(userID);
  }

  @PreUpdate
  protected void onUpdate(BaseEntity entity) {
    entity.setUpdated(LocalDateTime.now());
    var userID = iamService.getIAMUserIdUUID();
    entity.setUpdatedBy(userID);
  }

  @PostPersist
  protected void persist(BaseEntity entity) {

    ListenableFuture<SendResult<String, BaseEntity>> future =
        entityKafkaTemplate.send(KafkaTopicConfig.SAMPLE_TOPIC, entity);
    future.addCallback(
        new ListenableFutureCallback<>() {
          @Override
          public void onFailure(Throwable ex) {
            log.error("failed to send item to kafka topic", ex);
          }

          @Override
          public void onSuccess(SendResult<String, BaseEntity> result) {
            log.debug("Item send to kafka topic{}", result.getProducerRecord().value().getGuid());
          }
        });
  }
}

package com.itlabs.api.entity;

import com.itlabs.api.iam.IAMService;
import java.time.LocalDateTime;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import org.springframework.beans.factory.annotation.Autowired;

public class AuditableListener {

  @Autowired IAMService iamService;

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
}

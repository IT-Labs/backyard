package com.itlabs.api.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.itlabs.api.common.GlobalConstants;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Type;

@Getter
@Setter
@MappedSuperclass
public class BaseEntity {
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer id;

  @Column(nullable = false)
  @Type(type = "pg-uuid")
  private UUID guid;

  @JsonFormat(pattern = GlobalConstants.DATE_FORMAT)
  @Column(nullable = false)
  private LocalDateTime updated;

  @JsonFormat(pattern = GlobalConstants.DATE_FORMAT)
  @Column(nullable = false)
  private LocalDateTime created;

  @PrePersist
  protected void onCreate() {
    setCreated(LocalDateTime.now());
    setUpdated(LocalDateTime.now());
  }

  @PreUpdate
  protected void onUpdate() {
    setUpdated(LocalDateTime.now());
  }
}

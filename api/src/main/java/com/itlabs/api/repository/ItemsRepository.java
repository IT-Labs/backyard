package com.itlabs.api.repository;

import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemStatus;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface ItemsRepository extends JpaRepository<Items, Integer> {

  Optional<Items> findByGuid(UUID uuid);

  @Modifying
  @Query("DELETE FROM Items i WHERE i.guid = :guid")
  void deleteByGuid(UUID guid);

  Page<Items> findByIsPublicTrueAndStatus(Pageable pageable, ItemStatus status);

  Page<Items> findByNameStartsWithAndStatus(Pageable pageable, String name, ItemStatus status);

  Page<Items> findByStatus(Pageable pageable, ItemStatus status);

  Page<Items> findByNameStartsWith(Pageable pageable, String name);
}

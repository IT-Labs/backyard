package com.itlabs.api.repository;

import com.itlabs.api.entity.Items;
import java.util.Optional;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface ItemsRepository extends JpaRepository<Items, Integer> {

	Optional<Items> findByGuid(UUID uuid);

	@Modifying
	@Query("DELETE FROM Items i WHERE i.guid = :guid")
	void deleteByGuid(UUID guid);

}

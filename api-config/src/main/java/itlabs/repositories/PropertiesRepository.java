package itlabs.repositories;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface PropertiesRepository extends JpaRepository<Property, Integer> {

	Optional<Property> findByGuid(UUID uuid);

	@Modifying
	@Query("DELETE FROM Property i WHERE i.guid = :guid")
	void deleteByGuid(UUID guid);

	Page<Property> findByApplication(Pageable pageable, String application);

}

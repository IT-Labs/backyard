package itlabs.repositories;

import java.util.Optional;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PropertiesRepository extends JpaRepository<Property, Integer> {

  Optional<Property> findByGuid(UUID uuid);

  void deleteByGuid(UUID guid);

  Page<Property> findByApplication(Pageable pageable, String application);
}

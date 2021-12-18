package itlabs.repositories;

import java.time.LocalDateTime;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;

public class AuditableListener {

	@PrePersist
	protected void onCreate(BaseEntity entity) {
		final LocalDateTime created = LocalDateTime.now();
		entity.setCreated(created);
		entity.setUpdated(created);

	}

	@PreUpdate
	protected void onUpdate(BaseEntity entity) {
		entity.setUpdated(LocalDateTime.now());
	}

}

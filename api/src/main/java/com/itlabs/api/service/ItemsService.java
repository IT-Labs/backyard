package com.itlabs.api.service;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.models.ItemStatus;
import java.util.List;
import java.util.UUID;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ItemsService {

	ItemModel get(UUID uuid);

	Page<ItemModel> get(Pageable pageable, String name, ItemStatus status);

	ItemModel save(ItemEditModel model);

	ItemModel update(UUID uuid, ItemEditModel model);

	void delete(UUID uuid);

	List<ItemModel> getPublicPublishedItems(Pageable pageable);

}

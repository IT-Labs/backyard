package com.itlabs.api.service;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface ItemsService {
  ItemModel get(Integer id);

  Page<ItemModel> get(Pageable pageable);

  ItemModel save(ItemEditModel model);

  ItemModel update(int id, ItemEditModel model);

  void delete(int id);
}

package com.itlabs.api.service;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import java.util.List;
import org.springframework.data.domain.Pageable;

public interface ItemService {
  ItemModel get(Integer id);

  List<ItemModel> get(Pageable pageable);

  ItemModel save(ItemEditModel model);

  ItemModel update(int id, ItemEditModel model);

  void delete(int id);
}

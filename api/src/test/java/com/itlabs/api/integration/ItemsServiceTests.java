package com.itlabs.api.integration;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemsService;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;

public class ItemsServiceTests extends BaseIntegration {
  @Autowired private ItemsService itemsService;

  @Test
  public void ItemGetTest() {
    final int itemsCount = 10;
    seedItemsInDatabase(itemsCount);

    var result = itemsService.get(Pageable.unpaged());

    Assertions.assertNotNull(result);
    Assertions.assertTrue(result.size() >= itemsCount);
  }

  @Test
  public void ItemSaveTest() {

    ItemEditModel item = getItemEditModel();
    var result = itemsService.save(item);

    Assertions.assertNotNull(result);
    Assertions.assertTrue(result.getId() > 0);
    Assertions.assertEquals(item.getDescription(), result.getDescription());
    Assertions.assertEquals(item.getName(), result.getName());
    Assertions.assertEquals(item.getStatus(), result.getStatus());
  }

  private ItemEditModel getItemEditModel() {
    return new ItemEditModel("Test", ItemStatus.DRAFT, "description");
  }
}

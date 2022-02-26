package com.itlabs.api.integration;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemsService;
import org.junit.jupiter.api.MethodOrderer.Alphanumeric;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;

@TestMethodOrder(Alphanumeric.class)
public class ItemsServiceTests extends BaseIntegration {

  private final ItemsService itemsService;

  @Autowired
  ItemsServiceTests(ItemsService itemsService) {

    super(null);
    this.itemsService = itemsService;
  }

  @Test
  public void ItemGetTest() {
    final int itemsCount = 10;
    seedItemsInDatabase(itemsCount);

    var result = itemsService.get(Pageable.unpaged(), "", null);
    assertNotNull(result);
    assertTrue(result.getTotalElements() >= itemsCount);
  }

  @Test
  void ItemSaveTest() {

    ItemEditModel item = getItemEditModel();
    var result = itemsService.save(item);

    assertNotNull(result);
    assertNotNull(result.getId());
    assertEquals(item.getDescription(), result.getDescription());
    assertEquals(item.getName(), result.getName());
    assertEquals(item.getStatus(), result.getStatus());
  }

  private ItemEditModel getItemEditModel() {
    return new ItemEditModel("Test", ItemStatus.DRAFT, "description", false);
  }
}

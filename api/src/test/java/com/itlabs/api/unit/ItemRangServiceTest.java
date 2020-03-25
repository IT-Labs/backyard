package com.itlabs.api.unit;

import com.itlabs.api.entity.Item;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemRangServiceImpl;
import java.time.LocalDateTime;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class ItemRangServiceTest {

  @Test
  public void rangServiceForDraftTest() {
    var rangService = new ItemRangServiceImpl();
    var item = getItem();
    var result = rangService.getRang(item);
    Assertions.assertEquals(2, result);
  }

  @Test
  public void rangServiceForInProgressTest() {
    var rangService = new ItemRangServiceImpl();
    var item = getItem();
    item.setStatus(ItemStatus.IN_PROGRESS);
    var result = rangService.getRang(item);
    Assertions.assertTrue(result > 2);
  }

  private Item getItem() {
    var item = new Item();
    item.setStatus(ItemStatus.DRAFT);
    item.setCreated(LocalDateTime.now());
    return item;
  }
}

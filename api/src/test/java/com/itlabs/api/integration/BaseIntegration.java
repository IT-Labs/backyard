package com.itlabs.api.integration;

import com.github.javafaker.Faker;
import com.itlabs.api.ApiApplication;
import com.itlabs.api.entity.Item;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.repository.ItemRepository;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@SpringBootTest(
    webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
    classes = {ApiApplication.class, TestContainerConfiguration.class})
class BaseIntegration {

  @Autowired private ItemRepository itemRepository;
  private Faker faker = new Faker();

  protected void seedItemsInDatabase(int itemsCount) {
    List<Item> items =
        IntStream.range(0, itemsCount)
            .boxed()
            .map(
                x -> {
                  var item = new Item();
                  item.setName(faker.funnyName().name());
                  item.setDescription(faker.lorem().sentence(x * 2));
                  item.setStatus(ItemStatus.DRAFT);
                  item.setType(faker.animal().name());
                  return item;
                })
            .collect(Collectors.toList());
    itemRepository.saveAll(items);
  }
}

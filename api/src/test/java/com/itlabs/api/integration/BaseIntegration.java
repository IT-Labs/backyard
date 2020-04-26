package com.itlabs.api.integration;

import com.github.javafaker.Faker;
import com.itlabs.api.ApiApplication;
import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.repository.ItemsRepository;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.ResultActions;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@SpringBootTest(
    webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
    classes = {ApiApplication.class, TestContainerConfiguration.class})
@AutoConfigureMockMvc
class BaseIntegration {

  @Autowired private ItemsRepository itemRepository;
  private Faker faker = new Faker();

  protected void seedItemsInDatabase(int itemsCount) {
    List<Items> items =
        IntStream.range(0, itemsCount)
            .boxed()
            .map(
                x -> {
                  var item = new Items();
                  item.setName(faker.funnyName().name());
                  item.setDescription(faker.lorem().sentence(x * 2));
                  item.setStatus(ItemStatus.DRAFT);
                  item.setType(faker.animal().name());
                  return item;
                })
            .collect(Collectors.toList());
    itemRepository.saveAll(items);
  }

    protected  void validateBadRequest(ResultActions resultActions) throws Exception {
        resultActions
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").exists())
                .andExpect(jsonPath("$.code").exists());
    }
}

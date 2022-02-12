package com.itlabs.api.integration;

import static org.hamcrest.Matchers.equalTo;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.itlabs.api.controllers.Routes;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemsService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;

public class HomeControllerTests extends BaseIntegration {

  private final ItemsService itemsService;

  @Autowired
  public HomeControllerTests(MockMvc mvc, ItemsService itemsService) {
    super(mvc);
    this.itemsService = itemsService;
  }

  @Test
  void itemsAuthorizedGetTest() throws Exception {
    sampleData();
    final var resultActions =
        mvc.perform(getAuthorizationBuilder(get(Routes.HOME_ROUTE + "/items")))
            .andDo(print())
            .andExpect(status().isOk());

    validate(resultActions);
  }

  @Test
  void itemsUnAuthorizedGetTest() throws Exception {
    sampleData();
    final var resultActions =
        mvc.perform(get(Routes.HOME_ROUTE + "/items")).andDo(print()).andExpect(status().isOk());

    validate(resultActions);
  }

  private void validate(ResultActions resultActions) throws Exception {
    resultActions
        .andExpect(content().contentType("application/json"))
        .andExpect(jsonPath("$").isArray())
        .andExpect(jsonPath("$.length()", equalTo(5)));
    for (int i = 0; i < 5; i++) {
      String id = "$[" + i + "].";
      resultActions
          .andExpect(jsonPath(id + "publiclyAvailable").value("true"))
          .andExpect(jsonPath(id + "published").isNotEmpty());
    }
  }

  private void sampleData() {
    final int itemsCount = 10;
    this.seedItemsInDatabase(15).stream()
        .skip(6)
        .forEach(
            x -> {
              ItemEditModel model =
                  new ItemEditModel(x.getName(), ItemStatus.DONE, x.getDescription(), x.isPublic());
              itemsService.update(x.getGuid(), model);
            });
    ;
    this.seedItemsInDatabase(itemsCount, true).stream()
        .skip(3)
        .forEach(
            x -> {
              ItemEditModel model =
                  new ItemEditModel(x.getName(), ItemStatus.DONE, x.getDescription(), x.isPublic());
              itemsService.update(x.getGuid(), model);
            });
  }
}

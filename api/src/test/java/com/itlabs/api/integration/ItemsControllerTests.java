package com.itlabs.api.integration;

import com.itlabs.api.common.Utill;
import com.itlabs.api.controllers.Routes;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemsService;
import io.swagger.models.auth.In;
import org.junit.jupiter.api.MethodOrderer.Alphanumeric;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import static org.hamcrest.Matchers.greaterThan;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@TestMethodOrder(Alphanumeric.class)
public class ItemsControllerTests extends BaseIntegration{

    private  MockMvc mvc;
    private final ItemsService itemsService;

    @Autowired
    public ItemsControllerTests(MockMvc mvc, ItemsService  itemsService){
        this.mvc = mvc;
        this.itemsService = itemsService;
    }

    @Test
    public void itemsGetTest() throws Exception {
        final int itemsCount = 5;
        this.seedItemsInDatabase(itemsCount);

        final var resultActions = mvc.perform(get(Routes.ITEMS_ROUTE).contentType(MediaType.APPLICATION_JSON))
                .andDo(print())
                .andExpect(status().isOk());

        resultActions
                .andExpect(content().contentType("application/json"))
                .andExpect(jsonPath("$.content").isArray())
                .andExpect(jsonPath("$.content.length()",greaterThan(itemsCount-1)))
                .andExpect(jsonPath("$.pageable.pageSize").value("20"))
                .andExpect(jsonPath("$.totalElements",greaterThan(itemsCount-1)))
        ;
    }

    @Test
    public void itemsPostSuccessTest() throws Exception {
        ItemEditModel model =
                new ItemEditModel("testPost", ItemStatus.DRAFT, "test description");

        final var resultActions = mvc.perform(
                post(Routes.ITEMS_ROUTE)
                        .content(Utill.asJsonString(model))
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print());

        validateItem(model, resultActions);
    }

    @Test
    public void itemsPostWrongStatusTest() throws Exception {
        ItemEditModel model =
                new ItemEditModel("testPost", ItemStatus.DRAFT, "test description");
        final var resultActions = mvc.perform(
                post(Routes.ITEMS_ROUTE)
                        .content(Utill.asJsonString(model).toLowerCase())
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print());

        validateBadRequest(resultActions);
    }
    @Test
    public void itemsPostEmptyBodyTest() throws Exception {
        final var resultActions = mvc.perform(
                post(Routes.ITEMS_ROUTE)
                        .content("")
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print());

        validateBadRequest(resultActions);
    }
    @Test
    public void itemsPostEmptyObjectTest() throws Exception {
        final var resultActions = mvc.perform(
                post(Routes.ITEMS_ROUTE)
                        .content("{}")
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print());

        validateBadRequest(resultActions);
    }




    @Test
    public void itemsPutSuccessTest() throws Exception {
        var model =
                new ItemEditModel("testEditPost", ItemStatus.DRAFT, "test edit description");
      var saved = itemsService.save(model);
        var edit =
                new ItemEditModel("modified ", ItemStatus.IN_PROGRESS, "modified description");

        final var resultActions = mvc.perform(
                put(Routes.ITEMS_ROUTE + "/" + saved.getId())
                        .content(Utill.asJsonString(edit))
                        .contentType(MediaType.APPLICATION_JSON))
                .andDo(print());

        validateItem(edit, resultActions);
    }

    private void validateItem(ItemEditModel model, ResultActions resultActions) throws Exception {
        resultActions
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").exists())
                .andExpect(jsonPath("$.name").value(model.getName()))
                .andExpect(jsonPath("$.status").value(model.getStatus().toString()))
                .andExpect(jsonPath("$.description").value(model.getDescription()));
    }

}

package com.itlabs.api.integration;

import com.itlabs.api.common.Utils;
import com.itlabs.api.controllers.Routes;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.service.ItemsService;
import java.util.UUID;
import org.junit.jupiter.api.MethodOrderer.Alphanumeric;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import static org.hamcrest.Matchers.greaterThan;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@TestMethodOrder(Alphanumeric.class)
public class ItemsControllerTests extends BaseIntegration {

	private final MockMvc mvc;

	private final ItemsService itemsService;

	@Autowired
	ItemsControllerTests(MockMvc mvc, ItemsService itemsService) {
		this.mvc = mvc;
		this.itemsService = itemsService;
	}

	@Test
	void itemsGetTest() throws Exception {
		final int itemsCount = 5;
		this.seedItemsInDatabase(itemsCount);

		final var resultActions = mvc.perform(get(Routes.ITEMS_ROUTE).contentType(MediaType.APPLICATION_JSON))
				.andDo(print()).andExpect(status().isOk());

		resultActions.andExpect(content().contentType("application/json")).andExpect(jsonPath("$.content").isArray())
				.andExpect(jsonPath("$.content.length()", greaterThan(itemsCount - 1)))
				.andExpect(jsonPath("$.pageable.pageSize").value("20"))
				.andExpect(jsonPath("$.totalElements", greaterThan(itemsCount - 1)));
	}

	@Test
	void itemsPostSuccessTest() throws Exception {
		ItemEditModel model = new ItemEditModel("testPost", ItemStatus.DRAFT, "test description");

		final var resultActions = mvc.perform(
				post(Routes.ITEMS_ROUTE).content(Utils.asJsonString(model)).contentType(MediaType.APPLICATION_JSON))
				.andDo(print());

		validateItem(model, resultActions);
	}

	@Test
	void itemsPostWrongStatusTest() throws Exception {
		ItemEditModel model = new ItemEditModel("testPost", ItemStatus.DRAFT, "test description");
		final var resultActions = mvc.perform(post(Routes.ITEMS_ROUTE).content(Utils.asJsonString(model).toLowerCase())
				.contentType(MediaType.APPLICATION_JSON)).andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemsPostEmptyBodyTest() throws Exception {
		final var resultActions = mvc
				.perform(post(Routes.ITEMS_ROUTE).content("").contentType(MediaType.APPLICATION_JSON)).andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemsPostEmptyObjectTest() throws Exception {
		final var resultActions = mvc
				.perform(post(Routes.ITEMS_ROUTE).content("{}").contentType(MediaType.APPLICATION_JSON)).andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemsPutSuccessTest() throws Exception {
		var model = new ItemEditModel("testEditPost", ItemStatus.DRAFT, "test edit description");
		var saved = itemsService.save(model);
		var edit = new ItemEditModel("modified ", ItemStatus.IN_PROGRESS, "modified description");

		final var resultActions = mvc.perform(put(getEditUrl(saved.getId())).content(Utils.asJsonString(edit))
				.contentType(MediaType.APPLICATION_JSON)).andDo(print());

		validateItem(edit, resultActions);
	}

	@Test
	void itemsDeleteSuccessTest() throws Exception {
		var model = new ItemEditModel("testDeletePost", ItemStatus.DRAFT, "test delete");
		var saved = itemsService.save(model);
		final var resultActions = mvc.perform(delete(getEditUrl(saved.getId())).contentType(MediaType.APPLICATION_JSON))
				.andDo(print());

		resultActions.andExpect(status().isNoContent());
	}

	@Test
	void itemsDeleteWrongIdTest() throws Exception {

		final var resultActions = mvc
				.perform(delete(getEditUrl(UUID.randomUUID().toString())).contentType(MediaType.APPLICATION_JSON))
				.andDo(print());
		resultActions.andExpect(status().isNoContent());
	}

	@Test
	void itemsWrongIdTypeTest() throws Exception {

		final var resultActions = mvc.perform(delete(getEditUrl("5")).contentType(MediaType.APPLICATION_JSON))
				.andDo(print());

		resultActions.andExpect(status().is4xxClientError());
	}

	private String getEditUrl(String uuid) {
		return Routes.ITEMS_ROUTE + "/" + uuid;
	}

	private void validateItem(ItemEditModel model, ResultActions resultActions) throws Exception {
		resultActions.andExpect(status().isCreated()).andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.name").value(model.getName()))
				.andExpect(jsonPath("$.status").value(model.getStatus().toString()))
				.andExpect(jsonPath("$.description").value(model.getDescription()));
	}

}

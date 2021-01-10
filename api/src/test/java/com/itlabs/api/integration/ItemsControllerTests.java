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
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
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

	public static final String UUID = java.util.UUID.randomUUID().toString();

	private final ItemsService itemsService;

	@Autowired
	ItemsControllerTests(MockMvc mvc, ItemsService itemsService) {
		super(mvc);
		this.itemsService = itemsService;
	}

	@Test
	void itemsGetTest() throws Exception {
		final int itemsCount = 5;
		this.seedItemsInDatabase(itemsCount);

		final var resultActions = mvc.perform(getAuthorizationBuilder(get(Routes.ITEMS_ROUTE))).andDo(print())
				.andExpect(status().isOk());

		resultActions.andExpect(content().contentType("application/json")).andExpect(jsonPath("$.content").isArray())
				.andExpect(jsonPath("$.content.length()", greaterThan(itemsCount - 1)))
				.andExpect(jsonPath("$.pageable.pageSize").value("20"))
				.andExpect(jsonPath("$.totalElements", greaterThan(itemsCount - 1)));
	}

	@Test
	void itemsPostSuccessTest() throws Exception {
		ItemEditModel model = new ItemEditModel("testPost", ItemStatus.DRAFT, "test description", false);

		final var resultActions = mvc
				.perform(getAuthorizationBuilder(post(Routes.ITEMS_ROUTE)).content(Utils.asJsonString(model)))
				.andDo(print());

		validateItem(model, resultActions);
	}

	@Test
	void itemsPostWrongStatusTest() throws Exception {
		ItemEditModel model = new ItemEditModel("testPost", ItemStatus.DRAFT, "test description", false);
		final var resultActions = mvc.perform(
				getAuthorizationBuilder(post(Routes.ITEMS_ROUTE)).content(Utils.asJsonString(model).toLowerCase()))
				.andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemsPostEmptyBodyTest() throws Exception {
		final var resultActions = mvc.perform(getAuthorizationBuilder(post(Routes.ITEMS_ROUTE)).content(""))
				.andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemsPostEmptyObjectTest() throws Exception {
		final var resultActions = mvc.perform(getAuthorizationBuilder(post(Routes.ITEMS_ROUTE)).content("{}"))
				.andDo(print());

		validateBadRequest(resultActions);
	}

	@Test
	void itemPublishSuccessTest() throws Exception {
		var model = new ItemEditModel("testEditPost", ItemStatus.DRAFT, "test edit description", false);
		var saved = itemsService.save(model);
		var edit = new ItemEditModel("modified ", ItemStatus.DONE, "modified description", true);

		final var resultActions = mvc
				.perform(getAuthorizationBuilder(put(getEditUrl(saved.getId()))).content(Utils.asJsonString(edit)))
				.andDo(print());

		validateItem(edit, resultActions);
		resultActions.andExpect(jsonPath("$.published").isNotEmpty());
	}

	@Test
	void itemUnPublishSuccessTest() throws Exception {
		var model = new ItemEditModel("itemUnPublishSuccessTest", ItemStatus.DRAFT, "test edit description", false);
		var saved = itemsService.save(model);
		itemsService.update(java.util.UUID.fromString(saved.getId()),
				new ItemEditModel("itemUnPublishSuccessTest ", ItemStatus.DONE, "modified description", false));
		var edit = new ItemEditModel("itemUnPublishSuccessTest ", ItemStatus.IN_PROGRESS, "modified description",
				false);
		final var resultActions = mvc
				.perform(getAuthorizationBuilder(put(getEditUrl(saved.getId()))).content(Utils.asJsonString(edit)))
				.andDo(print());

		validateItem(edit, resultActions);
		resultActions.andExpect(jsonPath("$.published").isEmpty());
	}

	@Test
	void itemsDeleteSuccessTest() throws Exception {
		var model = new ItemEditModel("testDeletePost", ItemStatus.DRAFT, "test delete", false);
		var saved = itemsService.save(model);
		final var resultActions = mvc.perform(getAuthorizationBuilder(delete(getEditUrl(saved.getId()))))
				.andDo(print());

		resultActions.andExpect(status().isNoContent());
	}

	@Test
	void itemsDeleteWrongIdTest() throws Exception {

		final var resultActions = mvc
				.perform(getAuthorizationBuilder(delete(getEditUrl(java.util.UUID.randomUUID().toString()))))
				.andDo(print());
		resultActions.andExpect(status().isNoContent());
	}

	@Test
	void itemsWrongIdTypeTest() throws Exception {

		final var resultActions = mvc.perform(getAuthorizationBuilder(delete(getEditUrl("789878hg")))).andDo(print());

		resultActions.andExpect(status().is4xxClientError());
	}

	@Test
	void securityGetItemsTest() throws Exception {
		securityTest(get(Routes.ITEMS_ROUTE));
	}

	@Test
	void securityPostItemsTest() throws Exception {
		securityTest(post(getEditUrl(UUID)));
	}

	@Test
	void securityPutItemsTest() throws Exception {
		securityTest(put(getEditUrl(UUID)));
	}

	@Test
	void securityDeleteItemsTest() throws Exception {
		securityTest(delete(getEditUrl(UUID)));
	}

	private String getEditUrl(String uuid) {
		return Routes.ITEMS_ROUTE + "/" + uuid;
	}

	private void validateItem(ItemEditModel model, ResultActions resultActions) throws Exception {
		resultActions.andExpect(status().isCreated()).andExpect(jsonPath("$.id").exists())
				.andExpect(jsonPath("$.name").value(model.getName()))
				.andExpect(jsonPath("$.status").value(model.getStatus().toString()))
				.andExpect(jsonPath("$.publiclyAvailable").value(model.getPubliclyAvailable().toString()))
				.andExpect(jsonPath("$.description").value(model.getDescription()));
	}

}

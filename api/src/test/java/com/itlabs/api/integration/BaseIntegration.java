package com.itlabs.api.integration;

import com.github.javafaker.Faker;
import com.itlabs.api.ApiApplication;
import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemStatus;
import com.itlabs.api.repository.ItemsRepository;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
import org.junit.jupiter.api.extension.ExtendWith;
import org.keycloak.admin.client.Keycloak;
import org.keycloak.admin.client.KeycloakBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import static com.itlabs.api.integration.TestContainerConfiguration.KEYCLOAK_CONTAINER;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT,
		classes = { ApiApplication.class, TestContainerConfiguration.class })

@AutoConfigureMockMvc
@ActiveProfiles("test")
class BaseIntegration {

	protected final MockMvc mvc;

	@Autowired
	ItemsRepository itemRepository;

	private final Faker faker = new Faker();

	public BaseIntegration(MockMvc mvc) {
		this.mvc = mvc;
	}

	protected List<Items> seedItemsInDatabase(int itemsCount) {
		return seedItemsInDatabase(itemsCount, false);
	}

	protected List<Items> seedItemsInDatabase(int itemsCount, boolean isPublic) {
		List<Items> items = IntStream.range(0, itemsCount).boxed().map(x -> {
			var item = new Items();
			item.setName(faker.funnyName().name());
			item.setDescription(faker.lorem().sentence(x * 2));
			item.setStatus(ItemStatus.DRAFT);
			item.setGuid(UUID.randomUUID());
			item.setType(faker.animal().name());
			item.setPublic(isPublic);
			return item;
		}).collect(Collectors.toList());
		return itemRepository.saveAll(items);
	}

	protected void validateBadRequest(ResultActions resultActions) throws Exception {
		resultActions.andExpect(status().isBadRequest()).andExpect(jsonPath("$.message").exists())
				.andExpect(jsonPath("$.code").exists());
	}

	protected void securityTest(MockHttpServletRequestBuilder put) throws Exception {
		mvc.perform(put).andDo(print()).andExpect(status().is3xxRedirection());
	}

	Keycloak keycloakAdminClient;

	private String getToken() {
		if (keycloakAdminClient == null) {
			keycloakAdminClient = KeycloakBuilder.builder().serverUrl(KEYCLOAK_CONTAINER.getAuthServerUrl())
					.realm("realm-sample").clientId("sample-client").username("sample").password("sample").build();
		}
		String token = keycloakAdminClient.tokenManager().getAccessToken().getToken();
		return token;
	}

	protected MockHttpServletRequestBuilder getAuthorizationBuilder(
			MockHttpServletRequestBuilder mockHttpServletRequestBuilder) {
		return mockHttpServletRequestBuilder.header("Authorization", "Bearer " + getToken())
				.contentType(MediaType.APPLICATION_JSON);
	}

}

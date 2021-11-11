package com.itlabs.api.controllers;

import com.itlabs.api.configuration.ApiPageable;
import com.itlabs.api.configuration.CloudConfigs;
import com.itlabs.api.entity.Items;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.service.ItemsService;
import io.swagger.annotations.Api;
import java.util.List;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Mono;

@RestController
@Api
@RequestMapping(Routes.HOME_ROUTE)
@Slf4j
public class HomeController {

	private final ItemsService itemsService;

	private final CloudConfigs configs;

	public HomeController(ItemsService itemsService, CloudConfigs configs) {
		this.itemsService = itemsService;
		this.configs = configs;
	}

	@GetMapping(value = "/items")
	@ApiPageable
	public List<ItemModel> getTopItems() {
		return itemsService.getPublicPublishedItems(PageRequest.of(0, 5, Sort.by("published")));
	}

	@GetMapping("/config-location")
	public String index() {
		return configs.getLocation();
	}

}

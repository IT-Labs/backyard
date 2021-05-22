package com.itlabs.api.controllers;

import com.itlabs.api.configuration.ApiPageable;
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

@RestController
@Api
@RequestMapping(Routes.HOME_ROUTE)
@Slf4j
public class HomeController {

	private final ItemsService itemsService;

	public HomeController(ItemsService itemsService) {
		this.itemsService = itemsService;
	}

	@GetMapping(value = "/items")
	@ApiPageable
	public List<ItemModel> getTopItems() {
		return itemsService.getPublicPublishedItems(PageRequest.of(0, 5, Sort.by("published")));
	}

}

package com.itlabs.api.controllers;

import com.itlabs.api.configuration.ApiPageable;
import com.itlabs.api.models.ItemEditModel;
import com.itlabs.api.models.ItemModel;
import com.itlabs.api.service.ItemsService;
import io.swagger.annotations.Api;
import java.util.Map;
import java.util.UUID;
import lombok.extern.slf4j.Slf4j;
import org.keycloak.KeycloakPrincipal;
import org.keycloak.adapters.springsecurity.token.KeycloakAuthenticationToken;
import org.keycloak.representations.AccessToken;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

@RestController
@Api
@RequestMapping(Routes.ITEMS_ROUTE)
@Slf4j
// @PreAuthorize("hasAuthority('SCOPE_user')")
public class ItemsController {

	private final ItemsService itemsService;

	public ItemsController(ItemsService itemsService) {
		this.itemsService = itemsService;
	}

	@GetMapping()
	@ApiPageable
	public Page<ItemModel> get(@ApiIgnore Pageable pageable) {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		log.info("Scopes: " + authentication.getAuthorities());
		return itemsService.get(pageable);
	}

	@PostMapping()
	public ResponseEntity<ItemModel> post(@RequestBody @Validated ItemEditModel model) {
		return new ResponseEntity<>(itemsService.save(model), HttpStatus.CREATED);
	}

	@GetMapping(path = "/{id}")
	public ResponseEntity<ItemModel> getItem(@PathVariable("id") UUID id) {
		return new ResponseEntity<>(itemsService.get(id), HttpStatus.OK);
	}

	@PutMapping(path = "/{id}")
	public ResponseEntity<ItemModel> put(@PathVariable("id") UUID id, @RequestBody ItemEditModel model) {
		return new ResponseEntity<>(itemsService.update(id, model), HttpStatus.CREATED);
	}

	@DeleteMapping(path = "/{id}")
	public ResponseEntity<String> delete(@PathVariable("id") UUID id) {
		itemsService.delete(id);
		return new ResponseEntity<>("deleted", HttpStatus.NO_CONTENT);
	}

}

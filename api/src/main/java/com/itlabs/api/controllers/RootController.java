package com.itlabs.api.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import springfox.documentation.annotations.ApiIgnore;

@RestController
@ApiIgnore
public class RootController {

	@GetMapping(value = "/")
	public ResponseEntity<String> get() {
		return ResponseEntity.ok("Welcome to sample api");
	}

}
